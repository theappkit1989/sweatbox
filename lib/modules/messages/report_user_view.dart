import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/messages/report_user_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../commonWidgets/common.dart';

class ReportUserView extends StatelessWidget {
  final reportUserController = Get.put(ReportUserController());
  ReportUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                ImageConstant.reportImg,
                width: Get.width * 0.4,
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            text(
                text: strReportSubtitle,
                size: 14,
                fontWeight: FontWeight.w400,
                color: ColorLight.white),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    strReport,
                    style: TextStyle(
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w700,
                        fontSize: Get.height * 0.022),
                  ),
                  color: appPrimaryColor,
                  minWidth: Get.width * 0.42,
                  elevation: 0.0,
                  height: Get.height * 0.065,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    strNotNow,
                    style: TextStyle(
                        fontFamily: fontType,
                        color: appPrimaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: Get.height * 0.022),
                  ),
                  color: appPrimaryColor.withOpacity(0.1),
                  minWidth: Get.width * 0.42,
                  elevation: 0.0,
                  height: Get.height * 0.065,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
