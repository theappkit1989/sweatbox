import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/new_password/password_updated_view.dart';

import '../../extras/constant/common_validation.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/new_password/password_updated_view.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';

class NewPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var pwdController = TextEditingController().obs;
  var confirmPwdController = TextEditingController().obs;
  RxBool pwdVisibilityFlag = false.obs;
  RxBool cPwdVisibilityFlag = false.obs;
  var token = ''.obs;
  var user_id = ''.obs;

  newPassword() async {
    FocusScope.of(Get.context!).unfocus();

    // if(await isConnected()){
    if (formKey.currentState!.validate()) {
      if (_validatePasswords()) {
        _showLoadingDialog();
        var _response = await ApiController().newPassword(user_id.string, confirmPwdController.value.text, token.toString());
        if (_response.status == true) {
          _dismissDialog();
          goToPwdUpdated();
        } else {
          _dismissDialog();
          Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
        }
      } else {
        Get.snackbar("Sweatbox", "Passwords do not match or are less than 8 characters!",colorText: Colors.white);
      }
    }
  // }else{
  // Get.snackbar("Sweatbox", 'No internet connection',colorText: Colors.white);
  // }
  }

  bool _validatePasswords() {
    String password = pwdController.value.text;
    String confirmPassword = confirmPwdController.value.text;
    if (password.length >= 8 && confirmPassword.length >= 8 && password == confirmPassword) {
      return true;
    }
    return false;
  }

  void goToPwdUpdated() {

    Get.close(2);
    Get.to(PasswordUpdated());
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
