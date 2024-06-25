import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/verification/verification_controller.dart';
import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../../extras/constant/string_constant.dart';
import '../../themes/colors/color_light.dart';

class VerificationCode extends StatelessWidget {
  final String email;
  final verificationController = Get.put(VerificationController());

  VerificationCode({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    verificationController.email.value = email;
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
                ],
              ),
            ),
          ],
        ),
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
            verificationCode,
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
            hintVerificationCode,
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
      key: verificationController.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildOtpField(
                  controller: verificationController.firstController.value,
                  focusNode: verificationController.firstFn,
                  nextFocusNode: verificationController.secondFn,
                  active: false),
              buildOtpField(
                  controller: verificationController.secondController.value,
                  focusNode: verificationController.secondFn,
                  nextFocusNode: verificationController.thirdFn,
                  active: false),
              buildOtpField(
                  controller: verificationController.thirdController.value,
                  focusNode: verificationController.thirdFn,
                  nextFocusNode: verificationController.fourthFn,
                  active: false),
              buildOtpField(
                  controller: verificationController.fourthController.value,
                  focusNode: verificationController.fourthFn,
                  nextFocusNode: null,
                  active: false),
            ],
          ),
          SizedBox(height: Get.height * 0.06,),
          customSubmitBtn(text: signup, voidCallback: (){verificationController.validateAndContinue();}, width: Get.width),
          SizedBox(height: Get.height * 0.02,),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                //loginController.goToSignUpPage();
              },
              child: RichText(
                text: TextSpan(
                  text: strDidNotReceiveCode,
                  children: [
                    TextSpan(
                      text: strResendCode,
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
      ),
    );
  }

  buildOtpField(
      {required TextEditingController controller,
        required FocusNode focusNode,
        FocusNode? nextFocusNode,
        required bool active}) {
    return SizedBox(
      width: Get.width * 0.2,
      child: TextFormField(
        style: TextStyle(
            fontSize: 32,
            color: active ? ColorLight.white : ColorLight.black,
            fontWeight: FontWeight.w700),
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            focusNode.unfocus();
            if (nextFocusNode != null) {
              FocusScope.of(Get.context!).requestFocus(nextFocusNode);
            } else {
              // Validate the form when the last field is filled
              // verificationController.verifyCode();
            }
          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: active ? appPrimaryColor : ColorLight.white,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          focusColor: appPrimaryColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }
}
