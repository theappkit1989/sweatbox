import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:s_box/extras/constant/common_validation.dart';
import 'package:s_box/modules/messages/socket/WebSocketService.dart';
import 'package:s_box/services/api/api_endpoint.dart';
import 'package:s_box/services/commonModels/freshFacesResponse.dart';
import 'package:s_box/services/commonModels/messageResponse.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';
import 'package:s_box/modules/messages/menu_view.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../my_profile/my_profile_controller.dart';
import 'all_messages_controller.dart';

class ChatController extends GetxController {
  var user = Users().obs;
  var storage = GetStorage();
  String user_id = '';
  RxList<MessageData> messages = <MessageData>[].obs;
  var textController = TextEditingController().obs;
  var scrollController = ScrollController().obs;
  RxBool isloading = false.obs;
  String token = '';
  String receiver_socket_id = '';
  Rx<File> selectedFile=File("").obs;
  var selectedImage = Rx<File?>(null);
  @override
  void onInit() {
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();

    WebSocketService().onEvent('get_conversation', (newMessage) {
      var _m_data = MessageData.fromJson(newMessage['data']['response']);
      var message = MessageData(
        receiverId: _m_data.receiverId,
        senderId: _m_data.senderId,
        message: _m_data.message,
        id: _m_data.id,
        updatedAt: _m_data.updatedAt,
        createdAt: _m_data.createdAt,
        type:  _m_data.type,
      );
      messages.add(message);
      // var homeCont = Get.find<AllMessagesController>();
      // homeCont.allChatList.clear();
      // homeCont.fetchAllChatList();
      // homeCont.lastmessage.value = message.message.toString();
      // homeCont.update();
      update();
    });

    fetchAllMessages();
  }
  void goToMenu(){
    Get.to(MenuView(),arguments:{'user':user.value} );
  }
  sendMessage(String type, String message) {
    // String message = textController.value.text;
    if (message.isEmpty) return;
    Map messageMap = {
      'token': token,
      'message': message,
      'sender_id': user_id,
      'receiver_id': user.value.id.toString(),
      'type': type,
    };
    textController.value.clear();
    WebSocketService().emitEvent('send_message_user', messageMap);
    print('send message called');
  }
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'jpg', 'jpeg', 'png',
          'mp4', 'mov', 'avi', 'mkv',
          // 'pdf', 'doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx'
        ]
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      int fileSizeInBytes = file.lengthSync();
      int fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024);
      if (fileSizeInMB > 10) {
        Get.snackbar(
          "Error",
          "File size exceeds 10MB. Please select a smaller file.",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
        return;
      }
      PlatformFile file2 = result.files.first;
      String fileType = getFileType(file2.extension);
      print("fileType:${fileType}");
      sendMedia(file,fileType);
    }
  }
  static String getFileType(String? fileExtension) {
    if (fileExtension == null) {
      return 'Unknown';
    }

    // Convert the extension to lowercase for case-insensitive comparison
    String extension = fileExtension.toLowerCase();

    // Check if the file is an image based on the common image extensions
    if (['jpg', 'jpeg', 'png'].contains(extension)) {
      return MyFileType.image.name;
    }

    // Check if the file is a video based on the common video extensions
    if (['mp4', 'mov', 'avi', 'mkv'].contains(extension)) {
      return MyFileType.video.name;
    }

    // Check if the file is a document based on the common document extensions
    if (['pdf', 'doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx'].contains(extension)) {
      return MyFileType.file.name;
    }

    // If the extension is not recognized as an image, video, or document, classify it as 'Other'
    return 'Other';
  }
  sendMedia( File mFile, String type) async {
    FocusScope.of(Get.context!).unfocus();

    // if(await isConnected()){

      // print(' id is ${user_id.toString()}');
      var _response = await ApiController().SendMediaInMessage(

        user_id.toString(),
          type,
        token,
         image:  mFile,

      );
      if (_response.status == true) {
        sendMessage(type, _response.path.toString());
      } else {

        Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
      }
    // }else{
    //   Get.snackbar("Sweatbox", 'No internet connection',colorText: Colors.white);
    // }
    }


  Future<void> fetchAllMessages() async {
    FocusScope.of(Get.context!).unfocus();
    var _response = await ApiController().getAllMessages(
      token,
      user_id,
      user.value.id.toString(),
    );
    if (_response.success == true) {
      messages.value = _response.response!;
      isloading.value = false;
    } else {
      isloading.value = false;
      if (_response.message == 'The Selected appuserid is invalid') {
        Get.find<MyProfileController>().logout();
      }
      // Get.snackbar(
      //   "Sweatbox",
      //   _response.message ?? 'Something went wrong!',
      //   colorText: Colors.white,
      // );
    }
  }

  @override
  void onClose() {
    WebSocketService().disconnect();
    super.onClose();
  }
}
