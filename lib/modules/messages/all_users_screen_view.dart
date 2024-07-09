import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/messages/all_user_screen_controller.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../themes/colors/color_light.dart';
import '../commonWidgets/common.dart';

class AllUserScreenView extends StatelessWidget {
  final allUserScreenController = Get.put(AllUserScreenCotroller());

  AllUserScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        title: const Text(
          strAllMembers,
          style: TextStyle(
            color: ColorLight.black,
            fontWeight: FontWeight.w600,
            fontFamily: fontType,
            fontSize: 20,
          ),
        ),
        backgroundColor: ColorLight.white,

      ),
      body: Obx(() {
        if (allUserScreenController.allUserList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: allUserScreenController.allUserList.length,
              itemBuilder: (context, index) {
                final user = allUserScreenController.allUserList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to the chat screen
                   allUserScreenController.goToChatScreen(user);
                  },
                  child: GridTile(
                    child:Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/Rectangle 39988 (1).png',),
                            fit: BoxFit.cover),
                      ),
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: text(
                          text: allUserScreenController.allUserList[index]
                              .username!,
                          size: 12,
                          fontWeight: FontWeight.w600,
                          color: ColorLight.white),
                    ),
                  ),

                );
              },
            ),
          );
        }
      }),
    );
  }
}


