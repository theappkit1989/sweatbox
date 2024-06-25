import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:s_box/extras/constant/app_constant.dart';

text(
    {required String text,
    required double size,
    String style = fontType,
    required FontWeight fontWeight,
    required Color color}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: size,
        fontFamily: fontType,
        fontWeight: fontWeight,
        color: color),
    textAlign: TextAlign.center,
  );
}
