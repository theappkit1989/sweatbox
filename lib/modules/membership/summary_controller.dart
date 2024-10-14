import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pay/pay.dart';
import 'package:s_box/modules/membership/membership_controller.dart';
import 'package:s_box/modules/membership/payment_successful_view.dart';

import '../../extras/constant/common_validation.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../massage_booking/payment_declined_view.dart';
import '../my_profile/my_profile_controller.dart';
import 'TestPaymentScreen.dart';

class MembershipSummaryController extends GetxController {
  var membership = Membership(title: '', user_id: '', price: 0, discount: '').obs;
  var storage = GetStorage();
  final RxString cardNumber = ''.obs;
  final RxString cardName = ''.obs;
  final RxString cardExpiryMonth = ''.obs;
  final RxString cardExpiryYear = ''.obs;
  final RxString cardCvv = ''.obs;
  String token = '';
  String userId = '';
  String userFirstName = '';
  String userLastName = '';
  var promoCont = TextEditingController().obs;
  RxDouble discount=0.0.obs;
  RxDouble totalAmount=0.0.obs;

  var isLoading = false.obs;
  var paymentResult = {}.obs;
  @override
  void onInit() {
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    userId = storage.read(userid).toString();
    userFirstName = storage.read(firstName).toString();
    userLastName = storage.read(lastName).toString();

  }
  static const String defaultApplePay = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.com.sams.fish",
    "displayName": "Sam's Fish",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "US",
    "currencyCode": "USD",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": [],
    "shippingMethods": [
      {
        "amount": "0.00",
        "detail": "Available within an hour",
        "identifier": "in_store_pickup",
        "label": "In-Store Pickup"
      },
      {
        "amount": "4.99",
        "detail": "5-8 Business Days",
        "identifier": "flat_rate_shipping_id_2",
        "label": "UPS Ground"
      },
      {
        "amount": "29.99",
        "detail": "1-3 Business Days",
        "identifier": "flat_rate_shipping_id_1",
        "label": "FedEx Priority Mail"
      }
    ]
  }
}''';
  static const String defaultGooglePay = '''{
  "provider": "google_pay",
  "data": {
    "environment": "TEST",
    "apiVersion": 2,
    "apiVersionMinor": 0,
    "allowedPaymentMethods": [
      {
        "type": "CARD",
        "tokenizationSpecification": {
          "type": "PAYMENT_GATEWAY",
          "parameters": {
            "gateway": "example",
            "gatewayMerchantId": "gatewayMerchantId"
          }
        },
        "parameters": {
          "allowedCardNetworks": ["VISA", "MASTERCARD"],
          "allowedAuthMethods": ["PAN_ONLY", "CRYPTOGRAM_3DS"],
          "billingAddressRequired": true,
          "billingAddressParameters": {
            "format": "FULL",
            "phoneNumberRequired": true
          }
        }
      }
    ],
    "merchantInfo": {
      "merchantId": "01234567890123456789",
      "merchantName": "Example Merchant Name"
    },
    "transactionInfo": {
      "countryCode": "US",
      "currencyCode": "USD"
    }
  }
}''';



  Future<void> goToPaymentSuccessful() async {
    _showLoadingDialog();
    print(
        "payment data is ${membership.value.price.toString()}\n${cardNumber.toString()}\n${cardName.toString()}\n${cardExpiryMonth.toString()}\n${cardCvv.toString()}\n${cardExpiryYear.toString()}");
    try {
      final result = await PaymentService().processPayment(membership.value.title,(totalAmount.value).toString(),
          "GBP",
          "VISA",
          cardNumber.replaceAll(' ', '').toString(),
          userFirstName,
          userLastName,
          cardExpiryMonth.toString(),
          cardExpiryYear.toString(),
          cardCvv.toString());
      // final result = await PaymentService().makePayment(
      //     (totalAmount.value.round()).toString(),
      //     "GBP",
      //     "VISA",
      //     cardNumber.replaceAll(' ', '').toString(),
      //     cardName.toString(),
      //     cardExpiryMonth.toString(),
      //     cardExpiryYear.toString(),
      //     cardCvv.toString());
      print("payment result is $result");
      if (result == 200) {
        // _dismissDialog();
        addMembership();
      } else {
        Get.to(PaymentDeclinedView());
        // _dismissDialog();
      }
    } catch (e) {
      // _dismissDialog();
      Get.to(PaymentDeclinedView());
      print('Payment failed: ${e}');
      // final errorMessage = PaymentService().parseException(e.toString());
      // Get.snackbar('Error', 'Payment failed: ${errorMessage}',colorText: Colors.white);
    }
  }
  Future<void> goToPaymentSuccessfulApplepay() async {
    _showLoadingDialog();
    print(
        "payment data is ${membership.value.price.toString()}\n${cardNumber.toString()}\n${cardName.toString()}\n${cardExpiryMonth.toString()}\n${cardCvv.toString()}\n${cardExpiryYear.toString()}");
    try {
      final result = await PaymentService().processPaymentApplepay(membership.value.title,(totalAmount.value).toString(),
          "GBP",
          "VISA",
          cardNumber.replaceAll(' ', '').toString(),
          userFirstName.toString(),
          userLastName.toString(),
          cardExpiryMonth.toString(),
          cardExpiryYear.toString(),
          cardCvv.toString());
      // final result = await PaymentService().makePayment(
      //     (totalAmount.value.round()).toString(),
      //     "GBP",
      //     "VISA",
      //     cardNumber.replaceAll(' ', '').toString(),
      //     cardName.toString(),
      //     cardExpiryMonth.toString(),
      //     cardExpiryYear.toString(),
      //     cardCvv.toString());
      print("payment result is $result");
      if (result == 200) {
        // _dismissDialog();
        addMembership();
      } else {
        Get.to(PaymentDeclinedView());
        // _dismissDialog();
      }
    } catch (e) {
      // _dismissDialog();
      Get.to(PaymentDeclinedView());
      print('Payment failed: ${e}');
      // final errorMessage = PaymentService().parseException(e.toString());
      // Get.snackbar('Error', 'Payment failed: ${errorMessage}',colorText: Colors.white);
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

    // if(await isConnected()){
    var _response = await ApiController().addMembership(
        userId,
        membership.value.title.toString(),
        totalAmount.value.toString(),
        discount.value.toInt(),
        _membership.activeTime.toString(),
        _membership.expireTime.toString(),
        token);
    if (_response.status == true) {
      // _dismissDialog();

      Get.to(PaymentSuccessfulView(), arguments: {'membership': _response});
    } else {
      // _dismissDialog();
      if(_response.message=='The Selected appuserid is invalid '){
        Get.find<MyProfileController>().logout();
      }
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
    }
    // }else{
    //   Get.snackbar("Sweatbox", 'No internet connection',colorText: Colors.white);
    // }
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
        discount.value=calculateDiscount(double.parse(membership.value.price.toString()),double.parse(_response.promo!.last.discount??'0.0'));
        totalAmount.value=double.parse(membership.value.price.toString())-discount.value;
        print("total discount is${discount.value}");
        return double.parse(_response.promo!.last.discount??'0.0');
      }discount.value=0.0;
      totalAmount.value=double.parse(membership.value.price.toString());
      return 0.0;

    } else {
      _dismissDialog();
      discount.value=0.0;
      totalAmount.value=double.parse(membership.value.price.toString());
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






}
