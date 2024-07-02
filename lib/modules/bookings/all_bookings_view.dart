import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/bookings/all_bookings_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../../services/commonModels/userAllData.dart';
import '../commonWidgets/common.dart';
import '../commonWidgets/submitBtn.dart';
import 'order_details_view.dart'; // Assuming this is the view for order details

class AllBookingsView extends StatelessWidget {
  final AllBookingsController allBookingsController = Get.put(AllBookingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        title: const Text(
          strAllBookings,
          style: TextStyle(
            color: ColorLight.white,
            fontWeight: FontWeight.w600,
            fontFamily: fontType,
            fontSize: 20,
          ),
        ),
        backgroundColor: ColorLight.black,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {


        List<Services> activeBookings = [];
        List<Services> historyBookings = [];

        final now = DateTime.now();

        for (var service in allBookingsController.servicesList) {
          final serviceDateTime = DateTime.parse('${service.date} ${service.time}');
          if (serviceDateTime.isBefore(now)) {
            historyBookings.add(service);
          } else {
            activeBookings.add(service);
          }
        }
        // if (activeBookings.isEmpty||historyBookings.isEmpty) {
        //   return Center(
        //     child: Text(
        //       allBookingsController.isActive.value
        //           ? 'No active bookings at this time'
        //           : 'No booking history',
        //       style: TextStyle(
        //         color: ColorLight.white,
        //         fontSize: 16,
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //   );
        // }
        List<Services> displayBookings =
        allBookingsController.isActive.value ? activeBookings : historyBookings;

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
                decoration: BoxDecoration(
                  color: appPrimaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                width: Get.width,
                height: kToolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        allBookingsController.isActive.value = true;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text(
                            text: strActive,
                            size: 14,
                            fontWeight: FontWeight.w700,
                            color: ColorLight.white,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          allBookingsController.isActive.value
                              ? Container(
                            width: Get.width * 0.2,
                            height: 2,
                            color: ColorLight.white,
                          )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        allBookingsController.isActive.value = false;
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          text(
                            text: strHistory,
                            size: 14,
                            fontWeight: FontWeight.w700,
                            color: ColorLight.white,
                          ),
                          SizedBox(height: Get.height * 0.02),
                          allBookingsController.isActive.value == false
                              ? Container(
                            width: Get.width * 0.2,
                            height: 2,
                            color: ColorLight.white,
                          )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.04),
                decoration: BoxDecoration(
                  color: ColorLight.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: displayBookings.isEmpty?Center(
                  child: Text(
                    allBookingsController.isActive.value
                        ? 'No active bookings at this time'
                        : 'No booking history',
                    style: TextStyle(
                      color: ColorLight.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ):ListView.separated(
                  itemBuilder: (context, index) => buildActiveWidget(displayBookings[index]),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: displayBookings.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(
                    color: textFieldColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildActiveWidget(Services service) {
    return SizedBox(
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  ImageConstant.serviceImg,
                  width: Get.width * 0.22,
                  height: Get.height * 0.12,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: Get.width * 0.04),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name ?? 'Service Name',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: fontType,
                      fontWeight: FontWeight.w700,
                      color: ColorLight.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Details: ${service.duration} min',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorLight.white,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            ImageConstant.dateIcon,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            service.date ?? 'Date',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorLight.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            ImageConstant.timeIcon,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            service.time ?? 'Time',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorLight.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Image.asset(
                        ImageConstant.chatRed,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        strSendMsg,
                        style: TextStyle(
                            fontFamily: fontType,
                            color: appPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ],
                  ),
                  color: ColorLight.white,
                  minWidth: Get.width * 0.4,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                ),
                MaterialButton(
                  onPressed: () => {allBookingsController.goToOrderDetails(service)},
                  child: const Text(
                    strViewDetails,
                    style: TextStyle(
                        fontFamily: fontType,
                        color: yellowF5EA25,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                  color: ColorLight.black,
                  minWidth: Get.width * 0.4,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: const BorderSide(color: yellowF5EA25)),
                ),
              ],
            ),
          ),
          // SizedBox(
          //
          //   child: customSubmitBtn(
          //     voidCallback: () {
          //       allBookingsController.goToOrderDetails(service);
          //     },
          //     width: Get.width,
          //     text: 'View Details',
          //   ),
          // ),
        ],
      ),
    );
  }
}
