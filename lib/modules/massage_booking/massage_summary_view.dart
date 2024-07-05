import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/massage_booking/massage_and_entrance_controller.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/massage_booking/payment_declined_view.dart';
import 'package:s_box/modules/massage_booking/massage_summary_controller.dart';
import 'package:s_box/modules/massage_booking/testpaymentService/PaymentController.dart';
import 'package:s_box/modules/massage_booking/testpaymentService/payment_config.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../themes/colors/color_light.dart';

class MassageSummaryView extends StatelessWidget {
  final summaryController = Get.put(MassageSummaryController());

  MassageSummaryView({super.key});
  // String get defaultGooglePayConfigString => "assets/google_pay_config.json";
  //
  // String get defaultApplePayConfigString => 'assets/apple_pay_config.json';

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final Massage massage = arguments['massage'];
    final paymentType = arguments['paymentType'];
    final massageType = arguments['type'];
    var total_amount=0;
    var cardNumber = '';
    var cardname = '';
    var cardExpiryMonth = '';
    var cardExpiryYear = '';
     Membership membership;

    var cardCvv = '';
    var last4Digits = cardNumber.length >= 4
        ? cardNumber.substring(cardNumber.length - 4)
        : '****';

    if (paymentType == 'Credit Card') {
      final card = arguments['card'];
       cardNumber = card['number'] as String;
       cardname = card['name'] as String;
       cardExpiryMonth = card['expiryMonth'] as String;
       cardExpiryYear = card['expiryYear'] as String;
       cardCvv = card['cvv'] as String;
       last4Digits = cardNumber.length >= 4
          ? cardNumber.substring(cardNumber.length - 4)
          : '****';
      summaryController.cardNumber.value = cardNumber;
      summaryController.cardName.value = cardname;
      summaryController.cardExpiryMonth.value = cardExpiryMonth;
      summaryController.cardExpiryYear.value = cardExpiryYear;
      summaryController.cardCvv.value = cardCvv;
    }

    if(massageType=='2'){
       membership = arguments['membership'];
       summaryController.membership.value=membership;
      print(" membership in summary ${membership.title}");
      total_amount=massage.price+membership.price;
    }else{
      total_amount=massage.price;
    }

    summaryController.massageType.value=massageType;
    summaryController.massage.value = massage;
    summaryController.totalAmount.value =
        double.parse(total_amount.toString());
    // final bool isApplePay = paymentType == 'Apple Pay';
    // final bool isGooglePay = paymentType == 'Google Pay';
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
        physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
            width: Get.width,
            height: Get.height,
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
                buildServices(massage,massageType),


                 buildPaymentMethod(
                    last4Digits, cardExpiryMonth, cardCvv, cardname,paymentType) ,
                buildPromoCode(massage,total_amount),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                paymentType == 'Apple Pay' ? Obx(() {
                  return    Container(
                    width: Get.width*0.5,
                    height: Get.width*0.13,
                    child: ApplePayButton(


                      paymentItems: [
                        PaymentItem(
                          label: '1',
                          type: PaymentItemType.total,
                          amount: summaryController.totalAmount.value.toStringAsFixed(2),
                          status: PaymentItemStatus.final_price,
                        )
                      ],
                      style: ApplePayButtonStyle.whiteOutline,
                      type: ApplePayButtonType.inStore,

                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: (result) {

                        print(result);
                        if (result['token'] == '') {
                          // Payment was successful
                          Get.to(PaymentDeclinedView());
                          print('Payment failed or cancelled');

                          // You can perform further actions here, such as updating UI or backend
                        } else {

                          print('Payment successful');
                          summaryController.addService();

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
                        Get.snackbar("Sweatbox", e.toString());
                        Get.to(PaymentDeclinedView());
                      },
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),  paymentConfiguration: PaymentConfiguration.fromJsonString(
                        defaultApplePay),
                    ),
                  );
                }) :
                paymentType == 'Google Pay' ?
                Obx(() {
                  return
                    Container(
                      width: Get.width*0.5,
                      height: Get.width*0.13,
                      child: GooglePayButton(

                        paymentItems: [
                          PaymentItem(
                            label: 'Total',
                            amount: summaryController.totalAmount.value.toStringAsFixed(2),
                            status: PaymentItemStatus.final_price,
                          )
                        ],

                        type: GooglePayButtonType.pay,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: (result)
                        {
                          print("result is ${result['paymentMethodData']['tokenizationData']['token']}");
                          if(result['paymentMethodData']['tokenizationData']['token']=={}){
                            print("payment failed");
                            Get.to(PaymentDeclinedView());
                          }else{
                            print("payment successful");
                            summaryController.addService();

                          }

                        },
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ), paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
                      ),
                    );

                })
                    :buildBook()
              ],
            ),
          ),

              // if (isApplePay)
              //   ApplePayButton(
              //
              //     paymentItems: [
              //       PaymentItem(
              //         label: 'Total',
              //         amount: summaryController.totalAmount.value.toStringAsFixed(2),
              //         status: PaymentItemStatus.final_price,
              //       )
              //     ],
              //     style: ApplePayButtonStyle.whiteOutline,
              //     type: ApplePayButtonType.buy,
              //
              //     margin: const EdgeInsets.only(top: 15.0),
              //     onPaymentResult: (result) =>print(result),
              //     // {
              //     //   summaryController.makeApplePayPayment(PaymentItem(
              //     //     label: 'Total',
              //     //     amount: summaryController.totalAmount.value.toStringAsFixed(2),
              //     //     status: PaymentItemStatus.final_price,
              //     //   ));
              //     // },
              //     loadingIndicator: const Center(
              //       child: CircularProgressIndicator(),
              //     ),  paymentConfiguration: PaymentConfiguration.fromJsonString(
              //       defaultApplePay),
              //   ),
              // if (isGooglePay)
              //   GooglePayButton(
              //
              //     paymentItems: [
              //       PaymentItem(
              //         label: 'Total',
              //         amount: summaryController.totalAmount.value.toStringAsFixed(2),
              //         status: PaymentItemStatus.final_price,
              //       )
              //     ],
              //
              //     type: GooglePayButtonType.pay,
              //     margin: const EdgeInsets.only(top: 15.0),
              //     onPaymentResult: (result)
              //     {
              //       print("result is ${result['paymentMethodData']['tokenizationData']['token']}");
              //       if(result['paymentMethodData']['tokenizationData']['token']=={}){
              //         print("payment failed");
              //         Get.to(PaymentDeclinedView());
              //       }else{
              //         print("payment successful");
              //         summaryController.addService();
              //
              //       }
              //
              //     },
              //     loadingIndicator: const Center(
              //       child: CircularProgressIndicator(),
              //     ), paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
              //   ),

      ],
    ),)
    ,
    );
  }

  buildServices(Massage massage, massageType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
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
            GestureDetector(
              onTap: (){Get.back();Get.back();},
              child: Text(
                strChange,
                style: TextStyle(
                  color: yellowF5EA25,
                  fontWeight: FontWeight.w500,
                  fontFamily: fontType,
                  fontSize: 12,
                ),
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
                   Text(
                    massageType=="2"?'Massage + Entrance Fee':'Full Body Massage',
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
                        width: 20, height: 20,),
                      const SizedBox(width: 5,),
                      text(text: "${massage.duration.toString()} min",
                          size: 11,
                          fontWeight: FontWeight.w400,
                          color: ColorLight.white)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(ImageConstant.dateIcon,
                            width: 20, height: 20,),
                          const SizedBox(width: 5,),
                          text(text: formatDateString(massage.date.toString()),
                              size: 11,
                              fontWeight: FontWeight.w400,
                              color: ColorLight.white)
                        ],
                      ),
                      SizedBox(width: Get.width * 0.05,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(ImageConstant.timeIcon,
                            width: 20, height: 20,),
                          const SizedBox(width: 5,),
                          text(text: massage.time.toString(),
                              size: 11,
                              fontWeight: FontWeight.w400,
                              color: ColorLight.white)
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

  buildPaymentMethod(String last4digits, String cardExpiryMonth, String cardCvv,
      String cardname, paymentType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
         Row(
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
            GestureDetector(
              onTap: (){Get.back();},
              child: Text(
                strChange,
                style: TextStyle(
                  color: yellowF5EA25,
                  fontWeight: FontWeight.w500,
                  fontFamily: fontType,
                  fontSize: 12,
                ),
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
            leading: paymentType == 'Apple Pay'
                ? Image.asset(
              ImageConstant.applePayIcon,
              width: Get.width * 0.04,
            )
                : paymentType == 'Google Pay'
                ? Image.asset(
              ImageConstant.googlePayIcon,
              width: Get.width * 0.04,
            )
                : Image.asset(
              ImageConstant.creditCardIcon,
              width: Get.width * 0.06,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: const BorderSide(color: textFieldColor, width: 1.0)),
            title: paymentType == 'Apple Pay' || paymentType == 'Google Pay'
                ? Text(
                  paymentType,
                  style: const TextStyle(
                    color: ColorLight.white,
                    fontSize: 14.0,
                    fontFamily: fontType,
                    fontWeight: FontWeight.w700,
                  ),
                )
                : Text(
              cardname,
              style: const TextStyle(
                color: ColorLight.white,
                fontSize: 14.0,
                fontFamily: fontType,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: paymentType == 'Apple Pay' || paymentType == 'Google Pay'
                ? null
                : Text(
              '**** **** **** $last4digits',
              style: const TextStyle(
                color: ColorLight.white,
                fontSize: 12.0,
                fontFamily: fontType,
                fontWeight: FontWeight.w600,
              ),
            ),
            dense: true,
          ),
        )

      ],
    );
  }

  buildPromoCode(Massage massage, int total_amount) {
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

          ],
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: textFieldColor,
          ),
          height: Get.height * 0.08,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Image.asset(
                  ImageConstant.discountIcon,
                  width: Get.width * 0.08,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: summaryController.promoCont.value,
                  style: TextStyle(
                    color: ColorLight.white,
                    fontSize: 12.0,
                    fontFamily: fontType,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await summaryController.fetchDiscount() ?? 0.0;
                  Get.find<MassageSummaryController>().update();
                  print('discount value is ${summaryController.discount}');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(40),
                      topLeft: Radius.zero,
                      topRight: Radius.circular(40),
                    ),
                    color: yellowF5EA25,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            ],
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
                fontWeight: FontWeight.bold,
                fontFamily: fontType,
                fontSize: 14,
              ),
            ),
            Text(
              '£${total_amount}.00',
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
        Obx(() {
          return summaryController.discount!=0.0?Row(
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
              Text(
                '£${summaryController.discount}0',
                style: TextStyle(
                  color: ColorLight.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: fontType,
                  fontSize: 14,
                ),
              )

            ],
          ):SizedBox.shrink();}),
        // Row(
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
        //     Obx(() {
        //       return Text(
        //         '£${summaryController.discount}',
        //         style: TextStyle(
        //           color: ColorLight.white,
        //           fontWeight: FontWeight.w700,
        //           fontFamily: fontType,
        //           fontSize: 14,
        //         ),
        //       );
        //     }),
        //   ],
        // ),
        summaryController.discount!=0.0?SizedBox(
          height: Get.height * 0.02,
        ):SizedBox(
          height: Get.height * 0,
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
                fontWeight: FontWeight.bold,
                fontFamily: fontType,
                fontSize: 14,
              ),
            ),
            Obx(() {
              return Text(

                '£${double.parse(total_amount.toString()) -
                    summaryController.discount.value}0',
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.05,
      ),
      child: customSubmitBtn(
          text: strBook,
          voidCallback: () {
            summaryController.goToPaymentSuccessful();
            // summaryController.makeGooglePayPayment(PaymentItem(
            //           label: 'Total',
            //           amount: '${summaryController.totalAmount}',
            //           status: PaymentItemStatus.final_price,
            //         ),);
          },
          width: Get.width),
    );
  }
  String formatDateString(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);
    return formattedDate;
  }
}
