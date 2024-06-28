import 'package:s_box/extras/constant/shared_pref_constant.dart';
import 'package:s_box/modules/login/view/login_view.dart';
import 'package:s_box/services/repo/common_repo.dart';
import 'package:s_box/themes/loading_dialofg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../home_screen/home_view.dart';


class SignUpController extends GetxController{

  var showLoader = false.obs;
  RxBool pwdVisibilityFlag = false.obs;
  RxBool pwd1VisibilityFlag = false.obs;
  final formKey = GlobalKey<FormState>();
  var nameCont = TextEditingController().obs;
  var lastNameCont = TextEditingController().obs;
  var usernameCont = TextEditingController().obs;
  var emailCont = TextEditingController().obs;
  var passCont = TextEditingController().obs;
  var cPassCont = TextEditingController().obs;
  var emailFocus = FocusNode();
  var passFocus = FocusNode();
  var cPassFocus = FocusNode();
  var storage = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    usernameCont.value.addListener(() {
      if (!usernameCont.value.text.startsWith('@')) {
        usernameCont.value.text = '@' + usernameCont.value.text;
        usernameCont.value.selection = TextSelection.fromPosition(
          TextPosition(offset: usernameCont.value.text.length),
        );
      }
    });
  }

  void goToLoginPage(){
    Get.offAll(LoginView());
  }

  void goToRoleSelection(){
    Get.off(LoginView());
  }

  // registerUser() async {
  //   FocusScope.of(Get.context!).unfocus();
  //   if (formKey.currentState!.validate()) {
  //     _showLoadingDialog();
  //     var _response = await ApiController().registerUser(nameCont.value.text,lastNameCont.value.text,
  //         emailCont.value.text,passCont.value.text);
  //     if(_response.status!=null && _response.status!) {
  //       _dismissDialog();
  //       storage.write(userToken, _response.token);
  //       storage.write("email", emailCont.value.text);
  //       storage.write("f_name", nameCont.value.text ?? '');
  //       storage.write("l_name", nameCont.value.text ?? '');
  //       storage.write("id",'');
  //       storage.write("userType",'');
  //     } else {
  //       _dismissDialog();
  //       Get.snackbar("Sweatbox", 'Wrong Credentials entered!');
  //     }
  //   }
  // }
  registerUser() async {
    FocusScope.of(Get.context!).unfocus();
    if (formKey.currentState!.validate()) {
      _showLoadingDialog();
      try {
        var response = await ApiController().registerUser(
          nameCont.value.text,
          lastNameCont.value.text,
          usernameCont.value.text,
          emailCont.value.text,
          passCont.value.text,
        );

        if (response.status == true) {
          _dismissDialog();
          // storage.write('userToken', response['access_token']);
          storage.write(userEmail, response.user?.email);
          storage.write(userid, response.user?.id.toString());
          storage.write(userName, response.user?.username);
          storage.write(firstName, nameCont.value.text);
          storage.write(lastName, lastNameCont.value.text);
          storage.write(userToken, response.accessToken);

          Get.offAll(() => HomeScreenView());
        } else {
          _dismissDialog();
          Get.snackbar("Sweatbox", 'Failed to register user ${response.message}',colorText: Colors.white);
        }
      } catch (e) {
        _dismissDialog();
        Get.snackbar("Sweatbox", e.toString(),colorText: Colors.white);
      }
    }
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}