import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:s_box/modules/messages/all_user_screen_controller.dart';

import '../../extras/constant/app_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../themes/colors/color_light.dart';

class AllUserScreenView extends StatelessWidget {
  final allUserScreenController = Get.put(AllUserScreenCotroller());
   AllUserScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        title: const Text(
          strMembers,
          style: TextStyle(
            color: ColorLight.white,
            fontWeight: FontWeight.w600,
            fontFamily: fontType,
            fontSize: 20,
          ),
        ),
        backgroundColor: ColorLight.black,
        automaticallyImplyLeading: false,

      ),
    );
  }
}
