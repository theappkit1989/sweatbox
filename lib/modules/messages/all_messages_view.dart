import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/messages/all_messages_controller.dart';
import 'package:s_box/modules/messages/all_users_screen_view.dart';
import 'package:s_box/services/api/api_endpoint.dart';
import 'package:s_box/themes/colors/color_light.dart';

import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';

class AllMessagesView extends StatelessWidget {
  final allMessagesController = Get.put(AllMessagesController());

  AllMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    allMessagesController.fetchAllChatList();
    // allMessagesController.isloadingFreshfaces.value = true;
    // allMessagesController.isloadingallchats.value = true;

    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.all(12.0),
          child: const Text(
            strFreshFaces,
            style: TextStyle(
              color: ColorLight.white,
              fontWeight: FontWeight.w600,
              fontFamily: fontType,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: ColorLight.black,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => AllUserScreenView());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
              child: const Text(
                strViewall,
                style: TextStyle(
                  color: appPrimaryColor,

                  fontFamily: fontType,
                  fontSize: 13,
                ),
              ),
              // Image.asset(
              //   ImageConstant.searchIcon, width: 24, height: 24),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: allMessagesController.isloadingFreshfaces == true
                    ? Center(child: CircularProgressIndicator(),)
                    : buildFreshFaces(),
              );
            }),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Text(
                'All Chats',
                style: TextStyle(
                  color: ColorLight.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Obx(() {
              return allMessagesController.isloadingallchats == true ? Center(
                child: CircularProgressIndicator(),) :
              buildChatList();
            })

          ],
        ),
      ),
    );
  }

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
              onTap: () => allMessagesController.goToChatScreenfresh(user,index),
              child:CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: ImageConstant.placeholderImage,
                    image: imageUrl,
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                    fadeInDuration: Duration(milliseconds: 300),
                    fadeOutDuration: Duration(milliseconds: 100),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        ImageConstant.placeholderImage,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                      );
                    },
                  ),
                ),
              ),
              // Container(
              //   width: Get.width * 0.21,
              //   // height: Get.height * 0.01,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //   ),
              //   margin: EdgeInsets.only(right: Get.width * 0.026),
              //   child: ClipOval(
              //     child: FadeInImage.assetNetwork(
              //       placeholder: ImageConstant.placeholderImage,
              //       image: imageUrl,
              //       fit: BoxFit.cover,
              //       width: 50,
              //       height: 50,
              //       fadeInDuration: Duration(milliseconds: 300),
              //       fadeOutDuration: Duration(milliseconds: 100),
              //       imageErrorBuilder: (context, error, stackTrace) {
              //         return Image.asset(
              //           ImageConstant.placeholderImage,
              //           fit: BoxFit.cover,
              //           width: 50,
              //           height: 50,
              //         );
              //       },
              //     ),
              //   ),
              // ),
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


  buildChatList() {
    return Obx(() {
      if (allMessagesController.allChatList.isEmpty) {
        return Center(
          child: Text(
            'No chats available',
            style: TextStyle(
              color: ColorLight.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }
      return ListView.builder(
        primary: false,
        shrinkWrap: true,
        reverse: true,
        itemCount: allMessagesController.allChatList.length,

        itemBuilder: (context, index) {
          final chat = allMessagesController.allChatList[index];
          final imageUrl = '${ApiEndpoint.baseUrlImage}${chat?.image}';
          return GestureDetector(
            onTap: () => allMessagesController.goToChatScreen(chat!, index),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.0, vertical: Get.height * 0.007),
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: FadeInImage.assetNetwork(
                      placeholder: ImageConstant.placeholderImage,
                      image: imageUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                      fadeInDuration: Duration(milliseconds: 300),
                      fadeOutDuration: Duration(milliseconds: 100),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          ImageConstant.placeholderImage,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        );
                      },
                    ),
                  ),
                ),
                title: Text(
                  chat?.fName ?? 'User name',
                  style: TextStyle(
                    color: ColorLight.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  chat.lastMessage ?? "",
                  style: TextStyle(
                    color: ColorLight.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                trailing: Column(
                    children: [
                      chat.isNewMessage==1
                      // allMessagesController.isNewMessage[index]
                          ? Icon(Icons.circle, color: Colors.red, size: 12)
                          : SizedBox.shrink(),
                      Text(
                        convertGMTToLocalCurrentTime(
                            chat.lastMessageTime.toString()) ?? "",
                        style: TextStyle(
                          color: ColorLight.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          );
        },
      );
    });
  }

  String convertGMTToLocalCurrentTime(String gmtTime) {
    // Step 1: Parse GMT time
    DateTime gmtDateTime = DateTime.parse(gmtTime);

    // Step 2: Convert to local time
    DateTime localDateTime = gmtDateTime.toLocal();

    // Step 3: Format current local time
    String formattedTime = DateFormat('HH:mm').format(localDateTime);

    return formattedTime;
  }

  String formatTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    DateTime localDate = parsedDate.toLocal(); // Convert to local time

    String formattedTime = DateFormat('HH:mm').format(localDate);

    return '$formattedTime';
  }
}
