import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/bookings/all_bookings_controller.dart';
import 'package:s_box/modules/home_screen/home_view.dart';
import 'package:s_box/modules/membership/membership_controller.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/commonModels/membershipModal.dart';
import '../../themes/colors/color_light.dart';
import '../commonWidgets/submitBtn.dart';
import '../home_screen/home_controller.dart';
import '../membership/payment_successful_controller.dart';
import 'membership_view.dart';

class PaymentSuccessfulView extends StatelessWidget {
  final paymentSuccessfulController = Get.put(PaymentSuccessfulController());
  var storage = GetStorage();
  String username = '';
  String _userid= '';

  PaymentSuccessfulView({super.key});

  @override
  Widget build(BuildContext context) {
    username=storage.read(userName);
    _userid=storage.read(userid);
    final arguments = Get.arguments as Map<String, dynamic>;
    final MembershipDataclass membership = arguments['membership'];
    String qrData = '''
      Title: ${membership.data?.name}
      User ID: ${_userid}
      Price: £${membership.data?.price}
      Discount: ${membership.data?.discount}
      Active Time: ${membership.data?.activeTime}
      Expire Time: ${membership.data?.expireTime}
      Code: ${membership.data?.code}
    ''';

    return Scaffold(
      backgroundColor: ColorLight.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
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
                        child:buildPaymentSuccess(membership)),
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
                        ),child:
                    buildQrCode(username,qrData),),
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
                            horizontal: Get.width * 0.05, vertical: Get.height * 0.02),

                        decoration: BoxDecoration(
                          color: ColorLight.black,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),
                        ),child:
                    buildDetails(membership))
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),

              // Padding(padding: EdgeInsets.symmetric(horizontal:
              // Get.width * 0.03,vertical: Get.height*0.03),
              //   child: customSubmitBtn(
              //       text: strAllBookings, voidCallback: () {
              //     var homecont= Get.find<MainScreenController>();
              //     homecont.tabIndex.value=0;
              //     homecont.update();
              //     var bookingcont= Get.find<AllBookingsController>();
              //     bookingcont.onInit();
              //     print("object${Get.find<MainScreenController>().tabIndex.value}");
              //
              //     if (Get.find<MainScreenController>().tabIndex.value == 0) {
              //       // Navigate to HomeScreenView with AllBookingsView already visible
              //       Get.close(2);
              //       // Get.offAll(() => HomeScreenView(), transition: Transition.fade, arguments: 2);
              //     } else {
              //       // Navigate to HomeScreenView
              //       // Get.offAll(() => HomeScreenView(), transition: Transition.fade);
              //     }
              //         }, width: Get.width),)
              // //buildBook()buildBook
            ],
          ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Container(
          //       width: Get.width,
          //       padding: EdgeInsets.symmetric(
          //           horizontal: Get.width * 0.05, vertical: Get.height * 0.04),
          //       margin: EdgeInsets.symmetric(
          //           horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
          //       decoration: BoxDecoration(
          //         color: ColorLight.black,
          //         borderRadius: BorderRadius.circular(25),
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           buildPaymentSuccess(membership),
          //           buildQrCode(username,qrData),
          //           buildDetails(membership)
          //         ],
          //       ),
          //     ),
          //     SizedBox(
          //       height: Get.height * 0.05,
          //     ),
          //     // customSubmitBtn(text: "Home", voidCallback: (){Get.offAll(HomeScreenView());}, width: Get.width)
          //   ],
          // ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: Get.height * 0.03),
        child: customSubmitBtn(
          text: strMyBookings,
          voidCallback: () {
            var homecont= Get.find<MainScreenController>();
                homecont.tabIndex.value=3;
                homecont.update();
                var bookingcont= Get.find<AllBookingsController>();
                bookingcont.onInit();
                print("object${Get.find<MainScreenController>().tabIndex.value}");

                if (Get.find<MainScreenController>().tabIndex.value == 3) {
                  // Navigate to HomeScreenView with AllBookingsView already visible
                  Get.close(3);
                  // Get.offAll(() => HomeScreenView(), transition: Transition.fade, arguments: 2);
                } else {
                  // Navigate to HomeScreenView
                  // Get.offAll(() => HomeScreenView(), transition: Transition.fade);
                }
          },
          width: Get.width,
        ),
      ),

    );
  }

  Widget buildPaymentSuccess(MembershipDataclass membership) {
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
         Text(
          "Your Sweatbox unique code is ${membership.data?.code} ",
          style: TextStyle(
            fontSize: 12,
            color: ColorLight.white,
            fontFamily: fontType,
            fontWeight: FontWeight.w400,
          ),
        ),

      ],
    );
  }

  Widget buildQrCode(String username,String qrData) {
    return Container(
      width: Get.width * 0.8,
      height: Get.height * 0.4,
      margin: EdgeInsets.only(
        top: Get.height * 0.03,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: Get.width * 0.5,
            height: Get.height * 0.29,

            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                border: Border.all(color: textFieldColor)),
            child: QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: Get.width * 0.7,
              gapless: false,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: Get.width * 0.45,
              height: Get.height * 0.05,
              alignment: Alignment.center,
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
    );
  }

  Widget buildDetails(MembershipDataclass membership) {
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
                  const Text(strDate,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w400
                    ),),
                  SizedBox(height: Get.height * 0.01,),
                  Text(formatDateString(membership.data!.activeTime!.split('T').first),
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w700
                    ),),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(strMemberships,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w400
                    ),),
                  SizedBox(height: Get.height * 0.01,),
                  Text(membership.data?.name??"",
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w700
                    ),),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(strPrice,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w400
                    ),),
                  SizedBox(height: Get.height * 0.01,),
                  Text('£${membership.data?.price}0 ',
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w700
                    ),),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  String formatDateString(String dateString) {
    // Define a map to convert month names to numeric values
    Map<String, String> monthMap = {
      'January': '01', 'February': '02', 'March': '03',
      'April': '04', 'May': '05', 'June': '06',
      'July': '07', 'August': '08', 'September': '09',
      'October': '10', 'November': '11', 'December': '12'
    };

    // Split the input date string
    List<String> parts = dateString.split(' ');

    // Extract day, month, and year
    String day = parts[0];
    String month = parts[1];
    String year = parts[2];

    // Convert day to two digits
    if (day.length == 1) {
      day = '0$day';
    }

    // Get numeric month value
    String monthNumeric = monthMap[month] ?? '01'; // Default to January if not found

    // Return the formatted date string
    return '$day $month $year';
  }
}
