import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/massage_booking/massage_and_enerance_view.dart';

import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/massage_booking/massage_payment_method_view.dart';


import 'package:table_calendar/table_calendar.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/api/api_endpoint.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';

class DateTimeController extends GetxController {
  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  var massage = Massage(title: '', subtitle: '', price: 0).obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;
  RxList<String> timeSlots = <String>[].obs;
  RxList<RxBool> timeSelected = <RxBool>[].obs;
  var storage = GetStorage();
  String token='';
  String user_id='';
  Massage? selectedMassage; // Variable to store selected massage

  // Variables to store gathered details
  String selectedDate = '';
  String selectedTime = '';

  @override
  void onInit() {
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();
    if(Get.arguments != null){
      print("arguments not null");
      selectedMassage = Get.arguments[0];
      massage.value = selectedMassage!;
      Future.delayed(Duration(seconds: 1), () {
        checkSlot();
      });
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    checkSlot();
  }

  @override
  void onClose() {
    print("controller closed");
    Get.delete<DateTimeController>();
  }

  void checkSlot() async {
    _showLoadingDialog();
    FocusScope.of(Get.context!).unfocus();

    String date = "${selectedDay.value.year}-${selectedDay.value.month.toString().padLeft(2, '0')}-${selectedDay.value.day.toString().padLeft(2, '0')}";
    String duration = massage.value.subtitle;

    var _response = await ApiController().checkSlot(date, duration, token);
    if (_response.status == true) {
      _dismissDialog();
      print(_response.availableSlots);
      timeSlots.value = _response.availableSlots ?? [];
      timeSelected.value = List.generate(timeSlots.length, (index) => false.obs);
    } else {
      _dismissDialog();
      Get.snackbar("",  'No Slot Available!',colorText: Colors.white);
    }
  }

  void showdetails() {
    print("Selected Massage: ${selectedMassage?.title}");
    print("Selected Date: $selectedDate");
    print("Selected Time: $selectedTime");
  }
  bool isTimeSlotSelected() {
    for (var selected in timeSelected) {
      if (selected.value) {
        return true;
      }
    }
    return false;
  }

  void goToSummary() {

    Get.to(MassageAndEntranceView(), arguments: [selectedMassage,selectedDate,selectedTime,massage.value.subtitle]);
  }
  void gatherDetails(String selectedTime) {
    this.selectedTime = selectedTime;
    selectedDate = "${selectedDay.value.year}-${selectedDay.value.month.toString().padLeft(2, '0')}-${selectedDay.value.day.toString().padLeft(2, '0')}";
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
