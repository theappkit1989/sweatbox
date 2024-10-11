import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/membership/payment_method_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';

import '../../extras/constant/app_color.dart';
import 'membership_controller.dart';

class PaymentMethodView extends StatelessWidget {
  final paymentMethodController = Get.put(PaymentMethodController());

  @override
  void initState() {
   paymentMethodController.loadSavedCards();
  }

  PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    final Membership selectedMembership = Get.arguments;
    paymentMethodController.membership.value = selectedMembership;

    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        backgroundColor: ColorLight.black,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(strPaymentMethod),
        titleTextStyle: const TextStyle(
          color: ColorLight.white,
          fontSize: 18.0,
          fontFamily: fontType,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCreditCardSection(),
                    buildOtherPaymentMethod(),
                  ],
                ),
              ),
            ),
            customSubmitBtn(
              text: strConfirmPayment,
              voidCallback: () {
                paymentMethodController.goToSummary();
              },
              width: Get.width,
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }


  Widget buildCreditCardSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.height * 0.05),
        const Text(
          strCreditCard,
          style: TextStyle(
            color: ColorLight.white,
            fontWeight: FontWeight.w700,
            fontFamily: fontType,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Obx(
              () =>
              ListView.builder(
                shrinkWrap: true,
                itemCount: paymentMethodController.cards.length,
                itemBuilder: (context, i) {
                  final card = paymentMethodController.cards[i];
                  final cardNumber = card['number'] as String;
                  final last4Digits = cardNumber.length >= 4
                      ? cardNumber.substring(cardNumber.length - 4)
                      : '****';
                  return Container(
                    child: ListTile(
                      onTap: () {
                        paymentMethodController.selectedValue.value = i;
                      },
                      selectedTileColor: appPrimaryColor,
                      tileColor: Colors.transparent,
                      leading: Image.asset(
                        ImageConstant.creditCardIcon,
                        width: Get.width * 0.06,
                      ),
                      trailing: Obx(() {
                        return Radio(
                          value: i,
                          groupValue: paymentMethodController.selectedValue
                              .value,
                          onChanged: (value) {
                            paymentMethodController.selectedValue.value =
                            value!;
                          },
                          activeColor: ColorLight.white,
                        );
                      }),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                        side: BorderSide(color: textFieldColor, width: 1.0),
                      ),
                      title: Text(
                        card['name'],
                        style: const TextStyle(
                          color: ColorLight.white,
                          fontSize: 14.0,
                          fontFamily: fontType,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        '**** **** **** $last4Digits',
                        style: const TextStyle(
                          color: ColorLight.white,
                          fontSize: 12.0,
                          fontFamily: fontType,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      dense: true,
                    ),
                  );
                },
              ),
        ),
        SizedBox(height: Get.height * 0.02),
        ListTile(
          onTap: () {
            paymentMethodController.goToAddNewCard();
          },
          selectedTileColor: appPrimaryColor,
          tileColor: Colors.transparent,
          leading: Image.asset(
            ImageConstant.addCircleIcon,
            width: Get.width * 0.06,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: const BorderSide(color: textFieldColor, width: 1.0),
          ),
          title: const Text(
            strAddNewCard,
            style: TextStyle(
              color: ColorLight.white,
              fontSize: 14.0,
              fontFamily: fontType,
              fontWeight: FontWeight.w700,
            ),
          ),
          dense: true,
        ),
      ],
    );
  }

  Widget buildOtherPaymentMethod() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.height * 0.02),
        const Text(
          strOtherPaymentMethods,
          style: TextStyle(
            color: ColorLight.white,
            fontWeight: FontWeight.w700,
            fontFamily: fontType,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Platform.isIOS ?
        Obx(
              () =>
              GestureDetector(
                onTap: (){paymentMethodController.selectedValue.value=-1;},
                child: ListTile(
                  selectedTileColor: appPrimaryColor,
                  tileColor: Colors.transparent,
                  leading: Image.asset(
                    ImageConstant.applePayIcon,
                    width: Get.width * 0.06,
                  ),
                  trailing: Radio(
                    value: -1,
                    groupValue: paymentMethodController.selectedValue.value,
                    onChanged: (value) {
                      paymentMethodController.selectedValue.value = value!;
                    },
                    activeColor: ColorLight.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: textFieldColor, width: 1.0),
                  ),
                  title: const Text(
                    strApplePay,
                    style: TextStyle(
                      color: ColorLight.white,
                      fontSize: 14.0,
                      fontFamily: fontType,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  dense: true,
                ),
              ),
        ):
        Obx(
              () =>
              GestureDetector(
                onTap: (){paymentMethodController.selectedValue.value=-2;},
                child: ListTile(
                  selectedTileColor: appPrimaryColor,
                  tileColor: Colors.transparent,
                  leading: Image.asset(
                    ImageConstant.googlePayIcon,
                    width: Get.width * 0.06,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    side: const BorderSide(color: textFieldColor, width: 1.0),
                  ),
                  title: const Text(
                    strGooglePay,
                    style: TextStyle(
                      color: ColorLight.white,
                      fontSize: 14.0,
                      fontFamily: fontType,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  dense: true,
                  trailing: Radio(
                    value: -2,
                    groupValue: paymentMethodController.selectedValue.value,
                    onChanged: (value) {
                      paymentMethodController.selectedValue.value = value!;
                    },
                    activeColor: ColorLight.white,
                  ),
                ),
              ),
        ),
      ],
    );
  }
}
