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

import '../../extras/constant/AutoCapitalizeTextInputFormatter.dart';
import '../../extras/constant/VideoPlayerWidget.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/shared_pref_constant.dart';
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
        FocusScope.of(Get.context!).unfocus();

        var homeCont = Get.find<AllMessagesController>();
      // homeCont.allChatList.clear();
      homeCont.fetchAllChatList();
      homeCont.update();
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
            FocusScope.of(Get.context!).unfocus();
            var homeCont = Get.find<AllMessagesController>();
            // homeCont.allChatList.clear();
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
                  // width: Get.width * 0.12,
                  // height: kToolbarHeight,
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   image: user.image != null ? DecorationImage(
                  //     image: NetworkImage(imageUrl),
                  //     fit: BoxFit.cover,
                  //   ) : DecorationImage(
                  //       image: AssetImage(ImageConstant.placeholderImage),
                  //       fit: BoxFit.cover),
                  // )
       child:  ClipOval(
      child: FadeInImage.assetNetwork(
      placeholder: ImageConstant.placeholderImage,
        image: imageUrl,
        fit: BoxFit.cover,
        width: 40,
        height: 40,
        fadeInDuration: Duration(milliseconds: 300),
        fadeOutDuration: Duration(milliseconds: 100),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImageConstant.placeholderImage,
            fit: BoxFit.cover,
            width: 40,
            height: 40,
          );
        },
      ),
    ),
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
              // text(
              //     text: strOnline,
              //     size: 12,
              //     fontWeight: FontWeight.w500,
              //     color: Colors.white.withOpacity(0.9)),
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
                       message.type==''||message.type=='text'? Container(
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
                              fontSize: 14,
                              fontFamily: fontType,
                              color: ColorLight.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ):message.type == MyFileType.image.name?
                       GestureDetector(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => FullScreenImage(imageUrl: message.message.toString()),
                             ),
                           );
                         },
                         child: Container(
                           decoration: BoxDecoration(
                             border: Border.all(
                               color: isCurrentUser ? appPrimaryColor : greyChat, // Border color
                               width: 1.0, // Border width
                             ),
                             borderRadius: BorderRadius.circular(15),),
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(15),
                             child: Image.network(
                               "${message.message}",
                               width: Get.width / 2,
                               height: Get.height / 4,
                               fit: BoxFit.cover,
                               loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                 if (loadingProgress == null) {
                                   return child;
                                 } else {
                                   return  SizedBox(
                                     width: Get.width/ 2,
                                     height:Get.height/ 4,
                                     child: Center(
                                       child: SizedBox(
                                         height: 60,
                                         width: 60,
                                         child: CircularProgressIndicator(
                                           value: loadingProgress.expectedTotalBytes != null
                                               ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                               : null,
                                         ),
                                       ),
                                     ),
                                   );
                                 }
                               },
                               errorBuilder: (context, error, stackTrace) {
                                 // If there is an error loading the network image, show a placeholder image
                                 return Image.asset(
                                   ImageConstant.noImage,
                                   // Provide the path to your placeholder image in assets
                                   width: Get.width / 2,
                                   height: Get.height / 4,
                                   fit: BoxFit.cover,
                                 );
                               },
                             ),
                           ),
                         ),
                       ):message.type== MyFileType.video.name?
                       Container(decoration: BoxDecoration(
                         border: Border.all(
                           color: isCurrentUser ? appPrimaryColor : greyChat, // Border color
                           width: 1.0, // Border width
                         ),
                         borderRadius: BorderRadius.circular(15),),
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(15),
                           child: VideoPlayerWidget(
                             videoUrl:
                             "${message.message}",
                           ),
                         ),
                       ):Container(),
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
    DateTime localDate = parsedDate.toLocal(); // Convert to local time

    String formattedTime = DateFormat('HH:mm').format(localDate);

    return '$formattedTime';
  }


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

        padding: EdgeInsets.only(top: 5,bottom: 5,left: 5),
        decoration: BoxDecoration(
          color: ColorLight.black,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: Get.width * 0.7,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: Get.width * 0.65,
                      child: TextField(
                        controller: chatController.textController.value,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,  // Minimum lines to display
                        maxLines: 4,  // Maximum lines to display before scrolling
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorLight.white,
                          fontFamily: fontType,
                        ),
                        inputFormatters: [
                          AutoCapitalizeTextInputFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: strTypeSomething,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorLight.white,
                            fontFamily: fontType,
                          ),
                        ),
                        scrollController: chatController.scrollController.value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        

            GestureDetector(
              onTap: () {
                chatController.pickImage();
              },
              child: const Icon(
                Icons.camera_alt_rounded,
                color: ColorLight.white,
              ),
        
              // Image.asset(
              //   ImageConstant.sendIcon,
              //   width: 30,
              //   color: ColorLight.white,
              // ),
            ),
            SizedBox(width: 5,),
            GestureDetector(
              onTap: () {
                chatController.sendMessage('text',chatController.textController.value.text);
              },
              onDoubleTap: (){
        
              },
              child: const Icon(
                Icons.send,
                color: ColorLight.white,
              ),


            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }

}


class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/no_image.png',  // Adjust the path to your placeholder image
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}

