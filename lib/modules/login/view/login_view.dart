import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/edit_widget.dart';
import 'package:s_box/modules/home_screen/home_view.dart';
import 'package:s_box/modules/login/controller/login_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../extras/constant/AutoCapitalizeTextInputFormatter.dart';
import '../../commonWidgets/common_validations.dart';

class LoginView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorLight.black,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildWelcomeText(),
                buildFormContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildWelcomeText() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.15, vertical: Get.height * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //SizedBox(height: Get.height * 0.1,),
          const Text(
            strLoginTitle,
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
            strLoginSubtitle,
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

  buildFormContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildForm(),
        ],
      ),
    );
  }

  buildLogo() {
    return Container(
      width: Get.width * 0.6,
      margin: EdgeInsets.only(top: Get.height * 0.1),
      child: Image.asset(
        ImageConstant.appLogo,
      ),
    );
  }

  buildForm() {
    return Form(
        key: loginController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: Get.height * 0.05,
            // ),
            // Text(
            //   emailAddress,
            //   style: TextStyle(
            //       fontSize: Get.height * 0.016,
            //       color: ColorLight.black,
            //       fontFamily: fontType,
            //       fontWeight: FontWeight.w500),
            // ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            TextFormField(
              controller: loginController.emailCont.value,
              style: TextStyle(
                  fontSize: Get.height * 0.017,
                  color: ColorLight.white,
                  fontFamily: fontType),
              validator: (value) {
                if (!isValidEmail(value ?? '')) {
                  return errorValidEmail;
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  hintText: strEmail,
                  contentPadding: EdgeInsets.only(
                      left: Get.width * 0.06,
                      top: Get.height * 0.018,
                      bottom: Get.height * 0.018),
                  hintStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.w500,
                      color: ColorLight.white),
                  fillColor: textFieldColor,
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
            SizedBox(
              height: Get.height * 0.025,
            ),
            Obx(
              () => TextFormField(
                inputFormatters: [
                  AutoCapitalizeTextInputFormatter(),
                ],
                controller: loginController.passCont.value,
                style: TextStyle(
                    fontSize: Get.height * 0.017,
                    color: ColorLight.white,
                    fontFamily: fontType),
                obscureText: loginController.pwdVisibilityFlag.value == false
                    ? true
                    : false,
                obscuringCharacter: '*',
                validator: (value) {
                  if (value.toString().length < 8) {
                    return errorPassLength;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: strPassword,
                    hintStyle: TextStyle(
                        fontFamily: fontType,
                        fontSize: Get.height * 0.017,
                        fontWeight: FontWeight.w500,
                        color: ColorLight.white),
                    //suffixIcon: const Icon(Icons.visibility),
                    suffixIcon: Obx(
                      () => GestureDetector(
                        onTap: () {
                          loginController.pwdVisibilityFlag.value =
                              !loginController.pwdVisibilityFlag.value;
                        },
                        child: Icon(
                          color: ColorLight.white,
                            loginController.pwdVisibilityFlag.value == false
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
              height: Get.height * 0.01,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  loginController.goToForgotPwd();
                },
                child: Text(
                  forgotPass,
                  style: TextStyle(
                      fontSize: Get.height * 0.016,
                      color: yellowF5EA25,
                      fontFamily: fontType,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.07,
            ),
            GestureDetector(
              onTap: () {
               loginController.loginUser();
              },
              child: Container(
                width: Get.width,
                height: Get.height * 0.065,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                // margin: EdgeInsets.only(right: Get.width*0.065,top: Get.height*0.029),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: appPrimaryColor),
                    color: appPrimaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    texts(strLogin,
                        fontSize: Get.height * 0.0185,
                        latterSpacing: 0.0,
                        isCentered: false,
                        textColor: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: fontType),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.0125,
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  loginController.goToSignUpPage();
                },
                child: RichText(
                  text: TextSpan(
                    text: strDoNotHaveAccount,
                    children: [
                      TextSpan(
                        text: strSignup,
                        style: TextStyle(
                            fontSize: Get.height * 0.016,
                            color: yellowF5EA25,
                            fontFamily: fontType,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                    style: TextStyle(
                        fontSize: Get.height * 0.016,
                        color: ColorLight.white,
                        fontFamily: fontType,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
