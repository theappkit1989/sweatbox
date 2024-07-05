import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:s_box/modules/home_screen/home_view.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/massage_booking/massage_payment_successful_controller.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../services/commonModels/ServiceDataClass.dart';
import '../../themes/colors/color_light.dart';
import '../bookings/all_bookings_controller.dart';
import '../commonWidgets/submitBtn.dart';
import '../home_screen/home_controller.dart';

class MassagePaymentSuccessfulView extends StatelessWidget {
  final paymentSuccessfulController = Get.put(MassagePaymentSuccessfulController());
  MassagePaymentSuccessfulView({super.key});
  var storage = GetStorage();
  String username = '';
  String _userid= '';
  @override
  Widget build(BuildContext context) {
    username=storage.read(userName);
    _userid=storage.read(userid);
    final arguments = Get.arguments as Map<String, dynamic>;
    final ServiceDataClass massage = arguments['massage'];
    final  massageType = arguments['massage_type'];
    String qrData = '''
      Title: Massage
      User ID: ${_userid}
      Price: £${massage.data?.price}
      Time: ${massage.data?.time}
      Duration Time: ${massage.data?.duration} min
    ''';
    return Scaffold(
      backgroundColor: ColorLight.white,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                    child:buildPaymentSuccess(massage)),
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
                    buildDetails(massage,massageType))
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
              //    var homecont= Get.find<MainScreenController>();
              //    homecont.tabIndex.value=2;
              //     homecont.update();
              //         print("object${Get.find<MainScreenController>().tabIndex.value}");
              //    var bookingcont= Get.find<AllBookingsController>();
              //    bookingcont.onInit();
              //     if (Get.find<MainScreenController>().tabIndex.value == 2) {
              //       // Navigate to HomeScreenView with AllBookingsView already visible
              //       Get.close(4);
              //     } else {
              //       // Navigate to HomeScreenView
              //       // Get.offAll(() => HomeScreenView(), transition: Transition.fade);
              //     }
              //         }, width: Get.width),)
              //buildBook()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: Get.height * 0.03),
        child: customSubmitBtn(
          text: strMyBookings,
          voidCallback: () {
            var homecont= Get.find<MainScreenController>();
            homecont.tabIndex.value=2;
            homecont.update();
            print("object${Get.find<MainScreenController>().tabIndex.value}");
            var bookingcont= Get.find<AllBookingsController>();
            bookingcont.onInit();
            if (Get.find<MainScreenController>().tabIndex.value == 2) {
              // Navigate to HomeScreenView with AllBookingsView already visible
              Get.close(4);
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

  buildPaymentSuccess(ServiceDataClass massage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          ImageConstant.verifyImg,
          width: Get.width * 0.2,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          strPaymentSuccess,
          style: TextStyle(
            fontSize: 14,
            color: ColorLight.white,
            fontFamily: fontType,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
         Text(
          "Your Sweatbox unique code is ${massage.data?.code}",
          style: TextStyle(
            fontSize: 12,
            color: ColorLight.white,
            fontFamily: fontType,
            fontWeight: FontWeight.w400,
          ),
        ),
        // SizedBox(
        //   height: Get.height * 0.03,
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
      ],
    );
  }

  Widget buildQrCode(String username,String qrData) {
    return Container(
      width: Get.width * 0.8,
      height: Get.height * 0.35,

      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: Get.width * 0.7,
            height: Get.height * 0.3,
            padding: EdgeInsets.all(10),
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

  buildDetails(ServiceDataClass massage, massageType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        // SizedBox(height: Get.height * 0.01,),
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
                   Text(formatDateString(massage.data?.date??"2024-07-09"),
                    style: TextStyle(
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
                  const Text(strTime,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: fontType,
                        color: ColorLight.white,
                        fontWeight: FontWeight.w400
                    ),),
                  SizedBox(height: Get.height * 0.01,),
                   Text(massage.data?.time??"",
                    style: TextStyle(
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
                   Text('£${massage.data?.price}0',
                    style: TextStyle(
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
        SizedBox(height: Get.height * 0.04,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(strServices,
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: fontType,
                  color: ColorLight.white,
                  fontWeight: FontWeight.w400
              ),),
            SizedBox(height: Get.height * 0.01,),
             Text(massageType=='2'?'Massage + Club Access':'Full Body Massage',
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: fontType,
                  color: ColorLight.white,
                  fontWeight: FontWeight.w700
              ),),
          ],
        ),
      ],
    );
  }
  String formatDateString(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);
    return formattedDate;
  }
}
