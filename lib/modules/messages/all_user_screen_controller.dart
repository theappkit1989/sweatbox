import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../extras/constant/common_validation.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/commonModels/allUsersResponse.dart';
import '../../services/commonModels/freshFacesResponse.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../my_profile/my_profile_controller.dart';
import 'chat_view.dart';

class AllUserScreenCotroller extends GetxController {
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
  RxList<Users> allUserList = <Users>[].obs;
  var storage = GetStorage();
  String token='';
  String user_id='';

  @override
  void onInit() {
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();
    fetchAllUser();
  }
  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }
  void goToChatScreen(Users user){
    Get.to(ChatView(),arguments: {"user":user});
  }
  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
  void fetchAllUser() async {
    // _showLoadingDialog();
    FocusScope.of(Get.context!).unfocus();

    // if(await isConnected()){

    var _response = await ApiController().getAllUsers(user_id, token);
    if (_response.status == true) {
      // _dismissDialog();
      if (_response.status == true) {
        print("all users are ${_response.users}");
        if(_response.users!.isEmpty){

        }else{
          allUserList.value=_response.users!;
          print(_response.users);
        }

      } else {
        // Handle error
        Get.snackbar('Error', _response.message ?? 'Unknown error occurred',colorText: Colors.white);
      }
    } else {
      if(_response.message=='The selected id is invalid.'){
        Get.find<MyProfileController>().logout();
      }
      // _dismissDialog();
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
    }
    // }else{
    //   Get.snackbar("Sweatbox", 'No internet connection',colorText: Colors.white);
    // }
  }
}