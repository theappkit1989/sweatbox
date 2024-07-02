import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/home_screen/home_view.dart';
import 'package:s_box/modules/massage_booking/massage_view.dart';
import 'package:s_box/modules/massage_booking/payment_declined_controller.dart';
import 'package:s_box/modules/membership/membership_view.dart';
import 'package:s_box/themes/colors/color_light.dart';

class PaymentDeclinedView extends StatelessWidget {
  final paymentDeclinedController = Get.put(PaymentDeclinedController());
  PaymentDeclinedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05,vertical: Get.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(ImageConstant.verifyImg,
              width: Get.width * 0.25,),
            ),
            SizedBox(height: Get.height * 0.05,),
            text(text: strPaymentDeclined, size: 20, fontWeight: FontWeight.w700, color: appPrimaryColor),
            SizedBox(height: Get.height * 0.02,),
            text(text: strDeclinedSubtitle, size: 14, fontWeight: FontWeight.w400, color: ColorLight.white),
            SizedBox(height: Get.height * 0.02,),
            customSubmitBtn(text: strTryAgain, voidCallback: (){Get.back();}, width: Get.width)
          ],
        ),
      ),
    );
  }
}
