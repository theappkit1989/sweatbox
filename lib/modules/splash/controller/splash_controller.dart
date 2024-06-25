import 'dart:async';
import 'package:s_box/modules/home_screen/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/login/view/login_view.dart';
import 'package:s_box/modules/signup/view/signup_view.dart';

import '../../../extras/constant/shared_pref_constant.dart';

class SplashController extends GetxController {
  final PageController pageController = PageController();
  var currentIndexPage = 0.obs;
  int? pageLength;
  var showLoader = false.obs;
  var storage = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    String isLoggedIn = storage.read(userToken);
    String id = storage.read(userid).toString();
    print("token is $isLoggedIn and id is $id");
    super.onInit();
    // Timer(const Duration(seconds: 2),
    //         ()=>Get.offAll(()=> HomeScreenView())
    // );
    if(isLoggedIn==''){
      Timer(const Duration(seconds: 2),
              ()=>Get.offAll(()=>LoginView())
      );
    }else{
      Timer(const Duration(seconds: 2),
              ()=>Get.offAll(()=>HomeScreenView())
      );
    }

  }
}
