// ignore_for_file: library_prefixes

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio_instance;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shypie/src/modules/create_account/models/user_model.dart';
import 'package:shypie/src/utils/widgets/dialog.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../../general_controllers/general_controller.dart';
import '../../../services/get_service.dart';
import '../../../services/post_service.dart';
import '../../../services/urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets/image_picker.dart';
import '../models/chat_message.dart';

class ChatScreenLogic extends GetxController {
  ScrollController scrollController = ScrollController();
  List<String> messages = [];
  TextEditingController messageTextField = TextEditingController();
  User userModel = User();
  int page = 1;
  late IO.Socket socket;
  String chatId = '';
  List<ChatMessagesModel> chatMessages = [];
  bool isLastPage = false;
  String? selectedWidgetId;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      userModel = Get.arguments[0];
      chatId = Get.arguments[1];
    }

    //________________________________________
    initSocket();
    //________________________________________
    getChat();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (isLastPage) return;
        page = page + 1;
        getMethod('$chatMessageUrl/$chatId', {'page': page, 'size': 10},
            (bool responseCheck, Map<String, dynamic> response) {
          print(responseCheck);
          if (responseCheck) {
            update();
            if (response['data'] != null) {
              List<ChatMessagesModel> chat = [];
              response['data'].forEach((v) {
                chat.add(ChatMessagesModel.fromJson(v));
              });
              chatMessages = [
                ...chat,
                ...chatMessages,
              ];
              if (chatMessages.length >= response['meta']['total_documents']) {
                isLastPage = true;
              }
            }
            return;
          }
          List<String> errors = [];
          if (response['errors'] != null) {
            errors =
                List<String>.from(response['errors'].map((x) => x["detail"]));
            if (errors.isNotEmpty) ResponseDialog.showError(errors[0]);
          }
        }, authHeader: true);
      }
    });
  }

  //****************************************************************

  getChat() {
    getMethod(
        '$chatMessageUrl/$chatId', {'page': page, 'size': 10}, getChatsHandle,
        authHeader: true);
  }

  //****************************************************************
  getChatsHandle(bool responseCheck, Map<String, dynamic> response) {
    if (responseCheck) {
      if (response['data'] != null) {
        response['data'].forEach((v) {
          chatMessages.add(ChatMessagesModel.fromJson(v));
        });

        chatMessages.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        update();
      }
      return;
    }
    List<String> errors = [];
    if (response['errors'] != null) {
      errors = List<String>.from(response['errors'].map((x) => x["detail"]));
      if (errors.isNotEmpty) ResponseDialog.showError(errors[0]);
    }
  }

  @override
  void onClose() {
    log('dispose');
    socket.close();
    super.onClose();
  }

  //*****************************************************************

  initSocket() {
    socket = IO.io(
        'https://shypie.codecoytechnologies.live/',
        OptionBuilder()
            .setTransports(["websocket"])
            .setExtraHeaders({'Connection': 'upgrade', 'Upgrade': 'websocket'})
            .disableAutoConnect()
            .build());
    socket.connect();
    socket.emit("signin", userModel.uId);
    socket.onConnect((_) {
      log('Connection established');
      socket.on('message', (data) {
        log('********** message On ****************');
        if (data['sender'] != Get.find<GeneralController>().userModel.uId) {
          log('********** message On Not sender ****************');
          chatMessages.add(ChatMessagesModel.fromJson(data));
        }
        log('********** message On sender ****************');
        update();
      });
    });

    socket.onDisconnect((_) => log('Connection Disconnection'));
    socket.onConnectError((err) => print('onConnectError $err'));
    socket.onError((err) => print('onError$err'));
  }

  //*******************************************
  getImage() async {
    File? image = await kImagePicker(Get.context!);
    if (image != null) {
      dio_instance.FormData formData = await uploadFileFormData(image.path);
      await postMethod(uploadFile, formData,
          (bool responseCheck, Map<String, dynamic> response) {
        if (responseCheck) {
         messageTextField.text= response['file']["filename"];
          sendMessage(type: ChatType.image.name);
          return;
        }
      });
    }
  }

  //************************************************

  sendMessage({ String? type}) {
    if(messageTextField.text.isEmpty)return;
    Future.delayed(
      const Duration(milliseconds: 500),
      () => Get.find<GeneralController>().changeLoaderCheck(false),
    );
    postMethod(chatMessageUrl, {
      'conversation': chatId,
      'receiver': userModel.uId,
      'message': messageTextField.text,
      "type": type ?? ChatType.text.name,
      "senderName": Get.find<GeneralController>().userModel.name,
      "senderImage": Get.find<GeneralController>().userModel.profileImage
    }, (bool responseCheck, Map<String, dynamic> response) {
      if (responseCheck) {
        if (response['data'] != null) {
          chatMessages.add(ChatMessagesModel.fromJson(response['data']));

          socket.emit("message", response['data']);
          messageTextField.clear();
          update();
          _handleMessage(messageTextField.text);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollController.position.minScrollExtent);
          });
          update();
        }
        return;
      }
      List<String> errors = [];
      if (response['errors'] != null) {
        errors = List<String>.from(response['errors'].map((x) => x["detail"]));
        if (errors.isNotEmpty) ResponseDialog.showError(errors[0]);
      }
    }, authHeader: true);
  }

  bool showAdminMessage = true;

  void _handleMessage(String message) {
    messageTextField.clear();
    if (showAdminMessage) {
      showAdminMessage = false;
      chatMessages.add(ChatMessagesModel(
        message:
            'Welcome to our driver support 👋 My name is Jonathan.  How may I help you today?',
        sender: userModel.uId,
        type: 'text',
        createdAt: DateTime.now().toUtc().toIso8601String(),
      ));
      update();
    }
  }

  //*************************************************
  recordingFinishedCallback(String value) async {
    log('____________recordingFinishedCallback_____________');
    log(value);
    dio_instance.FormData formData = await uploadFileFormData(value);
    await postMethod(uploadFile, formData,
        (bool responseCheck, Map<String, dynamic> response) {
      if (responseCheck) {
        messageTextField.text=response['file']["filename"];
        sendMessage(
            type: ChatType.voice.name);
        return;
      }
    });
  }

  //*************************************************
  openFile(String urlPath) async {
    if (urlPath.isEmpty) return;
    String extension = urlPath.split('.').last;
    Dio dio = Dio();
    Get.find<GeneralController>().changeLoaderCheck(true);
    var response = await dio.get(mediaUrl + urlPath,
        options: Options(responseType: ResponseType.bytes));
    Get.find<GeneralController>().changeLoaderCheck(false);
    final Directory tempDir = await getTemporaryDirectory();
    File imgFile = File('${tempDir.path}/$urlPath.$extension');
    imgFile.writeAsBytesSync(response.data);
    await OpenFile.open(imgFile.path);
  }

  //*************************************************
  addAttachments() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
        allowCompression: true,
        allowedExtensions: ['pdf', 'doc'],
        type: FileType.custom);

    if (file != null) {
      log('____________Upload File_____________');

      dio_instance.FormData formData =
          await uploadFileFormData(file.paths.first);
      await postMethod(uploadFile, formData,
          (bool responseCheck, Map<String, dynamic> response) {
        if (responseCheck) {
          log(response['file']["filename"]);
          messageTextField.text=response['file']["filename"];

          sendMessage(type: ChatType.file.name);
          return;
        }
      });
    }
  }
}
