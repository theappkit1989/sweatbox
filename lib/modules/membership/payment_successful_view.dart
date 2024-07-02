import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/home_screen/home_view.dart';
import 'package:s_box/modules/membership/membership_controller.dart';
import 'package:ticket_widget/ticket_widget.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/commonModels/membershipModal.dart';
import '../../themes/colors/color_light.dart';
import '../commonWidgets/submitBtn.dart';
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
      appBar: AppBar(

        backgroundColor: ColorLight.white,
        centerTitle: true,
        title: const Text(
          strPaymentSuccess,
        ),
        titleTextStyle: const TextStyle(
          color: ColorLight.black,
          fontWeight: FontWeight.w700,
          fontFamily: fontType,
          fontSize: 18.0,
        ),
      ),
      body: SingleChildScrollView(
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
                  buildDetails(membership))
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal:
            Get.width * 0.03,vertical: Get.height*0.03),
              child: customSubmitBtn(
                  text: strContinue, voidCallback: () {Get.to(HomeScreenView());}, width: Get.width),)
            //buildBook()
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
            width: Get.width * 0.7,
            height: Get.height * 0.32,

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
                  Text(membership.data!.activeTime!.split('T').first,
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
}
