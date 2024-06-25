

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/bookings/all_bookings_controller.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/membership/membership_controller.dart';
import 'package:s_box/modules/messages/all_messages_controller.dart';
import 'package:s_box/modules/messages/chat_controller.dart';
import 'package:s_box/modules/my_profile/my_profile_controller.dart';

import '../bookings/all_bookings_view.dart';
import '../massage_booking/massage_view.dart';
import '../membership/membership_view.dart';
import '../messages/all_messages_view.dart';
import '../my_profile/my_profile_view.dart';

class MainScreenController extends GetxController{
  var tabIndex = 0.obs;
  var data = Get.arguments;



  List<Widget> screens=[
    MembershipView(),
    MassageView(),
    AllMessagesView(),
    AllBookingsView(),
    MyProfileView(),
  ];
   changeTabIndex(int index){
     print(index);
    tabIndex.value = index;
    if(tabIndex.value==0){

        var homeCont = Get.find<MembershipController>();
        homeCont.onInit();

    } else if(tabIndex.value==1) {
      var homeCont = Get.find<MassageController>();
      homeCont.onInit();
    } else if(tabIndex.value==2) {
      var homeCont = Get.find<AllMessagesController>();
      homeCont.onInit();
    } else if(tabIndex.value==3) {
      var homeCont = Get.find<AllBookingsController>();
      homeCont.onInit();
    } else if(tabIndex.value==4) {
      var homeCont = Get.find<MyProfileController>();
      homeCont.onInit();
    }

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(data!=null) {
      tabIndex.value = 0;
      tabIndex.refresh();
    }
  }

}