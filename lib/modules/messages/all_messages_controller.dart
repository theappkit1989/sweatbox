import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/messages/chat_view.dart';
import 'package:s_box/modules/messages/socket/WebSocketService.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/api/api_endpoint.dart';
import '../../services/commonModels/chatListResponse.dart';
import '../../services/commonModels/freshFacesResponse.dart';
import '../../services/commonModels/messageResponse.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../my_profile/my_profile_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AllMessagesController extends GetxController {
  var storage = GetStorage();
  String token = '';
  String user_id = '';
  RxBool isloadingFreshfaces = false.obs;
  RxBool isloadingallchats = false.obs;
  RxString lastmessage = ''.obs;
  RxList<Users> freshUserList = <Users>[].obs;
  RxList<Chats> allChatList = <Chats>[].obs;
  RxList<String> allLastMessage = <String>[].obs;
  RxList<bool> isNewMessage = <bool>[].obs; // Add this list


  @override
  void onInit() {
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();

    fetchFreshFaces(token);
    fetchAllChatList();

    WebSocketService().onEvent('chats', (newMessage) {
      print('chats evenlisten');
      var _m_data = MessageData.fromJson(newMessage['data']['response']);
      if (_m_data.receiverId == user_id) {
        fetchAllChatList();
        var message = MessageData(
          receiverId: _m_data.receiverId,
          senderId: _m_data.senderId,
          message: _m_data.message,
          id: _m_data.id,
          updatedAt: _m_data.updatedAt,
          createdAt: _m_data.createdAt,
        );
        updateChatList(_m_data);
        lastmessage.value = message.message.toString();
        // update();
      }
    });

    Map set_online = {
      'token': token,
      'user_id': user_id,
    };
    WebSocketService().emitEvent('set_online', set_online);
  }
  void updateChatList(MessageData newMessage) {
    int index = allChatList.indexWhere((chat) => chat.id.toString() == newMessage.senderId.toString());
    if (index != -1) {
      allChatList[index].lastMessage = newMessage.message;
      allLastMessage[index]=newMessage.message.toString();
      allChatList[index].createdAt=newMessage.createdAt.toString();
      isNewMessage[index] = true;
      update();
      print('Updated last message for chat at index $index: ${allChatList[index].lastMessage}');
    }
  }

  // void updateChatList(MessageData newMessage) {
  //   for (var chat in allChatList) {
  //     print('ids are ${chat.id} and sender id is ${newMessage.senderId}');
  //     if (chat.id.toString() == newMessage.senderId.toString()) {
  //       chat.lastMessage = newMessage.message;
  //       update();
  //       print('last message update ${chat.lastMessage}');
  //       break;
  //     }
  //   }
  //
  // }

  void fetchFreshFaces(String token) async {
    FocusScope.of(Get.context!).unfocus();
    var _response = await ApiController().getFreshFaces(user_id, token);
    if (_response.status == true) {
      if (_response.users!.isNotEmpty) {
        freshUserList.value = _response.users!;
        isloadingFreshfaces.value = false;
      }
    } else {
      isloadingFreshfaces.value = false;
    }
  }

  void fetchAllChatList() async {
    FocusScope.of(Get.context!).unfocus();
    var _response = await ApiController().getAllChats(token, user_id);
    if (_response.status == true) {
      if (_response.response!.isNotEmpty) {
        allChatList.value = _response.response!;
        for(var chat in allChatList){
          allLastMessage.add(chat.lastMessage.toString());
          isNewMessage.add(false);
        }
        isloadingallchats.value = false;
      }
    } else {
      isloadingallchats.value = false;
      if (_response.message == 'The selected user id is invalid.') {
        Get.find<MyProfileController>().logout();
      }
    }
  }

  void goToChatScreen(Chats chat, int index) {
    var _user = Users(
      id: chat.id,
      image: chat.image,
      fName: chat.fName,
      socket: chat.socket,
      username: chat.username,
      email: chat.email,
      lName: chat.lName,
      token: chat.token,
      status: chat.status,
      createdAt: chat.createdAt,
    );
    isNewMessage[index] = false;
    // update();
    Get.to(ChatView(), arguments: {"user": _user});
  }

  void goToChatScreenfresh(Users user) {
    Get.to(ChatView(), arguments: {"user": user});
  }
}

