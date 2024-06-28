import 'package:s_box/extras/constant/shared_pref_constant.dart';
import 'package:s_box/modules/signup/view/signup_view.dart';
import 'package:s_box/modules/verification/verification_view.dart';
import 'package:s_box/services/repo/common_repo.dart';
import 'package:s_box/themes/loading_dialofg.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//import 'package:firebase_auth/firebase_auth.dart';


class ForgotController extends GetxController{

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


  forgotPassword() async {
    FocusScope.of(Get.context!).unfocus();
    // var deviceToken = await FirebaseMessaging.instance.getToken();
    if (formKey.currentState!.validate()) {
      _showLoadingDialog();
      var _response = await ApiController().forgotPwd(emailCont.value.text);
      if(_response.status==true) {
        _dismissDialog();
        // storage.write(userToken, _response.token);
        // storage.write("email", emailCont.value.text);
        // storage.write("name", _response.userData!.name ?? '');
        // storage.write("id", _response.userData!.id.toString() ?? '');
        // storage.write("userType", _response.userData!.userType ?? '');
        goToVerification();
      } else {
        _dismissDialog();
        print(_response.message);
        Get.snackbar("", _response.message??'Something went wrong!',colorText: Colors.white);
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

  void goToVerification(){
     Get.to((VerificationCode( email: emailCont.value.text,)));
  }


}