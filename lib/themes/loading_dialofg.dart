
import 'package:s_box/modules/commonWidgets/custom_loader.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CustomLoadingDialog {
  static Future<void> showLoadingDialog() async {
    return showDialog<void>(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Container(
            color: ColorLight.dialogOverlayColor,
            child: const SimpleDialog(
              elevation: 0,
              backgroundColor: ColorLight.transparent,
              children: <Widget>[
                CustomLoader(
                  isShowOnScreen: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
