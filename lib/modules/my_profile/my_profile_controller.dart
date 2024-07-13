import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/login/view/login_view.dart';
import 'package:s_box/modules/my_profile/edit_profile_view.dart';
import 'package:s_box/modules/my_profile/manage_subscription_controller.dart';
import 'package:s_box/modules/my_profile/manage_subscription_view.dart';
import 'package:s_box/modules/update_password/update_password_view.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import '../../extras/constant/shared_pref_constant.dart';
import '../../fcmNotification/FirebaseMessaging.dart';
import '../../services/api/api_endpoint.dart';
import '../../services/commonModels/userAllData.dart';
import '../../services/repo/common_repo.dart';

class MyProfileController extends GetxController {
  var storage = GetStorage();
  String token = '';
  String user_id = '';
  String img = '';
  RxString imagee = ''.obs;
  RxList<Membership> memberships = <Membership>[].obs;
  RxString countdownText = ''.obs;
  Timer? countdownTimer;
  RxDouble progress = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    storage.writeIfNull(image, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();
    imagee.value = ApiEndpoint.baseUrlImage + storage.read(image);

    fetchUserServices();
    update();
  }
  @override
  void update([List<Object>? ids, bool condition = true]) {
    // TODO: implement update
    super.update(ids, condition);
    imagee.value = ApiEndpoint.baseUrlImage + storage.read(image);
  }

  List<String> titles = [
    strEditProfile,
    strChangePwd,
    strRate,
    strlogOut,
    strDeleteAccount
  ];

  List<String> leading = [
    ImageConstant.editProfile,
    ImageConstant.changePwd,
    ImageConstant.rate,
    ImageConstant.logout,
    ImageConstant.deleteAccount
  ];

  void goToEditProfile() {
    Get.to(EditProfileView());
  }

  void goToUpdatePassword() {
    print("token is $token and id is $user_id");
    Get.to(UpdatePasswordView(token: token, user_id: user_id));
  }

  void goToManageSubscription() {
    Get.to(ManageSubscriptionView());
  }

  void logout() async {
    await storage.erase();
    NotificationsSubscription.fcmUnSubscribe(user_id);
    Get.offAll(LoginView());
  }

  void rateApp() async {
    const url = 'https://play.google.com/store/apps/details?id=com.example.your_app';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
  void goToOrderDetails(Membership membership) {
    Get.to(ManageSubscriptionView(),arguments: {"membership":membership});
  }
  Future<bool?> _deleteAccountFromServer() async {
    // _showLoadingDialog();
    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().deleteUser(user_id, token);
    if (_response.status == true) {
      // _dismissDialog();
      if (_response.status == true) {
       return _response.status;
      } else {
        // Handle error
        Get.snackbar('Error', _response.message ?? 'Unknown error occurred',colorText: Colors.white);
        return _response.status;
      }
    } else {
      // _dismissDialog();

      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
      return _response.status;
    }
  }
  void deleteAccount() async {
    // Implement the logic to delete the user's account
    // This typically involves calling an API endpoint to delete the user's account
    bool success = await _deleteAccountFromServer()??false;
    if (success) {
      await storage.erase();
      NotificationsSubscription.fcmUnSubscribe(user_id);
      Get.offAll(LoginView());
    } else {
      Get.snackbar('Error', 'Failed to delete account',colorText: Colors.white);
    }
  }
  void fetchUserServices() async {
    // _showLoadingDialog();
    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().getUserData(user_id, token);
    if (_response.status == true) {
      // _dismissDialog();

        memberships.value = _response.membership!;


        startCountdown();
    } else {
      // _dismissDialog();
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
    }
  }

  void startCountdown() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateCountdown();
    });
    updateCountdown(); // Update immediately
  }

  void updateCountdown() {
    if (memberships.isNotEmpty) {
      var now = DateTime.now();
      print('date and time now $now');
      var activeTime = Membership.parseDate(memberships.last.activeTime!);
      var expireTime = Membership.parseDate(memberships.last.expireTime!);



      if (now.isBefore(activeTime)) {
        countdownText.value = 'Membership starts in ${formatDuration(activeTime.difference(now))}';
        progress.value = 0.0;
      } else if (now.isBefore(expireTime)) {
        countdownText.value = 'Membership ends in ${formatDuration(expireTime.difference(now))}';
        var totalTime = expireTime.difference(activeTime).inSeconds;
        var remainingTime = expireTime.difference(now).inSeconds;
        progress.value = remainingTime / totalTime;
      } else {
        countdownText.value = 'Membership Expired';
        progress.value = 0.0;
        if (countdownTimer != null) {
          countdownTimer!.cancel();
        }
      }
    } else {
      countdownText.value = 'No active membership found';
      progress.value = 0.0;
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:${twoDigitMinutes}:${twoDigitSeconds}';
  }

  @override
  void onClose() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    super.onClose();
  }
}
  // void startCountdown() {
  //   if (countdownTimer != null) {
  //     countdownTimer!.cancel();
  //   }
  //   countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     updateCountdown();
  //   });
  //   updateCountdown(); // Update immediately
  // }
  //
  // void updateCountdown() {
  //   if (servicesList.isNotEmpty) {
  //     var activeTime = Membership.parseDate(servicesList.last.activeTime!);
  //     var expireTime = Membership.parseDate(servicesList.last.expireTime!);
  //     var now = DateTime.now();
  //
  //     if (now.isBefore(activeTime)) {
  //       countdownText.value = 'Membership starts in ${formatDuration(activeTime.difference(now))}';
  //     } else if (now.isBefore(expireTime)) {
  //       countdownText.value = 'Membership ends in ${formatDuration(expireTime.difference(now))}';
  //     } else {
  //       countdownText.value = 'Membership expired';
  //       if (countdownTimer != null) {
  //         countdownTimer!.cancel();
  //       }
  //     }
  //   } else {
  //     countdownText.value = 'No active membership found';
  //   }
  // }
  //
  // String formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, "0");
  //   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //   return '${twoDigits(duration.inHours)}:${twoDigitMinutes}:${twoDigitSeconds}';
  // }
  //
  // @override
  // void onClose() {
  //   if (countdownTimer != null) {
  //     countdownTimer!.cancel();
  //   }
  //   super.onClose();
  // }


