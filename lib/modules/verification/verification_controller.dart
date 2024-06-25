import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/new_password/new_password_view.dart';
import 'package:s_box/themes/loading_dialofg.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/repo/common_repo.dart';

class VerificationController extends GetxController{

  var firstController = TextEditingController().obs;
  var secondController = TextEditingController().obs;
  var thirdController = TextEditingController().obs;
  var fourthController = TextEditingController().obs;
  var email = ''.obs;
  final formKey = GlobalKey<FormState>();
  RxBool active = false.obs;
  var storage = GetStorage();
  FocusNode firstFn = FocusNode() ;
  FocusNode secondFn = FocusNode() ;
  FocusNode thirdFn = FocusNode() ;
  FocusNode fourthFn = FocusNode() ;

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
  void validateAndContinue() {
    if (firstController.value.text.isNotEmpty &&
        secondController.value.text.isNotEmpty &&
        thirdController.value.text.isNotEmpty &&
        fourthController.value.text.isNotEmpty) {

      String code = firstController.value.text +
          secondController.value.text +
          thirdController.value.text +
          fourthController.value.text;
      // Call your API to verify the code
      verifyOtp(code);
    } else {
      Get.snackbar("Error", "Please enter all four digits of the code.");
    }
  }
  verifyOtp(String code) async {
    FocusScope.of(Get.context!).unfocus();
    firstController.value.clear();
    secondController.value.clear();
    thirdController.value.clear();
    fourthController.value.clear();

    // var deviceToken = await FirebaseMessaging.instance.getToken();
    if (formKey.currentState!.validate()) {
      _showLoadingDialog();
      var _response = await ApiController().verifyOTP(email.toString(),code);
      if(_response.message=="Verification successful.") {
        _dismissDialog();
        // storage.write(userToken, _response.accessToken);
        // storage.write("email", emailCont.value.text);
        // storage.write("name", _response.userData!.name ?? '');
        // storage.write(userid, _response.user_id ?? '');
        // storage.write("userType", _response.userData!.userType ?? '');
        goToCreatePwd( _response.accessToken!,_response.user_id!.toString());
      } else {
        _dismissDialog();
        Get.snackbar("Error", _response.message??'Something went wrong!');
      }
    }
  }
  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();

  }
  void goToCreatePwd(String accessToken, String user_id){
    // Get.to(NewPasswordView());
    Get.off(() => NewPasswordView(token: accessToken,user_id: user_id,));

  }
}