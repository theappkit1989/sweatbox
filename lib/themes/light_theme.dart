import 'package:s_box/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors/color_light.dart';
import 'constants/font_family_constants.dart';

ThemeData lightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: ColorLight.white,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: ColorLight.white,
      unselectedItemColor: ColorLight.black,
      selectedItemColor: ColorLight.redBgColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: ScreenUtil().setSp(12),
        color: ColorLight.titleTextColor,
        fontFamily: FontFamilyConstants.latoFont,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w300,
      ),
      hintStyle: TextStyle(
        fontSize: ScreenUtil().setSp(14),
        color: ColorLight.lightHintColor,
        fontFamily: FontFamilyConstants.latoFont,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorLight.redBgColor, width: 0.5, style: BorderStyle.solid),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            color: ColorLight.redBgColor, width: 0.5, style: BorderStyle.solid),
      ),
      errorStyle: TextStyle(
          fontFamily: FontFamilyConstants.nunitoSansFont,
          color: ColorLight.redBgColor,
          fontWeight: FontWeight.w400,
          fontSize: ScreenUtil().setSp(10),
          fontStyle: FontStyle.normal),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorLight.redBgColor),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            color: ColorLight.white,
            fontSize: ScreenUtil().setSp(18),
            fontFamily: FontFamilyConstants.latoFont,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.transparent, width: 1.5),
          borderRadius: BorderRadius.circular(10)),
      elevation: 1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle?>(
          TextStyle(
              fontSize: ScreenUtil().setSp(12),
              color: ColorLight.white,
              fontFamily: FontFamilyConstants.latoFont,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal),
        ),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: const BorderSide(color: Colors.transparent, width: 0.5),
            borderRadius: BorderRadius.circular(7))),
        backgroundColor:
            MaterialStateProperty.all<Color>(ColorLight.redBgColor),
      ),
    ),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      centerTitle: true,
      color: ColorLight.white,
      elevation: 0,
      toolbarTextStyle: TextStyle(
        color: ColorLight.black,
        fontSize: ScreenUtil().setSp(14),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: ColorLight.snackBarColor,
      actionTextColor: ColorLight.white,
      contentTextStyle: TextStyle(
          fontSize: ScreenUtil().setSp(14),
          fontWeight: FontWeight.w500,
          fontFamily: FontFamilyConstants.latoFont,
          color: ColorLight.white),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
