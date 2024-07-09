import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/bookings/all_bookings_view.dart';
import 'package:s_box/modules/commonWidgets/bottom_navigation.dart';
import 'package:s_box/modules/commonWidgets/edit_widget.dart';

import 'package:s_box/modules/home_screen/home_controller.dart';
import 'package:s_box/modules/massage_booking/massage_view.dart';
import 'package:s_box/modules/membership/membership_view.dart';
import 'package:s_box/modules/messages/all_messages_view.dart';
import 'package:s_box/modules/my_profile/my_profile_view.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreenView extends StatelessWidget {
  final mainScreenController = Get.put(MainScreenController());
  HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorLight.white,
        appBar: AppBar(
          toolbarHeight: Get.height*0.0,
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: buildBottomNav(context, mainScreenController),
        body: Obx(
          ()=> mainScreenController.screens[mainScreenController.tabIndex.value]

        ));
  }

  buildFloatingActionBtn() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: ColorLight.textColorBlue,
      child: Image.asset(
        ImageConstant.addIcon,
        width: Get.width * 0.05,
      ),
    );
  }

  buildBottomNav(context, landingPageController) {
    return Obx(() => BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              ImageConstant.homeIcon,
              width: Get.width * 0.08,
            ),
            activeIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.red, // Change this to your desired active color
                BlendMode.srcIn,
              ),
              child: Image.asset(
                ImageConstant.homeIcon,
                width: Get.width * 0.08,
              ),
            ),
            label: '.'),
        BottomNavigationBarItem(
            icon: Image.asset(
              ImageConstant.service_icon,
              width: Get.width * 0.08,
            ),
            activeIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.red, // Change this to your desired active color
                BlendMode.srcIn,
              ),

              child: Image.asset(
                ImageConstant.service_icon,
                width: Get.width * 0.08,
              ),
            ),
            label: '.'),
        BottomNavigationBarItem(
            icon: Image.asset(
              ImageConstant.msgIcon,
              width: Get.width * 0.08,
            ),
            activeIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.red, // Change this to your desired active color
                BlendMode.srcIn,
              ),
              child: Image.asset(
                ImageConstant.msgIcon,
                width: Get.width * 0.08,
              ),
            ),
            label: '.'),
        BottomNavigationBarItem(
            icon: Image.asset(
              ImageConstant.calendarIcon,
              width: Get.width * 0.08,
            ),
            activeIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.red, // Change this to your desired active color
                BlendMode.srcIn,
              ),
              child: Image.asset(
                ImageConstant.calendarIcon,
                width: Get.width * 0.08,
              ),
            ),
            label: '.'),
        BottomNavigationBarItem(
            icon: Image.asset(
              ImageConstant.profileIcon,
              width: Get.width * 0.08,
            ),
            activeIcon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.red, // Change this to your desired active color
                BlendMode.srcIn,
              ),
              child: Image.asset(
                ImageConstant.profileIcon,
                width: Get.width * 0.08,
              ),
            ),
            label: '.'),
      ],
      backgroundColor: ColorLight.white,
      currentIndex: mainScreenController.tabIndex.value,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        mainScreenController.changeTabIndex(index);
      },
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ));
  }

  // buildBottomNav(context, landingPageController) {
  //   return Obx(
  //     () => Container(
  //       margin: EdgeInsets.symmetric(horizontal: Get.width*0.01,vertical: Get.height*0.0125),
  //       child: SalomonBottomBar(
  //         currentIndex: mainScreenController.tabIndex.value,
  //         onTap: (index) {
  //           mainScreenController.changeTabIndex(index);
  //         },
  //         backgroundColor: bottomNavColor,
  //         selectedItemColor: Colors.white,
  //         unselectedItemColor: Colors.white,
  //         selectedColorOpacity: 0,
  //         itemPadding: EdgeInsets.symmetric(horizontal: Get.width*0.04,vertical: Get.height*0.0075),
  //         items: [
  //           /// Home
  //           SalomonBottomBarItem(
  //               icon: Transform.scale(
  //                   scale:mainScreenController.tabIndex.value==0? 1.4 : 1.25,
  //                   child: SvgPicture.asset(mainScreenController.tabIndex.value==0 ?ImageConstant.homeNavIcon : ImageConstant.homeWhiteNavIcon)),
  //               title: texts(strHome , fontSize: Get.height*0.016 ,
  //                 latterSpacing: 0.0,
  //                 textColor:mainScreenController.tabIndex.value==0 ? bottomNavTextColor: Colors.white,fontWeight: FontWeight.w700 ,  ),
  //               selectedColor: mainScreenController.tabIndex.value==0 ? Colors.white: Colors.transparent,
  //               unselectedColor: Colors.transparent
  //           ),
  //
  //           /// Likes
  //           SalomonBottomBarItem(
  //               icon: Transform.scale(
  //                   scale:mainScreenController.tabIndex.value==1? 1.4: 1.25,
  //                   child: SvgPicture.asset(mainScreenController.tabIndex.value==1 ?ImageConstant.cartNavIcon : ImageConstant.cartWhiteNavIcon)),
  //               title: texts(strCart , fontSize: Get.height*0.016 ,
  //                 latterSpacing: 0.0,
  //                 textColor:mainScreenController.tabIndex.value==1 ? bottomNavTextColor: Colors.white,fontWeight: FontWeight.w700 ,  ),
  //               selectedColor: mainScreenController.tabIndex.value==1 ? Colors.white: Colors.transparent,
  //               unselectedColor: Colors.transparent
  //           ),
  //
  //           /// Search
  //           SalomonBottomBarItem(
  //               icon: Transform.scale(
  //                   scale:mainScreenController.tabIndex.value==2? 1.4 : 1.25,
  //                   child: SvgPicture.asset(mainScreenController.tabIndex.value==2 ?ImageConstant.favNavIcon : ImageConstant.favWhiteNavIcon)),
  //               title: texts(strWishlist , fontSize: Get.height*0.016 ,
  //                 latterSpacing: 0.0,
  //                 textColor:mainScreenController.tabIndex.value==2 ? bottomNavTextColor: Colors.white,fontWeight: FontWeight.w700 ,  ),
  //               selectedColor: mainScreenController.tabIndex.value==2 ? Colors.white: Colors.transparent,
  //               unselectedColor: Colors.transparent
  //           ),
  //
  //
  //           /// Profile
  //           SalomonBottomBarItem(
  //               icon: Transform.scale(
  //                   scale:mainScreenController.tabIndex.value==3? 1.4 : 1.25,
  //                   child: SvgPicture.asset(mainScreenController.tabIndex.value==3 ?ImageConstant.profileNavIcon : ImageConstant.profileWhiteNavIcon)),
  //               title: texts(strProf , fontSize: Get.height*0.016 ,
  //                 latterSpacing: 0.0,
  //                 textColor:mainScreenController.tabIndex.value==3 ? bottomNavTextColor: Colors.white,fontWeight: FontWeight.w700 ,  ),
  //               selectedColor: mainScreenController.tabIndex.value==3 ? Colors.white: Colors.transparent,
  //               unselectedColor: Colors.transparent
  //           ),
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
