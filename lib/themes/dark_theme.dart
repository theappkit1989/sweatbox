import 'package:s_box/themes/constants/font_family_constants.dart';
import 'package:s_box/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'colors/color_dark.dart';

ThemeData darkThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorDark.black,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorDark.white,
      unselectedItemColor: ColorDark.black,
      selectedItemColor: ColorDark.redBgColor,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
            fontSize: ScreenUtil().setSp(12),
            color: ColorDark.white,
            fontFamily: FontFamilyConstants.latoFont,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal),
      ),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent, width: 0.5),
          borderRadius: BorderRadius.circular(7))),
      backgroundColor: MaterialStateProperty.all<Color>(ColorDark.redBgColor),
    )),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorDark.white,
      elevation: 0,
      toolbarTextStyle: TextStyle(
        color: ColorDark.black,
        fontSize: ScreenUtil().setSp(20),
      ),
    ),
  );
}
