import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/my_profile/manage_subscription_controller.dart';
import 'package:s_box/services/commonModels/userAllData.dart';
import 'package:s_box/themes/colors/color_light.dart';
import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../services/commonModels/membershipModal.dart';

class ManageSubscriptionView extends StatelessWidget {
  final manageSubscriptionController = Get.put(ManageSubscriptionController());
  ManageSubscriptionView({super.key});
  var storage = GetStorage();
  String username = '';
  String _userid= '';
  @override
  Widget build(BuildContext context) {
    username=storage.read(userName);
    _userid=storage.read(userid);
    final arguments = Get.arguments as Map<String, dynamic>;
    final Membership membership = arguments['membership'];
    String qrData = '''
      Title: ${membership.name}
      User ID: ${_userid}
      Price: £${membership.price}
      Discount: ${membership.discount}
      Active Time: ${membership.activeTime}
      Expire Time: ${membership.expireTime}
      Code: ${membership.code}
    ''';
    return Scaffold(
      backgroundColor: ColorLight.white,
      appBar: AppBar(
        backgroundColor: ColorLight.white,
        centerTitle: true,
        title: const Text(
          strManageSubscription,
        ),
        titleTextStyle: const TextStyle(
          color: ColorLight.black,
          fontWeight: FontWeight.w700,
          fontFamily: fontType,
          fontSize: 18.0,
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: Get.height,
          decoration: BoxDecoration(
            color: ColorLight.black,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05,),
                decoration: BoxDecoration(
                  color: ColorLight.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildQrCode(username,qrData),
                    buildDetails(membership),
                  ],
                ),
              ),

              //buildBook()
            ],
          ),
        ),
      ),
    );
  }

  buildPaymentSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstant.verifyImg,
          width: Get.width * 0.25,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          strPaymentSuccess,
          style: TextStyle(
            fontSize: 16,
            color: ColorLight.white,
            fontFamily: fontType,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          strScanQr,
          style: TextStyle(
            fontSize: 12,
            color: ColorLight.white,
            fontFamily: fontType,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Row(
          children: List.generate(
              150 ~/ 1,
                  (index) => Expanded(
                child: Container(
                  color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                  height: 1,
                ),
              )),
        ),
      ],
    );
  }

  buildQrCode(String username, String qrData) {
    return Column(
      children: [
        SizedBox(
          width: Get.width * 0.8,
          height: Get.height * 0.4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: Get.width * 0.6,
                  height: Get.height * 0.35,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.03,
                      vertical: Get.height * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                      border: Border.all(color: textFieldColor)),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: Get.width * 0.7,
                    gapless: false,
                  ),),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: Get.width * 0.45,
                  height: Get.height * 0.05,
                  alignment: Alignment.center,
                  //margin: EdgeInsets.only(top: Get.height * 0.05),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorLight.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageConstant.profileIcon,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                       Text(
                        username,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ColorLight.black,
                            fontFamily: fontType,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
      ],
    );
  }

  buildDetails(Membership membership) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(
              150 ~/ 1,
                  (index) => Expanded(
                child: Container(
                  color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                  height: 1,
                ),
              )),
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    strDate,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                   Text(
                    membership.activeTime!,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    strMemberships,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                   Text(
                    membership.name!,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    strPrice,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                   Text(
                    '£${membership.price}0',
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        Row(
          children: List.generate(
              150 ~/ 1,
                  (index) => Expanded(
                child: Container(
                  color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                  height: 1,
                ),
              )),
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
         Center(
           child: Text(
            "Your Sweatbox unique code is ${membership.code} ",
            style: TextStyle(
                fontSize: 13,
                fontFamily: fontType,
                color: ColorLight.white,
                fontWeight: FontWeight.w700),
                   ),
         ),
        // SizedBox(
        //   height: Get.height * 0.01,
        // ),
        // Container(
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(40),
        //       border: Border.all(color: textFieldColor)),
        //   child: ListTile(
        //     leading: Image.asset(
        //       ImageConstant.creditCardIcon,
        //       width: Get.width * 0.06,
        //     ),
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(40),
        //         side: const BorderSide(color: textFieldColor, width: 1.0)),
        //     title: const Text(
        //       strCardHolderName,
        //       style: TextStyle(
        //           color: ColorLight.white,
        //           fontSize: 14.0,
        //           fontFamily: fontType,
        //           fontWeight: FontWeight.w700),
        //     ),
        //     subtitle: const Text(
        //       '**** **** **** 8907',
        //       style: TextStyle(
        //           color: ColorLight.white,
        //           fontSize: 12.0,
        //           fontFamily: fontType,
        //           fontWeight: FontWeight.w600),
        //     ),
        //     dense: true,
        //   ),
        // ),
        // SizedBox(
        //   height: Get.height * 0.04,
        // ),
        // Row(
        //   children: List.generate(
        //       150 ~/ 1,
        //           (index) => Expanded(
        //         child: Container(
        //           color: index % 2 == 0 ? Colors.transparent : Colors.grey,
        //           height: 1,
        //         ),
        //       )),
        // ),
        // SizedBox(
        //   height: Get.height * 0.04,
        // ),
        // customSubmitBtn(text: strCancelRenewal, voidCallback: (){}, width: Get.width)
      ],
    );
  }
}
