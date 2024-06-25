import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/messages/all_messages_controller.dart';
import 'package:s_box/modules/messages/all_users_screen_view.dart';
import 'package:s_box/services/api/api_endpoint.dart';
import 'package:s_box/themes/colors/color_light.dart';

class AllMessagesView extends StatelessWidget {
  final allMessagesController = Get.put(AllMessagesController());
  AllMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        title: const Text(
          strFreshFaces,
          style: TextStyle(
            color: ColorLight.white,
            fontWeight: FontWeight.w600,
            fontFamily: fontType,
            fontSize: 20,
          ),
        ),
        backgroundColor: ColorLight.black,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(() => AllUserScreenView());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
              child: Image.asset(ImageConstant.searchIcon,width: 24,height: 24,),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFreshFaces(),
              buildNearby(),
            ],
          ),
        ),
      ),
    );
  }

  // buildFreshFaces() {
  //   return GestureDetector(
  //     onTap: () => allMessagesController.goToChatScreen(),
  //     child: Container(
  //       color: Colors.black,
  //       alignment: Alignment.topLeft,
  //       width: Get.width,
  //       height: Get.height * 0.1,
  //       child: ListView.builder(
  //         padding: EdgeInsets.zero,
  //         itemBuilder: (context, index) => Container(
  //           width: Get.width * 0.16,
  //           height: Get.height * 0.1,
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             image: DecorationImage(
  //                 image: AssetImage(allMessagesController.freshFacesImg[index]),
  //                 fit: BoxFit.cover),
  //           ),
  //           margin: EdgeInsets.only(right: Get.width * 0.026),
  //         ),
  //         itemCount: allMessagesController.freshUserList.length,
  //         primary: false,
  //         shrinkWrap: true,
  //         scrollDirection: Axis.horizontal,
  //       ),
  //     ),
  //   );
  // }
  buildFreshFaces() {
    return Container(
      color: Colors.black,
      alignment: Alignment.topLeft,
      width: Get.width,
      height: Get.height * 0.1,
      child: Obx(() {
        if (allMessagesController.freshUserList.isEmpty) {
          return Center(
            child: Text(
              'No fresh faces found',
              style: TextStyle(
                color: ColorLight.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final user = allMessagesController.freshUserList[index];
            final imageUrl = '${ApiEndpoint.baseUrlImage}${user.image}';

            return GestureDetector(
              onTap: () => allMessagesController.goToChatScreen(user),
              child: Container(
                width: Get.width * 0.16,
                height: Get.height * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: user.image!=null?DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ):DecorationImage(
                      image: AssetImage(allMessagesController.defaultImage),
                      fit: BoxFit.cover),
                ),
                margin: EdgeInsets.only(right: Get.width * 0.026),
              ),
            );
          },
          itemCount: allMessagesController.freshUserList.length,
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        );
      }),
    );
  }
  buildNearby() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
          child: const Text(
            strNearBy,
            style: TextStyle(
              color: ColorLight.white,
              fontWeight: FontWeight.w600,
              fontFamily: fontType,
              fontSize: 20,
            ),
          ),
        ),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0),
          itemBuilder: (context, index) => GestureDetector(
            // onTap: () => allMessagesController.goToChatScreen(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                    image: AssetImage(allMessagesController.nearByFaces[index]),
                    fit: BoxFit.cover),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    width: 10,
                    height: 10,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  text(
                      text: 'User name',
                      size: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorLight.white)
                ],
              ),
            ),
          ),
          itemCount: allMessagesController.nearByFaces.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
        ),
      ],
    );
  }
}
