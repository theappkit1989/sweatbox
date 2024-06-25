
import 'package:flutter/cupertino.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/edit_widget.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/signup/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../extras/constant/app_constant.dart';
import '../../../extras/constant/app_images.dart';
import '../../../themes/colors/color_light.dart';
import '../../commonWidgets/common_validations.dart';

class SignUpView extends StatelessWidget {
  final signupController = Get.put(SignUpController());
  SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorLight.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildWelcomeText(),
              Expanded(child:
              buildFormContainer()),
            ],
          ),
        ),
      ),
    );
  }

  buildWelcomeText() {
    return Padding(
      padding: EdgeInsets.symmetric(
           horizontal: Get.width * 0.15,
      vertical: Get.height * 0.08),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //SizedBox(height: Get.height * 0.1,),
          const Text(
            strSignupTitle,
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
            strSignupSubtitle,
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
      padding: EdgeInsets.symmetric(
           horizontal: Get.width * 0.05),
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildForm(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          GestureDetector(
            onTap: (){
              signupController.registerUser();
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
                  texts(strSignup,
                      fontSize: Get.height * 0.0185,
                      latterSpacing: 0.0,

                      isCentered: false,
                      textColor: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    //signupController.goToLoginPage();
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: strByContinue,
                      children: [
                        TextSpan(
                          text: strTerms,
                          style: TextStyle(
                              fontSize: Get.height * 0.016,
                              color: yellowF5EA25,
                              fontFamily: fontType,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: ' and \n',
                          style: TextStyle(
                              fontSize: Get.height * 0.017,
                              color: Colors.white,
                              fontFamily: fontType,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: strPrivacyPolicy,
                          style: TextStyle(
                              fontSize: Get.height * 0.016,
                              color: yellowF5EA25,
                              fontFamily: fontType,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                      style: TextStyle(
                          fontSize: Get.height * 0.017,
                          color: Colors.white,
                          fontFamily: fontType,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    signupController.goToLoginPage();
                  },
                  child: RichText(
                    text: TextSpan(
                      text: strAlreadyHaveAccount,
                      children: [
                        TextSpan(
                          text: strLogin,
                          style: TextStyle(
                              fontSize: Get.height * 0.016,
                              color: yellowF5EA25,
                              fontFamily: fontType,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                      style: TextStyle(
                          fontSize: Get.height * 0.017,
                          color: Colors.white,
                          fontFamily: fontType,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildForm() {
    return Form(
        key: signupController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              style: TextStyle(
                  fontSize: Get.height * 0.017,
                  color: ColorLight.white,
                  fontFamily: fontType),
              controller: signupController.nameCont.value,
              cursorColor: ColorLight.white,
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Please Enter Name';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: strFirstName,
                  filled: true,
                  hintStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.w500,
                      color: ColorLight.white),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.07,
                      vertical: Get.height * 0.018),
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
            TextFormField(
              style: TextStyle(
                  fontSize: Get.height * 0.017,
                  color: ColorLight.white,
                  fontFamily: fontType),
              controller: signupController.lastNameCont.value,
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Please Enter Name';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: strLastName,
                  hintStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.w500,
                      color: ColorLight.white),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.07,
                      vertical: Get.height * 0.018),
                  filled: true,
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
            TextFormField(
              style: TextStyle(
                  fontSize: Get.height * 0.017,
                  color: ColorLight.white,
                  fontFamily: fontType),
              controller: signupController.usernameCont.value,
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Please Enter username';
                }
                return null;
              },
              decoration: InputDecoration(

                hintText: strUsername,
                hintStyle: TextStyle(
                    fontFamily: fontType,
                    fontSize: Get.height * 0.017,
                    fontWeight: FontWeight.w500,
                    color: ColorLight.white),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.07, vertical: Get.height * 0.018),
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
                    borderSide: const BorderSide(color: Colors.black12)),
              ),
            ),
            // TextFormField(
            //   style: TextStyle(
            //       fontSize: Get.height * 0.017,
            //       color: ColorLight.white,
            //       fontFamily: fontType),
            //   controller: signupController.usernameCont.value,
            //   validator: (value) {
            //     if (value == null || value.trim() == '') {
            //       return 'Please Enter username';
            //     }
            //     return null;
            //   },
            //
            //   decoration: InputDecoration(
            //     prefixText:"@",
            //       hintText: strUsername,
            //       hintStyle: TextStyle(
            //           fontFamily: fontType,
            //           fontSize: Get.height * 0.017,
            //           fontWeight: FontWeight.w500,
            //           color: ColorLight.white),
            //       contentPadding: EdgeInsets.symmetric(
            //           horizontal: Get.width * 0.07,
            //           vertical: Get.height * 0.018),
            //       fillColor: textFieldColor,
            //       filled: true,
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(30.0),
            //           borderSide: const BorderSide(color: Colors.black12)),
            //       focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(30.0),
            //           borderSide: const BorderSide(color: Colors.black12)),
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(30.0),
            //           borderSide: const BorderSide(color: Colors.black12))),
            // ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            TextFormField(
              style: TextStyle(
                  fontSize: Get.height * 0.016,
                  color: ColorLight.white,
                  fontFamily: fontType),
              controller: signupController.emailCont.value,
              validator: (value) {
                if (!isValidEmail(value ?? '')) {
                  return errorValidEmail;
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: strEmail,
                  hintStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.w500,
                      color: ColorLight.white),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.07,
                      vertical: Get.height * 0.018),
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
            SizedBox(
              height: Get.height * 0.025,
            ),
            Obx(
              () => TextFormField(
                style: TextStyle(
                    fontSize: Get.height * 0.016,
                    color: ColorLight.white,
                    fontFamily: fontType),
                obscureText: signupController.pwdVisibilityFlag.value == false
                    ? true
                    : false,
                obscuringCharacter: '*',
                controller: signupController.passCont.value,
                validator: (value) {
                  if (value.toString().length < 8) {
                    return errorPassLength;
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: strPassword,
                    suffixIcon: Obx(
                      () => GestureDetector(
                        onTap: () {
                          signupController.pwdVisibilityFlag.value =
                              !signupController.pwdVisibilityFlag.value;
                        },
                        child: Icon(color: ColorLight.white,
                            signupController.pwdVisibilityFlag.value == false
                                ? Icons.visibility
                                : Icons.visibility_off),
                      ),
                    ),
                    hintStyle: TextStyle(
                        fontFamily: fontType,
                        fontSize: Get.height * 0.017,
                        fontWeight: FontWeight.w500,
                        color: ColorLight.white),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.07,
                        vertical: Get.height * 0.018),
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
              height: Get.height * 0.07,
            ),


          ],
        ));
  }

  buildLogo() {
    return Container(
      width: Get.width * 0.5,
      margin: EdgeInsets.only(top: Get.height * 0.075),
      child: Image.asset(
        ImageConstant.appLogo,
      ),
    );
  }
}
