import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/messages/delete_user_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';

import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../services/commonModels/freshFacesResponse.dart';

class DeleteUserView extends StatelessWidget {
  final deleteUserController = Get.put(DeleteUserController());
  DeleteUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final Users user = arguments['user'];
    deleteUserController.user.value = user;
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                ImageConstant.deleteImg,
                width: Get.width * 0.4,
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            text(
                text: strDeleteSubtitle,
                size: 14,
                fontWeight: FontWeight.w400,
                color: ColorLight.white),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {deleteUserController.deleteChat();},
                  child: Text(
                    strDelete,
                    style: TextStyle(
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w700,
                        fontSize: Get.height * 0.022),
                  ),
                  color: appPrimaryColor,
                  minWidth: Get.width * 0.42,
                  elevation: 0.0,
                  height: Get.height * 0.065,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    strNotNow,
                    style: TextStyle(
                        fontFamily: fontType,
                        color: appPrimaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: Get.height * 0.022),
                  ),
                  color: appPrimaryColor.withOpacity(0.1),
                  minWidth: Get.width * 0.42,
                  elevation: 0.0,
                  height: Get.height * 0.065,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
