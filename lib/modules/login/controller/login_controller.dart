import 'package:s_box/extras/constant/shared_pref_constant.dart';
import 'package:s_box/modules/forgot_password/forgot_password_view.dart';
import 'package:s_box/modules/signup/view/signup_view.dart';
import 'package:s_box/services/repo/common_repo.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import 'package:firebase_auth/firebase_auth.dart';

import '../../../fcmNotification/FirebaseMessaging.dart';
import '../../commonWidgets/loading_dialog.dart';
import '../../home_screen/home_view.dart';

class LoginController extends GetxController{

  var showLoader = false.obs;
  RxBool pwdVisibilityFlag = false.obs;
  final formKey = GlobalKey<FormState>();
  var emailCont = TextEditingController().obs;
  var passCont = TextEditingController().obs;
  var emailFocus = FocusNode();
  var passFocus = FocusNode();
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
  }


  loginUser() async {
    FocusScope.of(Get.context!).unfocus();
   // var deviceToken = await FirebaseMessaging.instance.getToken();
    if (formKey.currentState!.validate()) {
      _showLoadingDialog();
      var _response = await ApiController().loginUser(emailCont.value.text,passCont.value.text);
      if(_response.user!=null ) {
        _dismissDialog();
        storage.write(userToken, _response.token);
        storage.write(userEmail, emailCont.value.text);
        storage.write(firstName, _response.user!.f_name ?? '');
        storage.write(lastName, _response.user!.l_name ?? '');
        storage.write(userName, _response.user!.username ?? '');
        storage.write(image, _response.user!.image ?? '');
        storage.write(userid, _response.user!.id.toString() ?? '');
        NotificationsSubscription.fcmSubscribe(_response.user!.id.toString());
        Get.offAll(() => HomeScreenView());
        // storage.write("userType", _response.userData!.userType ?? '');

      } else {
        _dismissDialog();
        print("Error ${_response.message}");
        Get.snackbar("Sweatbox", 'Incorrect Email or Password',colorText: Colors.white);
      }
    }
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }

  void goToSignUpPage() {
    Get.to(SignUpView());
  }

  void goToForgotPwd(){
    Get.to(ForgotView());
  }


}