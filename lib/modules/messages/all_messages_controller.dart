import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/messages/chat_view.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/commonModels/freshFacesResponse.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';

class AllMessagesController extends GetxController {
  var storage = GetStorage();
  String token='';
  String user_id='';
  RxList<Users> freshUserList = <Users>[].obs;
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
  void goToChatScreen(Users user){
    Get.to(ChatView(),arguments: {"user":user});
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
