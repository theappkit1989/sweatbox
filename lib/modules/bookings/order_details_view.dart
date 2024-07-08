import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:s_box/modules/bookings/all_bookings_controller.dart';
import 'package:s_box/modules/bookings/order_details_controller.dart';
import 'package:s_box/services/commonModels/userAllData.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../themes/colors/color_light.dart';

class OrderDetailsView extends StatelessWidget {
  final orderDetailsController = Get.put(OrderDetailsController());
  OrderDetailsView({super.key});
  var storage = GetStorage();
  String username = '';
  String _userid= '';
  @override
  Widget build(BuildContext context) {
    username=storage.read(userName);
    _userid=storage.read(userid);
    final arguments = Get.arguments as Map<String, dynamic>;
    // final MembershipDataclass membership = arguments['membership'];
    final BookingItem selectedService =arguments['service'];
    String qrData = '''
      Title: ${selectedService.name}
      User ID: ${_userid}
      Price: £${selectedService.price}
      
      Time: ${selectedService.time}
      Date: ${selectedService.date}
      Duration: ${selectedService.duration}
      Code: ${selectedService.code}
    ''';
    // orderDetailsController.membership.value = selectedService;
    return Scaffold(
      backgroundColor: ColorLight.white,
      appBar: AppBar(
        backgroundColor: ColorLight.white,
        centerTitle: true,
        title: const Text(
          strOrderDetails,
        ),
        titleTextStyle: const TextStyle(
          color: ColorLight.black,
          fontWeight: FontWeight.w700,
          fontFamily: fontType,
          fontSize: 18.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05),
              margin: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05),
              decoration: BoxDecoration(
                color: ColorLight.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.height * 0.02),

                decoration: BoxDecoration(
                  color: ColorLight.black,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                ),
                child:
                  buildDetails(selectedService),),
                  TicketWidget(
                    color: Colors.black,
                    width: Get.width,
                    height: 40,

                    padding: EdgeInsets.all(10),
                    child:  Row(
                      children: List.generate(
                          150 ~/ 1,
                              (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                              height: 1,
                            ),
                          )),
                    ),
                  ),
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05),

                decoration: BoxDecoration(
                  color: ColorLight.black,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                ),
                child:
                  buildQrCode(username,qrData,selectedService),),


                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            //buildBook()
          ],
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

  buildQrCode(String username, String qrData, BookingItem selectedService) {
    return Column(
      children: [
        Container(
          width: Get.width * 0.8,
          height: Get.height * 0.4,
          margin: EdgeInsets.only(top: Get.height * 0.03),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: Get.width * 0.6,
                  height: Get.height * 0.3,
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
                child: Column(
                  children: [

                    Container(
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
                  ],
                ),
              ),
            ],
          ),
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
      ],
    );
  }

  buildDetails(BookingItem selectedService) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    selectedService.type=='membership'?stractiveDate:strDate,
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
                     selectedService.type=='membership'?selectedService.activeTime!:formatDateString(selectedService.date!),
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
                   Text(
                    selectedService.type=='membership'?strexpireDate:strTime,
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
                    selectedService.time!,
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
                    '£${selectedService.price}0',
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
          height: Get.height * 0.02,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              strServices,
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
              selectedService.type=='membership'?'Membership':'Full Body Massage',
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: fontType,
                  color: ColorLight.white,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),

        Center(
          child: Text(
            "Your Sweatbox unique code is ${selectedService.code} ",
            style: TextStyle(
              fontSize: 12,
              color: ColorLight.white,
              fontFamily: fontType,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        // const Text(
        //   strPaymentMethod,
        //   style: TextStyle(
        //       fontSize: 13,
        //       fontFamily: fontType,
        //       color: ColorLight.white,
        //       fontWeight: FontWeight.w700),
        // ),
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
      ],
    );
  }
  String formatDateString(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);
    return formattedDate;
  }
}
