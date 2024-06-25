import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/new_password/password_updated_view.dart';

import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/new_password/password_updated_view.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';

class UpdatePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var pwdController = TextEditingController().obs;
  var oldPwdController = TextEditingController().obs;
  var confirmPwdController = TextEditingController().obs;
  RxBool pwdVisibilityFlag = false.obs;
  RxBool oldpwdVisibilityFlag = false.obs;
  RxBool cPwdVisibilityFlag = false.obs;
  var token = ''.obs;
  var user_id = ''.obs;

  newPassword() async {
    FocusScope.of(Get.context!).unfocus();

    if (formKey.currentState!.validate()) {
      if (_validatePasswords()) {
        _showLoadingDialog();
        var _response = await ApiController().updatePassword(user_id.string,oldPwdController.value.text, confirmPwdController.value.text, token.toString());
        if (_response.status == true) {
          _dismissDialog();
          // goToPwdUpdated();
          Get.back();
        } else {
          _dismissDialog();
          Get.snackbar("Error", _response.message ?? 'Something went wrong!');
        }
      } else {
        Get.snackbar("Error", "Passwords do not match or are less than 8 characters!");
      }
    }
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
