import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ThemeController extends GetxController  {
  final Rx<ThemeMode> _isDarkMode = ThemeMode.light.obs;
  var isSelected = false.obs;

  Rx<ThemeMode> isDarkMode() {
    return _isDarkMode;
  }


}
