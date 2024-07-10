import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/themes/colors/color_light.dart';

import 'menu_controller.dart';

class MenuView extends StatelessWidget {
  final menuController = Get.put(DotMenuController());
  MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            itemBuilder: (context, index) => buildTile(
                icon: menuController.icons[index],
                title: menuController.title[index],
                voidCallback: () {
                  index == 0
                      ? menuController.goToDeleteUser()
                      : index == 1
                          ? menuController.goToBlockUser()
                          : menuController.goToReportUser();
                }),
            separatorBuilder: (context, index) => const Divider(
              color: Color.fromRGBO(255, 255, 255, 0.3),
            ),
            itemCount: 3,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }

  buildTile(
      {required String icon,
      required String title,
      required VoidCallback voidCallback}) {
    return ListTile(
      onTap: voidCallback,
      leading: Image.asset(
        icon,
        width: 24,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        color: ColorLight.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontFamily: fontType,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: ColorLight.white),
      ),
    );
  }
}
