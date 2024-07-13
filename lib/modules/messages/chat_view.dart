import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/messages/chat_controller.dart';
import 'package:s_box/services/commonModels/freshFacesResponse.dart';
import 'package:s_box/themes/colors/color_light.dart';

import '../../extras/constant/app_constant.dart';
import '../../services/api/api_endpoint.dart';
import 'all_messages_controller.dart';

class ChatView extends StatelessWidget {
  final chatController = Get.put(ChatController());

  ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final Users user = arguments['user'];
    chatController.user.value = user;
    var controller=TextEditingController();
    // chatController.fetchSpecificUser();
    chatController.isloading.value=true;
    chatController.fetchAllMessages();

    return WillPopScope(
      onWillPop: () {

      //   var homeCont = Get.find<AllMessagesController>();
      // homeCont.allChatList.clear();
      // homeCont.fetchAllChatList();
      // homeCont.update();
        return Future(() => true);},
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: buildAppBar(user),

        body: Container(
          child: Column(
            children: [
              Expanded(
                child: buildChatWidget(),
              ),
              buildTextBox(),
            ],
          ),
        ),
      ),
    );
  }

  buildAppBar(Users user) {
    final imageUrl = '${ApiEndpoint.baseUrlImage}${user.image}';
    final String defaultImage = 'assets/images/Ellipse 2.png';
    return AppBar(
      backgroundColor: ColorLight.black,
      leading: GestureDetector(
          onTap: () {
            var homeCont = Get.find<AllMessagesController>();
            homeCont.allChatList.clear();
            homeCont.fetchAllChatList();
            homeCont.update();
            Get.back();
          },
          child: Icon(
            Icons.arrow_back, size: Get.width * 0.065, color: Colors.white,)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  width: Get.width * 0.12,
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: user.image != null ? DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ) : DecorationImage(
                        image: AssetImage(ImageConstant.placeholderImage),
                        fit: BoxFit.cover),
                  )
              ),
              // Container(
              //   width: 10,
              //   height: 10,
              //   margin: EdgeInsets.only(
              //       top: kToolbarHeight - 15, left: Get.width * 0.09),
              //   decoration: BoxDecoration(
              //       color: Colors.green,
              //       shape: BoxShape.circle,
              //       border: Border.all(color: ColorLight.white)),
              // ),
            ],
          ),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                  text: user.fName ?? "",
                  size: 15,
                  fontWeight: FontWeight.w800,
                  color: ColorLight.white),
              text(
                  text: strOnline,
                  size: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9)),
            ],
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () => chatController.goToMenu(),
          child: Container(
            width: Get.width * 0.1,
            height: kToolbarHeight,
            margin: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey)),
            child: Icon(Icons.more_vert, color: Colors.white,),
          ),
        ),
      ],
    );
  }

  buildDateWidget({required String date}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: ColorLight.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: text(
          text: date,
          size: 13,
          fontWeight: FontWeight.w300,
          color: ColorLight.black),
    );
  }

  Widget buildChatWidget() {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      reverse: true,
      child: Column(
        children: [
          // ...chatController.messages.map((element) {
          //   final message =element;
          //   final isCurrentUser = message.senderId == chatController.user_id;
          //   return Align(
          //     alignment: isCurrentUser
          //         ? Alignment.centerRight
          //         : Alignment.centerLeft,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: isCurrentUser
          //           ? CrossAxisAlignment.end
          //           : CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           padding: const EdgeInsets.all(12.0),
          //           margin:
          //           EdgeInsets.symmetric(vertical: Get.height * 0.01),
          //           decoration: BoxDecoration(
          //             color: isCurrentUser ? appPrimaryColor : greyChat,
          //             borderRadius: BorderRadius.only(
          //               topRight: Radius.circular(20),
          //               topLeft: Radius.circular(20),
          //               bottomLeft: isCurrentUser
          //                   ? Radius.circular(20)
          //                   : Radius.zero,
          //               bottomRight: isCurrentUser
          //                   ? Radius.zero
          //                   : Radius.circular(20),
          //             ),
          //           ),
          //           child: Text(
          //             message.message ?? '',
          //             style: const TextStyle(
          //               fontSize: 13,
          //               fontFamily: fontType,
          //               color: ColorLight.white,
          //               fontWeight: FontWeight.w400,
          //             ),
          //           ),
          //         ),
          //         Text(
          //           '8:50 PM',
          //           // Ideally, format the actual message timestamp here
          //           style: TextStyle(
          //               fontWeight: FontWeight.w400,
          //               color: isCurrentUser
          //                   ? ColorLight.white
          //                   : ColorLight.black,
          //               fontFamily: fontType,
          //               fontSize: 11),
          //         )
          //       ],
          //     ),
          //   );
          // }),
          Obx(() {

            return chatController.isloading==true?CircularProgressIndicator():ListView.builder(

              // controller: chatController.scrollController,
              itemBuilder: (context, index) {
                final message = chatController.messages[index];
                final isCurrentUser = message.senderId == chatController.user_id;
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: isCurrentUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          margin:
                          EdgeInsets.symmetric(vertical: Get.height * 0.01),
                          decoration: BoxDecoration(
                            color: isCurrentUser ? appPrimaryColor : greyChat,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                              bottomLeft: isCurrentUser
                                  ? Radius.circular(20)
                                  : Radius.zero,
                              bottomRight: isCurrentUser
                                  ? Radius.zero
                                  : Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            message.message ?? '',
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: fontType,
                              color: ColorLight.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Text(
                          formatTime(message.createdAt.toString()),
                          // Ideally, format the actual message timestamp here
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: isCurrentUser
                                  ? ColorLight.white
                                  : ColorLight.white,
                              fontFamily: fontType,
                              fontSize: 11),
                        )
                      ],
                    ),
                  ),
                );
              },
              primary: false,
              shrinkWrap: true,
              itemCount: chatController.messages.length,
            );
          }),

        ],
      ),
    );
  }
  String formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);

    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);


    return '$formattedDate';
  }
  String formatTime(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);


    String formattedTime = DateFormat('hh:mm a').format(parsedDate);

    return '$formattedTime';
  }
  // buildChatWidget() {
  //   return Column(
  //     children: [
  //       ListView.builder(
  //         itemBuilder: (context, index) => index % 2 == 0
  //             ? Align(
  //                 alignment: Alignment.centerRight,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Container(
  //                       padding: const EdgeInsets.all(12.0),
  //                       margin:
  //                           EdgeInsets.symmetric(vertical: Get.height * 0.01),
  //                       decoration: const BoxDecoration(
  //                           color: appPrimaryColor,
  //                           borderRadius: BorderRadius.only(
  //                               topRight: Radius.circular(20),
  //                               topLeft: Radius.circular(20),
  //                               bottomLeft: Radius.circular(20),
  //                               bottomRight: Radius.zero)),
  //                       child: const Text(
  //                         'It is a long established fact that a reader will be distracted by the readable',
  //                         style: TextStyle(
  //                           fontSize: 13,
  //                           fontFamily: fontType,
  //                           color: ColorLight.white,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ),
  //                     const Text(
  //                       '8:50 PM',
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           color: ColorLight.white,
  //                           fontFamily: fontType,
  //                           fontSize: 11),
  //                     )
  //                   ],
  //                 ),
  //               )
  //             : Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                       padding: const EdgeInsets.all(12.0),
  //                       margin:
  //                           EdgeInsets.symmetric(vertical: Get.height * 0.01),
  //                       decoration: const BoxDecoration(
  //                           color: greyChat,
  //                           borderRadius: BorderRadius.only(
  //                               topRight: Radius.circular(20),
  //                               topLeft: Radius.circular(20),
  //                               bottomLeft: Radius.zero,
  //                               bottomRight: Radius.circular(20))),
  //                       child: const Text(
  //                         'It is a long established fact that a reader',
  //                         style: TextStyle(
  //                           fontSize: 13,
  //                           fontFamily: fontType,
  //                           color: ColorLight.white,
  //                           fontWeight: FontWeight.w400,
  //                         ),
  //                       ),
  //                     ),
  //                     const Text(
  //                       '8:50 PM',
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w400,
  //                           color: ColorLight.black,
  //                           fontFamily: fontType,
  //                           fontSize: 11),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //         primary: false,
  //         shrinkWrap: true,
  //         itemCount: 10,
  //       ),
  //       SizedBox(
  //         height: Get.height * 0.1,
  //       ),
  //     ],
  //   );
  // }

  buildTextBox() {

    return Container(
      color: ColorLight.black,
      padding: EdgeInsets.only(
        left: Get.width * 0.05,
        right: Get.width * 0.05,
        bottom: Get.height * 0.05,
      ),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05, vertical: Get.height * 0.005),
        decoration: BoxDecoration(
            color: ColorLight.black,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width * 0.6,
              child: Row(
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //
                  //   },
                  //
                  //   child: Image.asset(
                  //     ImageConstant.emojiIcon,
                  //     width: 30,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: Get.width * 0.45,
                    child:  TextField(
                      controller: chatController.textController.value,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorLight.white,
                          fontFamily: fontType),
                      decoration: InputDecoration(
                          hintText: strTypeSomething,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorLight.white,
                              fontFamily: fontType)),
                    ),
                  ),
                ],
              ),
            ),
            // Image.asset(
            //   ImageConstant.attachmentIcon,
            //   width: 30,
            //   color: ColorLight.white,
            // ),
            Spacer(),
            GestureDetector(
              onTap: (){
                chatController.sendMessage();
              },
              child: Image.asset(
                ImageConstant.sendIcon,
                width: 30,
                color: ColorLight.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
