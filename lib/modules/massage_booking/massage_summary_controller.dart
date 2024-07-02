import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay/pay.dart';
import 'package:s_box/modules/massage_booking/massage_and_entrance_controller.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/massage_booking/payment_declined_view.dart';
import 'package:s_box/modules/massage_booking/payment_successful_view.dart';
import 'package:flutter/material.dart';
import 'package:s_box/modules/massage_booking/testpaymentService/PaymentService.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../membership/TestPaymentScreen.dart';
import 'package:intl/intl.dart';

class MassageSummaryController extends GetxController{

  var massage = Massage(title: '', subtitle: '', price: 0, date: '', time: '', duration: '').obs;
  var storage = GetStorage();

  final RxString cardNumber=''.obs;

  final RxString cardName=''.obs;
  final RxString cardExpiryMonth=''.obs;
  final RxString cardExpiryYear=''.obs;
  final RxString cardCvv=''.obs;
  final RxString massageType=''.obs;
  var membership = Membership(title: '', user_id: '', price: 0, discount: '').obs;
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
    print("payment data is ${massage.value.price.toString()}\n${cardNumber.value.replaceAll(' ', '').toString()}\n${cardName.toString()}\n${cardExpiryMonth.toString()}\n${cardCvv.toString()}\n${cardExpiryYear.toString()}");
 try{
    final result = await PaymentService().makePayment(massage.value.price.toString(), "GBP", "VISA", cardNumber.value.replaceAll(' ', '').toString(), cardName.value.toString(),
        cardExpiryMonth.value.toString(), cardExpiryYear.value.toString(), cardCvv.value.toString());
    print("payment result is $result");
    if(result==200){
      _dismissDialog();

      print('massage type is $massageType');
      if(massageType=='2'){

        addMembership();
      }else{
        addService();
      }

    }else{
      Get.to(PaymentDeclinedView());
      _dismissDialog();
    }
  } catch (e) {
   _dismissDialog();
   print(e);
   final errorMessage = PaymentService().parseException(e.toString());
   Get.snackbar('Error', 'Payment failed: ${errorMessage}',colorText: Colors.white);
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
          Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
        }


  }
  addMembership() async {
    DateTime now = DateTime.now();
    DateTime expireTime;

    switch (membership.value.title) {
      case '24 hr Pass':
        expireTime = now.add(Duration(hours: 24));
        break;
      case '48 hr Pass':
        expireTime = now.add(Duration(hours: 48));
        break;
      case 'Weekly Pass':
        expireTime = now.add(Duration(days: 7));
        break;
      case '25 & Under':
        expireTime = now.add(Duration(hours: 24)); // Example duration, adjust as needed
        break;
      case 'One Month':
        expireTime = DateTime(now.year, now.month + 1, now.day);
        break;
      case 'Twelve Months':
        expireTime = DateTime(now.year + 1, now.month, now.day);
        break;
      default:
        expireTime = now;
        break;
    }

    // Format the dates
    String formattedNow = DateFormat('d MMMM yyyy HH:mm').format(now);
    String formattedExpireTime = DateFormat('d MMMM yyyy HH:mm').format(expireTime);

    print("active time $formattedNow expire time $formattedExpireTime");
    // membership.value.activeTime = formattedNow;
    // membership.value.expireTime = formattedExpireTime;

    Membership _membership=Membership(title: membership.value.title, user_id: membership.value.user_id, price: totalAmount.value.toInt(), discount: membership.value.discount,activeTime: formattedNow,expireTime: formattedExpireTime);

    var _response = await ApiController().addMembership(
        userId,
        membership.value.title.toString(),
        totalAmount.value.toString(),
        discount.value.toInt(),
        _membership.activeTime.toString(),
        _membership.expireTime.toString(),
        token);
    if (_response.status == true) {

      addService();
      // Get.to(PaymentSuccessfulView(), arguments: {'membership': _response});
    } else {

      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
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
        discount.value=calculateDiscount(double.parse(totalAmount.toString()),double.parse(_response.promo!.last.discount??'0.0'));
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
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
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

  // void makeApplePayPayment(PaymentItem paymentItem) async {
  //   isLoading.value = true;
  //   try {
  //     final token = await getApplePayToken(paymentItem);
  //     final result = await paymentService.makePayment(paymentItem.amount,'USD', 'APPLEPAY', token);
  //     addService();
  //     paymentResult.value = result;
  //   } catch (e) {
  //     Get.to(PaymentDeclinedView());
  //     Get.snackbar('Error', 'Payment failed: $e',colorText: Colors.white);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // void makeGooglePayPayment(PaymentItem paymentItem) async {
  //   isLoading.value = true;
  //   try {
  //     // final token = result['paymentMethodData']['tokenizationData']['token'];
  //     // final token = await getGooglePayToken(paymentItem);
  //     final result = await paymentService.makePayment(paymentItem.amount, "USD", 'GOOGLEPAY', token);
  //     paymentResult.value = result;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Payment failed: $e',colorText: Colors.white);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  //
  // Future<String> getApplePayToken(PaymentItem paymentItem) async {
  //   // Implement the method to get Apple Pay token
  //   // Refer to the official documentation for details
  //   return 'apple_pay_token';
  // }
  //
  // Future<String> getGooglePayToken(PaymentItem paymentItem) async {
  //   try {
  //     // Initialize the Google Pay environment
  //     const MethodChannel _channel = MethodChannel('plugins.flutter.io/pay');
  //     final String token = await _channel.invokeMethod('requestPayment', {
  //       'gateway': 'paynt', // Replace with your payment gateway name
  //       'gatewayMerchantId': '8ac7a4c88feb836d018fed0b84160266', // Replace with your merchant ID
  //       'totalPrice': paymentItem.amount,
  //       'currencyCode': 'GBP',
  //       'countryCode': 'UK', // Replace with your country code
  //       'environment': 'TEST', // Use 'PRODUCTION' for the production environment
  //     });
  //
  //     return token;
  //   } catch (e) {
  //     print('Error getting Google Pay token: $e');
  //     throw Exception('Failed to get Google Pay token');
  //   }
  // }

}