import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/membership/membership_controller.dart';
import 'package:s_box/modules/membership/summary_controller.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../services/commonModels/cardModal.dart';
import '../../themes/colors/color_light.dart';
import '../massage_booking/payment_declined_view.dart';
import '../massage_booking/testpaymentService/payment_config.dart';

class SummaryView extends StatelessWidget {
  final summaryController = Get.put(MembershipSummaryController());

  SummaryView({super.key});

  String get defaultGooglePayConfigString => "assets/google_pay_config.json";

  String get defaultApplePayConfigString => 'assets/apple_pay_config.json';

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final Membership membership = arguments['membership'];
    final paymentType = arguments['paymentType'];
    summaryController.membership.value=membership;
    summaryController.totalAmount.value=double.parse(membership.price.toString());
    print('name is ${membership.title}');
    if (paymentType == 'Credit Card') {
      final card = arguments['card'];
      final cardNumber = card['number'] as String;
      final cardname = card['name'] as String;
      final cardExpiryMonth = card['expiryMonth'] as String;
      final cardExpiryyear = card['expiryYear'] as String;
      final cardCvv = card['cvv'] as String;
      final last4Digits = cardNumber.length >= 4
          ? cardNumber.substring(cardNumber.length - 4)
          : '****';
      summaryController.cardNumber.value = cardNumber;
      summaryController.cardName.value = cardname;
      summaryController.cardExpiryMonth.value = cardExpiryMonth;
      summaryController.cardExpiryYear.value = cardExpiryyear;
      summaryController.cardCvv.value = cardCvv;
    }
    final cardNumber = '';
    final cardname = '';
    final cardExpiryMonth = '';

    final cardCvv = '';
    final last4Digits = cardNumber.length >= 4
        ? cardNumber.substring(cardNumber.length - 4)
        : '****';
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
                  buildServices(membership),
                  buildPaymentMethod(last4Digits,cardExpiryMonth,cardCvv,cardname),
                  buildPromoCode(membership),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            paymentType == 'Apple Pay' ? Obx(() {
              return    ApplePayButton(

                paymentItems: [
                  PaymentItem(
                    label: 'Total',
                    amount: summaryController.totalAmount.value.toStringAsFixed(2),
                    status: PaymentItemStatus.final_price,
                  )
                ],
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.book,

                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: (result) {

                  print(result);
                  if (result['paymentMethod'] == '') {
                    // Payment was successful
                    print('Payment failed or cancelled');
                    summaryController.addMembership();
                    // You can perform further actions here, such as updating UI or backend
                  } else {
                    Get.to(PaymentDeclinedView());
                    print('Payment successful');

                    // Handle error or show appropriate message to the user
                  }
                },
                // {
                //   summaryController.makeApplePayPayment(PaymentItem(
                //     label: 'Total',
                //     amount: summaryController.totalAmount.value.toStringAsFixed(2),
                //     status: PaymentItemStatus.final_price,
                //   ));
                // },
                onError: (e){
                  Get.snackbar("Error", e.toString());
                  Get.to(PaymentDeclinedView());
                },
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),  paymentConfiguration: PaymentConfiguration.fromJsonString(
                  defaultApplePay),
              );
            }) :
            paymentType == 'Google Pay' ?
            Obx(() {
              return
                GooglePayButton(

                  paymentItems: [
                    PaymentItem(
                      label: 'Total',
                      amount: summaryController.totalAmount.value.toStringAsFixed(2),
                      status: PaymentItemStatus.final_price,
                    )
                  ],

                  type: GooglePayButtonType.book,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: (result)
                  {
                    print("result is ${result['paymentMethodData']['tokenizationData']['token']}");
                    if(result['paymentMethodData']['tokenizationData']['token']=={}){
                      print("payment failed");
                      Get.to(PaymentDeclinedView());
                    }else{
                      print("payment successful");
                      summaryController.addMembership();

                    }

                  },
                  onError: (e){
                    Get.snackbar("Error", e.toString());
                    Get.to(PaymentDeclinedView());
                  },
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ), paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
                );

            })
                :buildBook()
            // paymentType == 'Apple Pay' ? Obx(() {
            //   return ApplePayButton(
            //     paymentConfiguration: PaymentConfiguration.fromJsonString(
            //         MembershipSummaryController.defaultApplePay),
            //     // paymentConfigurationAsset: 'apple_pay_config.json',
            //     onPaymentResult: summaryController.paymentResult,
            //     paymentItems: [
            //       PaymentItem(
            //         label: 'Total',
            //         amount: '${summaryController.totalAmount}',
            //         status: PaymentItemStatus.final_price,
            //       ),
            //     ],
            //     onError: (e) {
            //       Get.snackbar('Error', 'Apple Pay error: $e');
            //       print('apple pay error$e');
            //     },
            //   );
            // }) :
            // paymentType == 'Google Pay' ? Obx(() {
            //   print(paymentType);
            //
            //   return GooglePayButton(
            //     paymentConfiguration: PaymentConfiguration.fromJsonString(
            //         MembershipSummaryController.defaultGooglePay),
            //
            //     // paymentConfigurationAsset: 'google_pay_config.json',
            //     paymentItems:  [
            //         PaymentItem(
            //           label: 'Total',
            //           amount: '${summaryController.totalAmount}',
            //           status: PaymentItemStatus.final_price,
            //         ),
            //       ],
            //     type: GooglePayButtonType.buy,
            //     margin: const EdgeInsets.only(top: 15.0),
            //     onPaymentResult: summaryController.paymentResult,
            //       onError: (e) {
            //             Get.snackbar('Error', 'Google Pay error: $e');
            //             print('google pay error$e');
            //           },
            //     loadingIndicator: const Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            //   //   GooglePayButton(
            //   //   paymentConfigurationAsset: 'google_pay_config.json',
            //   //   onPaymentResult: summaryController.paymentResult,
            //   //   paymentItems: [
            //   //     PaymentItem(
            //   //       label: 'Total',
            //   //       amount: '${summaryController.totalAmount}',
            //   //       status: PaymentItemStatus.final_price,
            //   //     ),
            //   //   ],
            //   //   onError: (e) {
            //   //     Get.snackbar('Error', 'Google Pay error: $e');
            //   //     print('google pay error$e');
            //   //   },
            //   // );
            // }) :buildBook()
          ],
        ),
      ),
    );
  }

  buildServices(Membership membership) {
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
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              ImageConstant.serviceImg,
              width: Get.width * 0.18,
              height: Get.height * 0.1,
              fit: BoxFit.cover,
            ),
          ),
          title: Row(
            children: [
               Text(
                membership.title,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: fontType,
                  fontWeight: FontWeight.w600,
                  color: ColorLight.white,
                ),
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              Container(
                width: Get.width * 0.18,
                //height: Get.height * 0.05,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: ColorLight.white),
                child:  Text(
                  membership.discount,
                  style: TextStyle(
                    color: appPrimaryColor,
                    fontWeight: FontWeight.w500,
                    fontFamily: fontType,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          subtitle:  Text(
            '£${membership.price}',
            style: TextStyle(
              fontSize: 20,
              fontFamily: fontType,
              fontWeight: FontWeight.w800,
              color: ColorLight.white,
            ),
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

  buildPromoCode(Membership membership) {
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
              strPromoCode,
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
              borderRadius: BorderRadius.circular(40), color: textFieldColor),
          height: Get.height * 0.08,
          alignment: Alignment.center,
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Image.asset(
                ImageConstant.discountIcon,
                width: Get.width * 0.08,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: const BorderSide(color: textFieldColor, width: 1.0)),
            title: Obx(() {
              return TextField(

                controller: summaryController.promoCont.value,
                style: TextStyle(
                    color: ColorLight.white,
                    fontSize: 12.0,
                    fontFamily: fontType,
                    fontWeight: FontWeight.w400),
              );
            }),
            trailing: Container(
              alignment: Alignment.center,
              height: Get.height * 0.12,
              width: Get.width * 0.25,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.circular(40),
                    topLeft: Radius.zero,
                    topRight: Radius.circular(40),
                  ),
                  color: yellowF5EA25),
              child: GestureDetector(
                onTap: () async {
                  await summaryController.fetchDiscount() ?? 0.0;
                  Get.find<MembershipSummaryController>().update();
                },
                child: Text(
                  strApply,
                  style: TextStyle(
                    color: ColorLight.black,
                    fontWeight: FontWeight.w600,
                    fontFamily: fontType,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ),
          ),
        ),
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
              '£${membership.price.toString()}.00',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              strDiscount,
              style: TextStyle(
                color: ColorLight.white,
                fontWeight: FontWeight.w400,
                fontFamily: fontType,
                fontSize: 12,
              ),
            ),
            Obx(() {
              return Text(
                '£${summaryController.discount}',
                style: TextStyle(
                  color: ColorLight.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: fontType,
                  fontSize: 14,
                ),
              );
            }),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          children: List.generate(
              150 ~/ 1,
                  (index) =>
                  Expanded(
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
            Obx(() {
              return Text(

                '£${summaryController.totalAmount}',
                style: TextStyle(
                  color: ColorLight.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: fontType,
                  fontSize: 14,
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  buildBook() {
    return Padding(padding: EdgeInsets.symmetric(
      horizontal: Get.width * 0.05,
    ),
    child: customSubmitBtn(
        text: strBook, voidCallback: () {summaryController.goToPaymentSuccessful();}, width: Get.width),);
  }
}
