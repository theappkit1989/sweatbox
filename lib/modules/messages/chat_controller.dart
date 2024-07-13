import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
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
  RxBool isloading = false.obs;
  String token = '';
  String receiver_socket_id = '';

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
  sendMessage() {
    String message = textController.value.text;
    if (message.isEmpty) return;
    Map messageMap = {
      'token': token,
      'message': message,
      'sender_id': user_id,
      'receiver_id': user.value.id.toString(),
    };
    textController.value.clear();
    WebSocketService().emitEvent('send_message_user', messageMap);
    print('send message called');
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
