import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/messages/chat_view.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/commonModels/chatListResponse.dart';
import '../../services/commonModels/freshFacesResponse.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../my_profile/my_profile_controller.dart';

class AllMessagesController extends GetxController {
  var storage = GetStorage();
  String token='';
  String user_id='';
  RxList<Users> freshUserList = <Users>[].obs;
  RxList<Chats> allChatList = <Chats>[].obs;
  final String defaultImage = 'assets/images/Ellipse 2.png';
  List<String> freshFacesImg = [
    'assets/images/Ellipse 2.png',
    'assets/images/Ellipse 3.png',
    'assets/images/Ellipse 4.png',
    'assets/images/Ellipse 5.png',
    'assets/images/Ellipse 2.png',
    'assets/images/Ellipse 3.png',
    'assets/images/Ellipse 4.png',
    'assets/images/Ellipse 5.png',
    'assets/images/Ellipse 2.png',
    'assets/images/Ellipse 3.png',
    'assets/images/Ellipse 4.png',
    'assets/images/Ellipse 5.png'
  ];

  List<String> nearByFaces = [
    'assets/images/nearby.png',
    'assets/images/Rectangle 39988 (1).png',
    'assets/images/nearby.png',
    'assets/images/Rectangle 39988 (1).png',
    'assets/images/nearby.png',
    'assets/images/Rectangle 39988 (1).png',
    'assets/images/nearby.png',
    'assets/images/Rectangle 39988 (1).png',
    'assets/images/nearby.png',
    'assets/images/Rectangle 39988 (1).png',
    'assets/images/nearby.png',
    'assets/images/Rectangle 39988 (1).png',
    'assets/images/nearby.png',
    'assets/images/Rectangle 39988 (1).png',
    'assets/images/nearby.png',
    'assets/images/Rectangle 39988 (1).png',
    'assets/images/nearby.png'
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();
    // Future.delayed(Duration(seconds: 1), () {
      fetchFreshFaces(token);
    fetchAllChatList();
    // });

  }

  void fetchFreshFaces(String token) async {
    // _showLoadingDialog();
    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().getFreshFaces(token);
    if (_response.status == true) {
      // _dismissDialog();
      if(!_response.users!.isEmpty){
        freshUserList.value=_response.users!;
      }


    } else {
      // _dismissDialog();
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
    }
  }

  void fetchAllChatList() async {

    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().getAllChats(token,user_id);

    if (_response.status == true) {

      if(!_response.response!.isEmpty){

        allChatList.value=_response.response!;
      }

    } else {

      if(_response.message=='The selected user id is invalid.'){
        Get.find<MyProfileController>().logout();
      }
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
      return null;
    }
  }
  void goToChatScreen(Chats chat){
    var _user=Users(id: chat.id,image: chat.image,fName: chat.fName,socket: chat.socket,username: chat.username,email: chat.email,lName: chat.lName,token: chat.token,status: chat.status,createdAt: chat.createdAt );
    Get.to(ChatView(),arguments: {"user":_user});
  }
  void goToChatScreenfresh(Users user){
    // var _user=Users(id: chat.id,image: chat.image,fName: chat.fName,socket: chat.socket,username: chat.username,email: chat.email,lName: chat.lName,token: chat.token,status: chat.status,createdAt: chat.createdAt );
    Get.to(ChatView(),arguments: {"user":user});
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
