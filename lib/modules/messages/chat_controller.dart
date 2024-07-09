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
import '../my_profile/my_profile_controller.dart';

class ChatController extends GetxController{
  var  user = Users().obs;
  late IO.Socket socket;
  var storage = GetStorage();
  RxList<MessageData> messages=<MessageData>[].obs;
  var textController = TextEditingController().obs;
  String token='';
  String receiver_socket_id='';
  String user_id='';
  void goToMenu(){
    Get.to(MenuView());
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
    socket.emit('testing',set_online);

    socket.onConnect((_) {
      socket.on('testing',(data){
        print("user is online testing event$data");
      });
      socket.on('user_got_online',(data){
        print("user is online$data");
      });
      socket.on('get_conversation', (newMessage) {


        print("get new message$newMessage");
        messages.add(MessageData.fromJson(newMessage['data']['response']));
        update();
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
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
  sendMessage() {
    String message = textController.value.toString();
    if (message.isEmpty) return;
    Map messageMap = {
      'receiver_socket_id':receiver_socket_id,
      'token':token,
      'message': message,
      'sender_id': user_id,
      'receiver_id': user.value.id,

    };

    socket.emit('send_message_user', messageMap);
    print('send message called');
  }

  Future<Users?> fetchSpecificUser() async {

    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().getSpecificUser(token,user.value.id.toString());
    if (_response.status == true) {
      if(_response.user!.socket!=null){
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

    } else {

      if(_response.message=='The Selected appuserid is invalid '){
        Get.find<MyProfileController>().logout();
      }
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
      return null;
    }
  }
}