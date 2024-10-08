import 'package:s_box/extras/constant/shared_pref_constant.dart';
import 'package:s_box/modules/login/view/login_view.dart';
import 'package:s_box/services/repo/common_repo.dart';
import 'package:s_box/themes/loading_dialofg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../extras/constant/common_validation.dart';
import '../../../extras/constant/string_constant.dart';
import '../../../fcmNotification/FirebaseMessaging.dart';
import '../../home_screen/home_view.dart';
import '../terms_and_condition.dart';


class SignUpController extends GetxController{

  var showLoader = false.obs;
  RxBool pwdVisibilityFlag = false.obs;
  RxBool pwd1VisibilityFlag = false.obs;
  final formKey = GlobalKey<FormState>();
  var nameCont = TextEditingController().obs;
  var lastNameCont = TextEditingController().obs;
  var usernameCont = TextEditingController().obs;
  var dobCont = TextEditingController().obs;
  var emailCont = TextEditingController().obs;
  var passCont = TextEditingController().obs;
  var cPassCont = TextEditingController().obs;
  var emailFocus = FocusNode();
  var passFocus = FocusNode();
  var cPassFocus = FocusNode();
  var storage = GetStorage();
  var hasAcceptedTerms = false.obs;
  var hasAcceptedSexualEtiquette = false.obs;

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
  void showTermsAndConditionsScreen() {
    if (!hasAcceptedTerms.value) {
      Get.to(() => TermsAndConditionsScreen(
        onProceed:() {
          hasAcceptedTerms.value=true;
          Get.back;
          Future.delayed(Duration(milliseconds: 400) , () {
            showSexualEtiquetteScreen();
          });
          }
      ));
    }else{
      showSexualEtiquetteScreen();
    }
  }

  void showSexualEtiquetteScreen() {
    if (!hasAcceptedSexualEtiquette.value) {
      Get.to(() => SexualEtiquetteScreen(
        onProceed: () {
          hasAcceptedSexualEtiquette.value = true;
        },
      ));
    }
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
    // if(await isConnected()){
    if (formKey.currentState!.validate()&&hasAcceptedTerms.value==true) {
      _showLoadingDialog();
      try {
        var response = await ApiController().registerUser(
          nameCont.value.text,
          lastNameCont.value.text,
          usernameCont.value.text,
          emailCont.value.text,
          passCont.value.text,
          dobCont.value.text,
        );
        print(dobCont.value.text);

        if (response.status == true) {
          _dismissDialog();
          // storage.write('userToken', response['access_token']);
          storage.write(userEmail, response.user?.email);
          storage.write(userid, response.user?.id.toString());
          storage.write(userName, response.user?.username);
          storage.write(firstName, nameCont.value.text);
          storage.write(lastName, lastNameCont.value.text);
          storage.write(userToken, response.accessToken);
          storage.write(userdob, dobCont.value.text);
          NotificationsSubscription.fcmSubscribe( response.user?.id.toString());
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
    // }else{
    //   Get.snackbar("Sweatbox", 'No internet connection',colorText: Colors.white);
    // }
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}