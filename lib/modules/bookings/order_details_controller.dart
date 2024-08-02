import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:s_box/modules/bookings/all_bookings_controller.dart';

class OrderDetailsController extends GetxController {

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   Future.delayed(Duration(seconds: 1), () {
  //     _calculateRemainingTime();
  //     _startCountdown();
  //   });
  //
  //
  // }
  // var bookingItem = BookingItem().obs;
  // var  remainingTime=Duration.zero.obs;
  // Timer? _timer;
  // void _calculateRemainingTime() {
  //   final now = DateTime.now();
  //   final endTime = bookingItem.value.expireTime;
  //
  //   if (now.isBefore(parseDateTime(endTime!))) {
  //     remainingTime.value = parseDateTime(endTime).difference(now);
  //   } else {
  //     remainingTime.value = Duration.zero;
  //   }
  // }
  //
  // void _startCountdown() {
  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (remainingTime.value.inSeconds > 0) {
  //       // setState(() {
  //         remainingTime.value = remainingTime.value - Duration(seconds: 1);
  //       // });
  //     } else {
  //       timer.cancel();
  //     }
  //   });
  // }
  // DateTime parseDateTime(String dateTimeString) {
  //   // Define the format of the input date and time string
  //   final DateFormat formatter = DateFormat('d MMMM yyyy HH:mm');
  //
  //   // Parse the string to a DateTime object
  //   DateTime parsedDateTime = formatter.parse(dateTimeString);
  //
  //   return parsedDateTime;
  // }
}