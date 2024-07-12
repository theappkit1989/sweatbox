import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
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

class ChatController extends GetxController{
  var  user = Users().obs;
  late IO.Socket socket;
  var storage = GetStorage();
  String user_id='';
  RxList<MessageData> messages=<MessageData>[].obs;
  var textController = TextEditingController().obs;
  RxBool isloading=false.obs;
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;
  String token='';
  String receiver_socket_id='';

  void goToMenu(){
    Get.to(MenuView(),arguments:{'user':user.value} );
  }

  @override
  void onInit() {
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();

    initSocket();
    getMessage();
    super.onInit();
  }
  initSocket() {
    socket = IO.io(ApiEndpoint.socket, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });

    socket.connect();
    Map set_online = {

      'token':token,

      'user_id': user_id,



    };
    socket.emit('set_online',set_online);


    socket.onConnect((_) {

      socket.on('user_got_online',(data){
        print("user is online$data");
      });
      socket.on('get_conversation', (newMessage) {

        print("get new message in cchat$newMessage");


        var _m_data=MessageData.fromJson(newMessage['data']['response']);
        print('message data after decode$_m_data');
        // if (_m_data.senderId == user_id) {
          print('********** message On Not sender **************** $_m_data');
          var message=MessageData(receiverId: _m_data.receiverId,senderId: _m_data.senderId,message: _m_data.message,id: _m_data.id,updatedAt: _m_data.updatedAt,createdAt: _m_data.createdAt);
          messages.add(message);
          print('********** message On Not sender called after add message ****************');
          var homeCont = Get.find<AllMessagesController>();
          homeCont.allChatList.clear();
          homeCont.fetchAllChatList();
          homeCont.lastmessage.value=message.message.toString();
          homeCont.update();
          update();
        // }
        // if (_m_data.senderId == user.value.id.toString()) {
        //   print('********** message On Not sender user ****************');
        //   var message=MessageData(receiverId: _m_data.receiverId,senderId: _m_data.senderId,message: _m_data.message,id: _m_data.id,updatedAt: _m_data.updatedAt,createdAt: _m_data.createdAt);
        //   messages.add(message);
        //   print('********** message On Not sender user called after add message ****************');
        //   var homeCont = Get.find<AllMessagesController>();
        //   homeCont.allChatList.clear();
        //   homeCont.fetchAllChatList();
        //   homeCont.lastmessage.value=message.message.toString();
        //   homeCont.update();
        //   update();
        // }

        // messageList.add(MessageModel.fromJson(data));
      });
      print('Connection established${socket.id}');

    });

    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
  }
  getMessage(){

  }
  @override
  void dispose() {
    print('on dispose calls');
    socket.disconnect();

    // socket.close();
    super.dispose();
  }

  @override
  void onClose(){
    print('on close calls');
    socket.disconnect();
    // socket.close();
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
  sendMessage() {
    String message = textController.value.text;
    if (message.isEmpty) return;
    Map messageMap = {
      // 'receiver_socket_id':user.value.id.toString(),
      'token':token,
      'message': message,
      'sender_id': user_id,
      'receiver_id': user.value.id.toString(),

    };
    textController.value.clear();
    socket.emit('send_message_user', messageMap);
    print('send message called');
  }

  Future<Users?> fetchSpecificUser() async {

    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().getSpecificUser(token,user.value.id.toString());
    if (_response.status == true) {
      if(_response.user!.socket!.isNotEmpty){
        receiver_socket_id=_response.user!.socket!;
      }{
        print("user is ofline");
      }


    } else {

      if(_response.message=='The Selected appuserid is invalid '){
        Get.find<MyProfileController>().logout();
      }
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
      return null;
    }
  }
  Future<Users?> fetchAllMessages() async {

    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().getAllMessages(token,user_id,user.value.id.toString());
    print('user ids are ${user_id}${user.value.id.toString()}');
    if (_response.success == true) {

      print('message data is ${_response.response}');
      messages.value=_response.response!;
      isloading.value=false;
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //
      // });
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Future.delayed(Duration(seconds: 2), () {
      //     // _scrollToBottom();
      //     scrollController.jumpTo(scrollController.position.maxScrollExtent);
      //   });
      //
      //
      // });
    } else {
      isloading.value=false;
      if(_response.message=='The Selected appuserid is invalid '){
        Get.find<MyProfileController>().logout();
      }
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
      return null;
    }
  }
  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  //   }
  // }
}