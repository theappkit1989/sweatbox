import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay/pay.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/massage_booking/payment_declined_view.dart';
import 'package:s_box/modules/massage_booking/payment_successful_view.dart';
import 'package:flutter/material.dart';
import 'package:s_box/modules/massage_booking/testpaymentService/PaymentService.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../membership/TestPaymentScreen.dart';


class MassageSummaryController extends GetxController{

  var massage = Massage(title: '', subtitle: '', price: 0, date: '', time: '', duration: '').obs;
  var storage = GetStorage();

  final RxString cardNumber=''.obs;

  final RxString cardName=''.obs;
  final RxString cardExpiryMonth=''.obs;
  final RxString cardExpiryYear=''.obs;
  final RxString cardCvv=''.obs;
  String token='';
  String userId='';
  var promoCont = TextEditingController().obs;
  RxDouble discount=0.0.obs;
  RxDouble totalAmount=0.0.obs;
  final PaymentServiceApplePay paymentService = PaymentServiceApplePay();
  var isLoading = false.obs;
  var paymentResult = {}.obs;
  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    userId = storage.read(userid).toString();
    // print("token is $isLoggedIn and id is $id");

  }
  Future<void> goToPaymentSuccessful() async {
    _showLoadingDialog();
    print("payment data is ${massage.value.price.toString()}\n${cardNumber.toString()}\n${cardName.toString()}\n${cardExpiryMonth.toString()}\n${cardCvv.toString()}\n${cardExpiryYear.toString()}");
 try{
    final result = await PaymentService().makePayment(massage.value.price.toString(), "GBP", "VISA", cardNumber.toString(), cardName.toString(),
        cardExpiryMonth.toString(), cardExpiryYear.toString(), cardCvv.toString());
    print("payment result is $result");
    if(result==200){
      _dismissDialog();
      addService();
    }else{
      Get.to(PaymentDeclinedView());
      _dismissDialog();
    }
  } catch (e) {
   _dismissDialog();
   Get.snackbar('Error', 'Payment failed: ${e}');
   Get.to(PaymentDeclinedView());


  }
    // Get.to(PaymentSuccessfulView());
  }
  addService() async {

        var _response = await ApiController().addService(userId,'Massage',totalAmount.value.toString(),massage.value.date.toString(),
            massage.value.time.toString(),massage.value.duration.toString(),token.toString());
        if (_response.status == true) {
          _dismissDialog();
          Get.to(PaymentSuccessfulView(),arguments: {'massage':_response});
          // goToPwdUpdated();
          // Get.back();
        } else {
          _dismissDialog();
          Get.snackbar("Error", _response.message ?? 'Something went wrong!');
        }


  }
  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
  Future<double?> fetchDiscount() async {
    _showLoadingDialog();
    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().getPromoCode(token,promoCont.value.text);
    if (_response.status == true) {
      _dismissDialog();
      if(!_response.promo!.isEmpty){


        // massage.value.price=int.parse(_response.promo!.last.discount!);
        discount.value=calculateDiscount(double.parse(massage.value.price.toString()),double.parse(_response.promo!.last.discount??'0.0'));
        totalAmount.value=double.parse(massage.value.price.toString())-discount.value;
        print("total discount is${discount.value}");
        return double.parse(_response.promo!.last.discount??'0.0');
      }discount.value=0.0;
      totalAmount.value=double.parse(massage.value.price.toString());
      return 0.0;

    } else {
      _dismissDialog();
      discount.value=0.0;
      totalAmount.value=double.parse(massage.value.price.toString());
      Get.snackbar("Error", _response.message ?? 'Something went wrong!');
      return 0.0;
    }
  }

  double calculateDiscount(double totalAmount, double discountPercentage) {
    // print(totalAmount);
    // print(discountPercentage);
    // Calculate the discount amount
    double discountAmount = (totalAmount * discountPercentage) / 100;


    // Subtract the discount amount from the total amount to get the new amount
    // double newAmount = totalAmount - discountAmount;

    return discountAmount;
  }

  void makeApplePayPayment(PaymentItem paymentItem) async {
    isLoading.value = true;
    try {
      final token = await getApplePayToken(paymentItem);
      final result = await paymentService.makePayment(paymentItem.amount,'USD', 'APPLEPAY', token);
      addService();
      paymentResult.value = result;
    } catch (e) {
      Get.to(PaymentDeclinedView());
      Get.snackbar('Error', 'Payment failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void makeGooglePayPayment(PaymentItem paymentItem) async {
    isLoading.value = true;
    try {
      // final token = result['paymentMethodData']['tokenizationData']['token'];
      // final token = await getGooglePayToken(paymentItem);
      final result = await paymentService.makePayment(paymentItem.amount, "USD", 'GOOGLEPAY', token);
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
    try {
      // Initialize the Google Pay environment
      const MethodChannel _channel = MethodChannel('plugins.flutter.io/pay');
      final String token = await _channel.invokeMethod('requestPayment', {
        'gateway': 'paynt', // Replace with your payment gateway name
        'gatewayMerchantId': '8ac7a4c88feb836d018fed0b84160266', // Replace with your merchant ID
        'totalPrice': paymentItem.amount,
        'currencyCode': 'GBP',
        'countryCode': 'UK', // Replace with your country code
        'environment': 'TEST', // Use 'PRODUCTION' for the production environment
      });

      return token;
    } catch (e) {
      print('Error getting Google Pay token: $e');
      throw Exception('Failed to get Google Pay token');
    }
  }

}