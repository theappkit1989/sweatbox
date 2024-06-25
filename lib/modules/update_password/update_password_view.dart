import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/new_password/new_password_controller.dart';
import 'package:s_box/modules/update_password/update_password_controller.dart';

import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../../themes/colors/color_light.dart';

class UpdatePasswordView extends StatelessWidget {
  final String token;
  final String user_id;
  final updPwdController = Get.put(UpdatePasswordController());
  UpdatePasswordView({Key? key, required this.token, required this.user_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    updPwdController.token.value=token;
    updPwdController.user_id.value=user_id;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: ColorLight.black,
        appBar: AppBar(
          backgroundColor: ColorLight.black,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Container(
            width: Get.width * 0.4,
            height: kToolbarHeight,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageConstant.appLogo),
                    fit: BoxFit.contain)),
          ),
          centerTitle: true,

        ),
        //  resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildFormContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildFormContainer() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.01, horizontal: Get.width * 0.05),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildWelcomeText(),
          buildForm(),
        ],
      ),
    );
  }

  buildWelcomeText() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.05, vertical: Get.height * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            strCreateNewPwd,
            style: TextStyle(
                fontFamily: fontType,
                color: ColorLight.white,
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          const Text(
            strCreateNewPwdHint,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: fontType,
                color: ColorLight.white,
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
        ],
      ),
    );
  }

  buildForm() {
    return Form(
        key: updPwdController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
                  () => TextFormField(
                controller: updPwdController.oldPwdController.value,
                style: TextStyle(
                    fontSize: Get.height * 0.017,
                    color: ColorLight.white,
                    fontFamily: fontType),
                obscureText: updPwdController.oldpwdVisibilityFlag.value == false
                    ? true
                    : false,
                obscuringCharacter: '*',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Old password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: strOldPwd,
                    hintStyle: TextStyle(
                        fontFamily: fontType,
                        fontSize: Get.height * 0.017,
                        fontWeight: FontWeight.w500,
                        color: ColorLight.white),
                    //suffixIcon: const Icon(Icons.visibility),
                    suffixIcon: Obx(
                          () => GestureDetector(
                        onTap: () {
                          updPwdController.oldpwdVisibilityFlag.value =
                          !updPwdController.oldpwdVisibilityFlag.value;
                        },
                        child: Icon(
                            color: ColorLight.white,
                            updPwdController.oldpwdVisibilityFlag.value == false
                                ? Icons.visibility
                                : Icons.visibility_off),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.height * 0.0175),
                    fillColor: textFieldColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12))),
              ),
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Obx(
                  () => TextFormField(
                controller: updPwdController.pwdController.value,
                style: TextStyle(
                    fontSize: Get.height * 0.017,
                    color: ColorLight.white,
                    fontFamily: fontType),
                obscureText: updPwdController.pwdVisibilityFlag.value == false
                    ? true
                    : false,
                obscuringCharacter: '*',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: strNewPwd,
                    hintStyle: TextStyle(
                        fontFamily: fontType,
                        fontSize: Get.height * 0.017,
                        fontWeight: FontWeight.w500,
                        color: ColorLight.white),
                    //suffixIcon: const Icon(Icons.visibility),
                    suffixIcon: Obx(
                          () => GestureDetector(
                        onTap: () {
                          updPwdController.pwdVisibilityFlag.value =
                          !updPwdController.pwdVisibilityFlag.value;
                        },
                        child: Icon(
                            color: ColorLight.white,
                            updPwdController.pwdVisibilityFlag.value == false
                                ? Icons.visibility
                                : Icons.visibility_off),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.height * 0.0175),
                    fillColor: textFieldColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12))),
              ),
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Obx(
                  () => TextFormField(
                controller: updPwdController.confirmPwdController.value,
                style: TextStyle(
                    fontSize: Get.height * 0.017,
                    color: ColorLight.white,
                    fontFamily: fontType),
                obscureText: updPwdController.cPwdVisibilityFlag.value == false
                    ? true
                    : false,
                obscuringCharacter: '*',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value.length < 8) {
                    return 'Confirm password must be at least 8 characters';
                  } else if (value != updPwdController.pwdController.value.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: strConfirmNewPwd,
                    hintStyle: TextStyle(
                        fontFamily: fontType,
                        fontSize: Get.height * 0.017,
                        fontWeight: FontWeight.w500,
                        color: ColorLight.white),
                    //suffixIcon: const Icon(Icons.visibility),
                    suffixIcon: Obx(
                          () => GestureDetector(
                        onTap: () {
                          updPwdController.cPwdVisibilityFlag.value =
                          !updPwdController.cPwdVisibilityFlag.value;
                        },
                        child: Icon(
                            color: ColorLight.white,
                            updPwdController.cPwdVisibilityFlag.value == false
                                ? Icons.visibility
                                : Icons.visibility_off),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06,
                        vertical: Get.height * 0.0175),
                    fillColor: textFieldColor,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.black12))),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            customSubmitBtn(
                text: strContinue,
                voidCallback: () {
                  updPwdController.newPassword();
                },
                width: Get.width),
            SizedBox(
              height: Get.height * 0.0125,
            ),
          ],
        ));
  }
}
