import 'dart:math' as math;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shypie/src/utils/widgets/sizer.dart';

import '../../../services/urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/widgets/app_cache_image.dart';
import '../../../utils/widgets/app_progress_bar.dart';
import '../../../utils/widgets/record_not_found.dart';
import '../../../utils/widgets/style.dart';
import '../widget/chat.dart';
import 'logic.dart';

class ChatScreenView extends StatelessWidget {
  const ChatScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatScreenLogic>(
        init: ChatScreenLogic(),
        builder: (logic) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.secoundryColor,
                appBar: AppBar(
                  backgroundColor: AppColors.secoundryColor,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness: Brightness.dark,
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                  title: Row(
                    children: [
                      (logic.userModel.profileImage ?? '').isEmpty
                          ? Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/png/app_icon.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    )),
                                Positioned(
                                  bottom: 0,
                                  right: -4,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            )
                          : AppCacheImage(
                              imageUrl:
                                  '$mediaUrl${logic.userModel.profileImage}',
                              round: 40,
                              width: 40,
                              height: 40),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.driverSupport,
                            style: StyleRefer.poppinsMedium
                                .copyWith(color: Colors.white, fontSize: 10.sp),
                          ),
                          Text(
                            AppLocalizations.of(context)!.available,
                            style: StyleRefer.poppinsRegular
                                .copyWith(color: Colors.white, fontSize: 9.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 40,
                        margin: const EdgeInsets.symmetric(vertical: 13),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.end,
                            style: StyleRefer.poppinsMedium.copyWith(
                                color: AppColors.mainColor, fontSize: 10.sp),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                body: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        logic.chatMessages.isEmpty
                            ? const Expanded(child: RecordNotFound())
                            : Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      )),
                                  child: SingleChildScrollView(
                                    controller: logic.scrollController,
                                    physics: const ScrollPhysics(),
                                    reverse: true,
                                    child: Column(
                                      children: [
                                        ...logic.chatMessages.map((e) {
                                          return ChatMessages(
                                            chatMessagesModel: e,
                                          );
                                        }).toList()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 70),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ColoredBox(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                  onTap: logic.getImage,
                                  child: const Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Icon(Icons.image),
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 20, left: 10),
                                  child: SizedBox(
                                    height: 52,
                                    child: TextFormField(
                                      onTap: () {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          logic.scrollController.jumpTo(logic
                                              .scrollController
                                              .position
                                              .minScrollExtent);
                                        });
                                      },
                                      controller: logic.messageTextField,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                      onChanged: (value) {
                                        logic.update();
                                      },
                                     
                                      
                                      decoration: InputDecoration(
                                          fillColor: const Color(0xffF3F3F3),
                                          filled: true,
                                          contentPadding: const EdgeInsets.only(
                                            top: 10,
                                            left: 20,
                                            right: 20,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          hintText: AppLocalizations.of(context)!.typeAMessage,
                                          hintStyle: const TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                          prefixIcon: Transform.rotate(
                                            angle: 180 * math.pi / 80,
                                            child: IconButton(
                                                constraints:
                                                    const BoxConstraints(),
                                                splashRadius: 12,
                                                onPressed: logic.addAttachments,
                                                icon: const Icon(
                                                    Icons.attach_file)),
                                          ),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap:logic.sendMessage,
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  margin: const EdgeInsets.only(
                                      bottom: 20, left: 10),
                                  decoration: const BoxDecoration(
                                      color: AppColors.mainColor,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Transform.rotate(
                                      angle: 190 * math.pi / 110,
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppLoadingWidget.loadingBar()
            ],
          );
        });
  }
}
