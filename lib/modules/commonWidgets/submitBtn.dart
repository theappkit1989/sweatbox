import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../themes/colors/color_light.dart';

customSubmitBtn({required String text, required VoidCallback voidCallback, required double width}) {
  return MaterialButton(
    onPressed: voidCallback,
    child: Text(
      text,
      style: TextStyle(
          fontFamily: fontType,
          color: ColorLight.white,
          fontWeight: FontWeight.w700,
          fontSize: Get.height * 0.022),
    ),
    color: appPrimaryColor,
    minWidth: width,
    elevation: 0.0,
    height: Get.height * 0.065,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
  );
}

customSubmitBtnWithBorder({required String text, required VoidCallback voidCallback, required double width}) {
  return MaterialButton(
    onPressed: voidCallback,
    child: Text(
      text,
      style: TextStyle(
          fontFamily: fontType,
          color: ColorLight.textColorBlue,
          fontWeight: FontWeight.w500,
          fontSize: Get.height * 0.022),
    ),
    color: ColorLight.white,
    minWidth: width,
    height: Get.height * 0.065,
    elevation: 0.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0),
    side: const BorderSide(color: ColorLight.textColorBlue,width: 2.0)),
  );
}
