import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';
import 'package:s_box/modules/massage_booking/testpaymentService/PaymentController.dart';



class PaymentScreen extends StatelessWidget {
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ApplePayButton(
              paymentConfigurationAsset: 'apple_pay_config.json',
              onPaymentResult: paymentController.paymentResult,
              paymentItems: [
                PaymentItem(
                  label: 'Total',
                  amount: '10.00',
                  status: PaymentItemStatus.final_price,
                ),
              ],
              onError: (e) {
                Get.snackbar('Error', 'Apple Pay error: $e');
              },
            ),
            GooglePayButton(
              paymentConfigurationAsset: 'google_pay_config.json',
              onPaymentResult: paymentController.paymentResult,
              paymentItems: [
                PaymentItem(
                  label: 'Total',
                  amount: '10.00',
                  status: PaymentItemStatus.final_price,
                ),
              ],
              onError: (e) {
                Get.snackbar('Error', 'Google Pay error: $e');
              },
            ),
            SizedBox(height: 20),
            Obx(() {
              if (paymentController.paymentResult.isNotEmpty) {
                return Text('Payment Result: ${paymentController.paymentResult}');
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
