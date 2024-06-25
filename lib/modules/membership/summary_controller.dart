import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:s_box/modules/membership/membership_controller.dart';
import 'package:s_box/modules/membership/payment_successful_view.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../massage_booking/payment_declined_view.dart';
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

  @override
  void onInit() {
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    userId = storage.read(userid).toString();
  }

  Future<void> goToPaymentSuccessful() async {
    _showLoadingDialog();
    print(
        "payment data is ${membership.value.price.toString()}\n${cardNumber.toString()}\n${cardName.toString()}\n${cardExpiryMonth.toString()}\n${cardCvv.toString()}\n${cardExpiryYear.toString()}");
    try {
      final result = await PaymentService().makePayment(
          membership.value.price.toString(),
          "GBP",
          "VISA",
          cardNumber.toString(),
          cardName.toString(),
          cardExpiryMonth.toString(),
          cardExpiryYear.toString(),
          cardCvv.toString());
      print("payment result is $result");
      if (result == 200) {
        _dismissDialog();
        addMembership();
      } else {
        Get.to(PaymentDeclinedView());
        _dismissDialog();
      }
    } catch (e) {
      _dismissDialog();
      Get.to(PaymentDeclinedView());

      Get.snackbar('Error', 'Payment failed: ${e}');
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

    Membership _membership=Membership(title: membership.value.title, user_id: membership.value.user_id, price: membership.value.price, discount: membership.value.discount,activeTime: formattedNow,expireTime: formattedExpireTime);

    var _response = await ApiController().addMembership(
        userId,
        membership.value.title.toString(),
        membership.value.price.toString(),
        0,
        _membership.activeTime.toString(),
        _membership.expireTime.toString(),
        token);
    if (_response.status == true) {
      _dismissDialog();

      Get.to(PaymentSuccessfulView(), arguments: {'membership': _response});
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
}
