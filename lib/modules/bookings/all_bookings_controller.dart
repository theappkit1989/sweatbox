import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:s_box/modules/bookings/order_details_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../extras/constant/shared_pref_constant.dart';
import '../../services/api/api_endpoint.dart';
import '../../services/commonModels/userAllData.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';import 'package:flutter/material.dart';

import '../my_profile/my_profile_controller.dart';

class AllBookingsController extends GetxController {
  RxBool isActive = true.obs;
  RxList<Services> servicesList = <Services>[].obs;
  RxList<Membership> membershipList = <Membership>[].obs;
  RxList<BookingItem> bookingItems = <BookingItem>[].obs;
  var storage = GetStorage();
  String token='';
  String user_id='';

  @override
  void onInit() {
    super.onInit();
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();
    fetchUserServices();
  }
  void goToOrderDetails(BookingItem service) {
    Get.to(OrderDetailsView(),arguments: {"service":service});
  }

  // Future<void> fetchUserServices(String userId, String token) async {
  //   var uri = Uri.parse(ApiEndpoint.userData).replace(queryParameters: {
  //     'id': userId,
  //   });
  //
  //   var apiResponse = await http.get(
  //     uri,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   if (apiResponse.statusCode == 200) {
  //     try {
  //       var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
  //       UserAllData userData = UserAllData.fromJson(decodedResponse);
  //       if (userData.status == true) {
  //         servicesList.value = userData.services!;
  //       } else {
  //         // Handle error
  //         Get.snackbar('Error', userData.message ?? 'Unknown error occurred');
  //       }
  //     } catch (e) {
  //       print('Error decoding response: $e');
  //       Get.snackbar('Error', 'Error decoding response');
  //     }
  //   } else {
  //     try {
  //       var decodedResponse = jsonDecode(utf8.decode(apiResponse.bodyBytes));
  //       Get.snackbar(
  //           'Error', decodedResponse['error'] ?? 'Unknown error occurred');
  //     } catch (e) {
  //       print('Error decoding error response: $e');
  //       Get.snackbar('Error', 'Error: ${apiResponse.body}');
  //     }
  //   }
  // }
  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
  void fetchUserServices() async {
    // _showLoadingDialog();
    FocusScope.of(Get.context!).unfocus();


    var _response = await ApiController().getUserData(user_id, token);
    if (_response.status == true) {
      // _dismissDialog();
      if (_response.status == true) {
        List<BookingItem> items = [];
        items.addAll(_response.services!.map((s) => BookingItem.fromService(s)));
        items.addAll(_response.membership!.map((m) => BookingItem.fromMembership(m)));
        bookingItems.value = items;
        // print('booking item are ${items.first.date}');
        servicesList.value = _response.services!;
        membershipList.value = _response.membership!;
      } else {
        // Handle error
        Get.snackbar('Error', _response.message ?? 'Unknown error occurred',colorText: Colors.white);
      }
    } else {
      if(_response.message=='The selected id is invalid.'){
        Get.find<MyProfileController>().logout();
      }
      // _dismissDialog();
      Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
    }
  }
}
class BookingItem {
  int? id;
  int? appuserId;
  String? name;
  String? date;
  String? time;
  String? code;
  String? duration;
  String? price;
  String? type; // 'service' or 'membership'
  String? discount;
  String? activeTime;
  String? expireTime;

  BookingItem({
    this.id,
    this.appuserId,
    this.name,
    this.date,
    this.time,
    this.code,
    this.duration,
    this.price,
    this.type,
    this.discount,
    this.activeTime,
    this.expireTime,
  });

  factory BookingItem.fromService(Services service) {
    return BookingItem(
      id: service.id,
      appuserId: service.appuserId,
      name: service.name,
      date: service.date,
      time: service.time,
      code: service.code,
      duration: service.duration,
      price: service.price,
      type: 'service',
    );
  }

  factory BookingItem.fromMembership(Membership membership) {
    return BookingItem(
      id: membership.id,
      appuserId: membership.appuserId,
      name: membership.name,
      date: membership.expireTime,

      time: membership.expireTime,
      code: membership.code,
      price: membership.price,
      type: 'membership',
      discount: membership.discount,
      activeTime: membership.activeTime,
      expireTime: membership.expireTime,
    );
  }

}
