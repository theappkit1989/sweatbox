import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/massage_booking/summary_controller.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../themes/colors/color_light.dart';

class SummaryView extends StatelessWidget {
  final summaryController = Get.put(SummaryController());
  SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final Massage massage = arguments['massage'];
    print('name is ${massage.title}');
    final  card = arguments['card'];
    final cardNumber = card['number'] as String;
    final cardname = card['name'] as String;
    final cardExpiryMonth = card['expiryMonth'] as String;
    final cardExpiryyear = card['expiryYear'] as String;
    final cardCvv = card['cvv'] as String;
    final last4Digits = cardNumber.length >= 4
        ? cardNumber.substring(cardNumber.length - 4)
        : '****';
    summaryController.massage.value=massage;
    summaryController.cardNumber.value=cardNumber;
    summaryController.cardName.value=cardname;
    summaryController.cardExpiryMonth.value=cardExpiryMonth;
    summaryController.cardExpiryYear.value=cardExpiryyear;
    summaryController.cardCvv.value=cardCvv;
    return Scaffold(
      backgroundColor: ColorLight.white,
      appBar: AppBar(
        backgroundColor: ColorLight.white,
        centerTitle: true,
        title: const Text(
          strSummary,
        ),
        titleTextStyle: const TextStyle(
          color: ColorLight.black,
          fontWeight: FontWeight.w700,
          fontFamily: fontType,
          fontSize: 18.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.height * 0.04),
              decoration: BoxDecoration(
                color: ColorLight.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildServices(massage),
                  buildPaymentMethod(last4Digits,cardExpiryMonth,cardCvv,cardname),
                  buildPromoCode(massage),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            buildBook()
          ],
        ),
      ),
    );
  }

  buildServices(Massage massage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              strServices,
              style: TextStyle(
                color: ColorLight.white,
                fontWeight: FontWeight.w700,
                fontFamily: fontType,
                fontSize: 13,
              ),
            ),
            Text(
              strChange,
              style: TextStyle(
                color: yellowF5EA25,
                fontWeight: FontWeight.w500,
                fontFamily: fontType,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
        SizedBox(
          //color: Colors.orange,
          width: Get.width,
          height: Get.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  ImageConstant.serviceImg,
                  width: Get.width * 0.22,
                  height: Get.height * 0.12,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: Get.width * 0.04,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Massage + Entrance Fee',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: fontType,
                      fontWeight: FontWeight.w700,
                      color: ColorLight.white,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(ImageConstant.timeIcon,
                        width: 20,height: 20,),
                      const SizedBox(width: 5,),
                      text(text: "${massage.duration.toString()} min", size: 11, fontWeight: FontWeight.w400, color: ColorLight.white)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(ImageConstant.dateIcon,
                            width: 20,height: 20,),
                          const SizedBox(width: 5,),
                          text(text: massage.date.toString(), size: 11, fontWeight: FontWeight.w400, color: ColorLight.white)
                        ],
                      ),
                      SizedBox(width: Get.width * 0.05,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(ImageConstant.timeIcon,
                            width: 20,height: 20,),
                          const SizedBox(width: 5,),
                          text(text: massage.time.toString(), size: 11, fontWeight: FontWeight.w400, color: ColorLight.white)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildPaymentMethod(String last4digits, String cardExpiryMonth, String cardCvv, String cardname) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              strPaymentMethod,
              style: TextStyle(
                color: ColorLight.white,
                fontWeight: FontWeight.w700,
                fontFamily: fontType,
                fontSize: 13,
              ),
            ),
            Text(
              strChange,
              style: TextStyle(
                color: yellowF5EA25,
                fontWeight: FontWeight.w500,
                fontFamily: fontType,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: textFieldColor)),
          child: ListTile(
            leading: Image.asset(
              ImageConstant.creditCardIcon,
              width: Get.width * 0.06,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: const BorderSide(color: textFieldColor, width: 1.0)),
            title:  Text(
              cardname,
              style: TextStyle(
                  color: ColorLight.white,
                  fontSize: 14.0,
                  fontFamily: fontType,
                  fontWeight: FontWeight.w700),
            ),
            subtitle:  Text(
              '**** **** **** $last4digits',
              style: TextStyle(
                  color: ColorLight.white,
                  fontSize: 12.0,
                  fontFamily: fontType,
                  fontWeight: FontWeight.w600),
            ),
            dense: true,
          ),
        ),
      ],
    );
  }

  buildPromoCode(Massage massage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        // const Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(
        //       strPromoCode,
        //       style: TextStyle(
        //         color: ColorLight.white,
        //         fontWeight: FontWeight.w700,
        //         fontFamily: fontType,
        //         fontSize: 13,
        //       ),
        //     ),
        //     Text(
        //       strChange,
        //       style: TextStyle(
        //         color: yellowF5EA25,
        //         fontWeight: FontWeight.w500,
        //         fontFamily: fontType,
        //         fontSize: 12,
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: Get.height * 0.015,
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(40), color: textFieldColor),
        //   height: Get.height * 0.08,
        //   alignment: Alignment.center,
        //   child: ListTile(
        //     leading: Padding(
        //       padding: const EdgeInsets.only(left: 12.0),
        //       child: Image.asset(
        //         ImageConstant.discountIcon,
        //         width: Get.width * 0.08,
        //       ),
        //     ),
        //     contentPadding: EdgeInsets.zero,
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(40),
        //         side: const BorderSide(color: textFieldColor, width: 1.0)),
        //     title: const Text(
        //       strEnterCode,
        //       style: TextStyle(
        //           color: ColorLight.white,
        //           fontSize: 12.0,
        //           fontFamily: fontType,
        //           fontWeight: FontWeight.w400),
        //     ),
        //     trailing: Container(
        //       alignment: Alignment.center,
        //       height: Get.height * 0.12,
        //       width: Get.width * 0.25,
        //       decoration: const BoxDecoration(
        //           borderRadius: BorderRadius.only(
        //             bottomLeft: Radius.zero,
        //             bottomRight: Radius.circular(40),
        //             topLeft: Radius.zero,
        //             topRight: Radius.circular(40),
        //           ),
        //           color: yellowF5EA25),
        //       child: const Text(
        //         strApply,
        //         style: TextStyle(
        //           color: ColorLight.black,
        //           fontWeight: FontWeight.w600,
        //           fontFamily: fontType,
        //           fontSize: 13.0,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: Get.height * 0.02,
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              strSubtotal,
              style: TextStyle(
                color: ColorLight.white,
                fontWeight: FontWeight.w400,
                fontFamily: fontType,
                fontSize: 12,
              ),
            ),
            Text(
              '£${massage.price.toString()}.00',
              style: TextStyle(
                color: ColorLight.white,
                fontWeight: FontWeight.w700,
                fontFamily: fontType,
                fontSize: 14,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        // const Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(
        //       strDiscount,
        //       style: TextStyle(
        //         color: ColorLight.white,
        //         fontWeight: FontWeight.w400,
        //         fontFamily: fontType,
        //         fontSize: 12,
        //       ),
        //     ),
        //     Text(
        //       '£9.00',
        //       style: TextStyle(
        //         color: ColorLight.white,
        //         fontWeight: FontWeight.w700,
        //         fontFamily: fontType,
        //         fontSize: 14,
        //       ),
        //     ),
        //   ],
        // ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          children: List.generate(
              150 ~/ 1,
              (index) => Expanded(
                    child: Container(
                      color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                      height: 1,
                    ),
                  )),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              strTotal,
              style: TextStyle(
                color: ColorLight.white,
                fontWeight: FontWeight.w400,
                fontFamily: fontType,
                fontSize: 12,
              ),
            ),
            Text(
              '£${massage.price.toString()}.00',
              style: TextStyle(
                color: ColorLight.white,
                fontWeight: FontWeight.w700,
                fontFamily: fontType,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  buildBook() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.05,
      ),
      child: customSubmitBtn(
          text: strBook,
          voidCallback: () {
            summaryController.goToPaymentSuccessful();
          },
          width: Get.width),
    );
  }
}
