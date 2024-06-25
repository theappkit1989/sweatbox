import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common_validations.dart';
import 'package:s_box/modules/commonWidgets/edit_widget.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/forgot_password/forgot_password_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ForgotView extends StatelessWidget {
  final forgotPwdController = Get.put(ForgotController());
  ForgotView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              )
          ),
          title: Container(
            width: Get.width * 0.4,
            height: kToolbarHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(ImageConstant.appLogo),
              fit: BoxFit.contain)
            ),
          ),
          centerTitle: true,
          actions: [
            SizedBox(
              width: Get.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * 0.07,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: appPrimaryColor,
                    ),
                  ),
                  Container(
                    width: Get.width * 0.07,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textFieldColor,
                    ),
                  ),
                  Container(
                    width: Get.width * 0.07,
                    height: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textFieldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            forgotPass,
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
            strForgotPwdSubtitle,
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

  // buildLogo() {
  //   return Container(
  //     width: Get.width * 0.6,
  //     margin: EdgeInsets.only(top: Get.height * 0.1),
  //     child: Image.asset(
  //       ImageConstant.appLogo,
  //     ),
  //   );
  // }


  buildForm() {
    return Form(
        key: forgotPwdController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: forgotPwdController.emailCont.value,
              style: TextStyle(
                  fontSize: Get.height * 0.017,
                  color: ColorLight.white,
                  fontFamily: fontType),
              validator: (value) {
                if (!isValidEmail(value??'')) {
                  return errorValidEmail;
                }
                return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  hintText: strEmail,
                  contentPadding: EdgeInsets.only(left: Get.width*0.06,top: Get.height*0.018,bottom: Get.height*0.018),
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
              height: Get.height * 0.05,
            ),
            GestureDetector(
              onTap: (){
                forgotPwdController.forgotPassword();
              },
              child: Container(
                width: Get.width,
                height: Get.height * 0.065,
                padding:
                EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                // margin: EdgeInsets.only(right: Get.width*0.065,top: Get.height*0.029),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: appPrimaryColor),
                    color: appPrimaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    texts(strContinue,
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

          ],
        ));
  }
}
