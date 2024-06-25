import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/massage_booking/payment_declined_view.dart';
import 'package:s_box/modules/massage_booking/payment_successful_view.dart';
import 'package:flutter/material.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../membership/TestPaymentScreen.dart';

class SummaryController extends GetxController{

  var massage = Massage(title: '', subtitle: '', price: 0, date: '', time: '', duration: '').obs;
  var storage = GetStorage();
  final RxString cardNumber=''.obs;
  final RxString cardName=''.obs;
  final RxString cardExpiryMonth=''.obs;
  final RxString cardExpiryYear=''.obs;
  final RxString cardCvv=''.obs;
  String token='';
  String userId='';
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

        var _response = await ApiController().addService(userId,'Massage',massage.value.price.toString(),massage.value.date.toString(),
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
}