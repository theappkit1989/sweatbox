import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:s_box/modules/massage_booking/testpaymentService/PaymentService.dart';


class PaymentController extends GetxController {
  final PaymentService paymentService = PaymentService();
  var isLoading = false.obs;
  var paymentResult = {}.obs;

  void makeApplePayPayment(PaymentItem paymentItem) async {
    isLoading.value = true;
    try {
      final token = await getApplePayToken(paymentItem);
      final result = await paymentService.makePayment(paymentItem.amount,'USD', 'APPLEPAY', token);
      paymentResult.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Payment failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void makeGooglePayPayment(PaymentItem paymentItem) async {
    isLoading.value = true;
    try {
      final token = await getGooglePayToken(paymentItem);
      final result = await paymentService.makePayment(paymentItem.amount, 'USD', 'GOOGLEPAY', token);
      paymentResult.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Payment failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> getApplePayToken(PaymentItem paymentItem) async {
    // Implement the method to get Apple Pay token
    // Refer to the official documentation for details
    return 'apple_pay_token';
  }

  Future<String> getGooglePayToken(PaymentItem paymentItem) async {
    // Implement the method to get Google Pay token
    // Refer to the official documentation for details
    return 'google_pay_token';
  }
}
