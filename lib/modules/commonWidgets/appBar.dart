
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/themes/colors/color_light.dart';


customAppBar([String title = ""]) {
  return AppBar(
    backgroundColor: ColorLight.white,
    leadingWidth: Get.width * 0.1,
    title: Text(
      title,
      style: const TextStyle(
          fontFamily: fontType,
          color: ColorLight.black,
          fontWeight: FontWeight.w600),
    ),
    centerTitle: true,
    elevation: 0.0,
    leading: GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.05, right: 0, top: 0, bottom: 0),
        child: Image.asset(
          ImageConstant.backArrowIcon,
        ),
      ),
    ),
  );
}

customAppBarWithActions() {
  return AppBar(
    backgroundColor: ColorLight.white,
    leadingWidth: Get.width * 0.1,
    elevation: 0.0,
    leading: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding:
            EdgeInsets.only(left: Get.width * 0.05, right: 0, top: 0, bottom: 0),
        child: Image.asset(
          ImageConstant.backArrowIcon,
        ),
      ),
    ),
    actions: [
      /*Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          height: 20,
          decoration: BoxDecoration(
            color: ColorLight.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: ColorLight.outlineGreyE5E5E5, width: 1.0),
          ),
          child: Text(
            strSaveExit,
            style: TextStyle(
                fontFamily: fontType,
                color: ColorLight.grey1B1C1E,
                fontSize: Get.height * 0.02),
          ),
        ),
      ),*/
    ],
  );
}
