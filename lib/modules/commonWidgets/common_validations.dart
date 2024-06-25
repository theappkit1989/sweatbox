import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/themes/colors/color_light.dart';

bool isValidEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

showSnackbar(String type,String message) {
  return Get.snackbar(type, message,
      backgroundColor: Colors.white70,colorText: ColorLight.colorPrimary);
}