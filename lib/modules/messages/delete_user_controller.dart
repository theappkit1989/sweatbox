import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/messages/all_messages_controller.dart';
import 'package:s_box/modules/messages/chat_controller.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/commonModels/freshFacesResponse.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';

class DeleteUserController extends GetxController{
  var  user = Users().obs;
  var storage = GetStorage();
  String user_id='';
  String token='';
  @override
  void onInit() {
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();


    super.onInit();
  }
  void deleteChat() async {
    // Implement the logic to delete the user's account
    // This typically involves calling an API endpoint to delete the user's account
    bool success = await _deleteAccountFromServer()??false;
    if (success) {
      var homeCont = Get.find<AllMessagesController>();
      homeCont.allChatList.clear();
      homeCont.fetchAllChatList();
      homeCont.update();
      Get.back();
      Get.back();
      Get.back();

    } else {
      Get.snackbar('Error', 'Failed to delete account',colorText: Colors.white);
    }
  }
  Future<bool?> _deleteAccountFromServer() async {
    _showLoadingDialog();
    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().deleteUserChat(user_id, user.value.id.toString(),token);
    if (_response.status == true) {
      _dismissDialog();

        // Get.off(2);
        return _response.status;


    } else {
      _dismissDialog();

      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
      return _response.status;
    }
  }
  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }

}