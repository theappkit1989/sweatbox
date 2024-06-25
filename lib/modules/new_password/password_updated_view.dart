import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/edit_widget.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/new_password/password_updated_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';

class PasswordUpdated extends StatelessWidget {
  final pwdUpdatedController = Get.put(PasswordUpdatedController());
  PasswordUpdated({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ImageConstant.imgCheck,
                width: Get.width * 0.4,
              ),
            ),
            SizedBox(
              height: Get.height * 0.035,
            ),
            const Text(
              strPwdUpdated,
              style: TextStyle(
                color: appPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                fontFamily: fontType,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Text(
              strPwdUpdatedSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorLight.white,
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                fontFamily: fontType,
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            customSubmitBtn(
                text: login,
                voidCallback: () {
                  pwdUpdatedController.goToHome();
                },
                width: Get.width)
          ],
        ),
      ),
    );
  }
}
