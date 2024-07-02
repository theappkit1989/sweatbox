import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';

import 'package:s_box/themes/colors/color_light.dart';

import '../../extras/constant/app_images.dart';
import 'massage_and_entrance_controller.dart';
import 'massage_controller.dart';

class MassageAndEntranceView extends StatelessWidget {
  final massageAndEntranceController = Get.put(MassageAndEntranceController());
  MassageAndEntranceView({super.key});

  @override
  Widget build(BuildContext context) {
    final Massage selectedMassage = Get.arguments[0];
    final String selectedDate = Get.arguments[1];
    final String selectedtime = Get.arguments[2];
    final String selectedDuration = Get.arguments[3];
    massageAndEntranceController.massage.value = selectedMassage;
    massageAndEntranceController.selectedDate.value = selectedDate;
    massageAndEntranceController.selectedtime.value = selectedtime;
    massageAndEntranceController.selectedduration.value = selectedDuration;

    return Scaffold(
        appBar:AppBar(
          backgroundColor: ColorLight.black,
          centerTitle: true,
          title: const Text(
            strMassageEntranceFee,
          ),
          titleTextStyle: const TextStyle(
            color: appPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: ColorLight.white,
            ),
          ),
        ),
        backgroundColor: ColorLight.white, body: buildBody(context));
  }

  buildBody(BuildContext context) {
    return Container(
      width: Get.width,
      color: ColorLight.white,
      child: Container(
        width: Get.width,
        height: Get.height,

        decoration: BoxDecoration(
            color: ColorLight.black,
           ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // const Text(
            //   strMassageEntranceFee,
            //   style: TextStyle(
            //     color: appPrimaryColor,
            //     fontWeight: FontWeight.w700,
            //     fontSize: 20.0,
            //     fontFamily: fontType,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: 8.0),
              child: const Text(
                strMembershipSubtitle,
                style: TextStyle(
                  color: ColorLight.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  fontFamily: fontType,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  Membership membership = massageAndEntranceController.memberships[index];
                  return buildRadioTile(
                    index: index,
                      title: membership.title,
                      subtitle: "£${membership.price}",
                      trailing:  membership.discount!=''?Container(
                        width: Get.width * 0.3,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: ColorLight.white),
                        height: Get.height * 0.04,
                        child: Text(
                          membership.discount,
                          style: const TextStyle(
                            color: appPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontFamily: fontType,
                            fontSize: 12.0,
                          ),
                        ),
                      ):SizedBox(),
                      values: index
                  );
                },
                itemCount: massageAndEntranceController.memberships.length,
                primary: false,
                physics: const AlwaysScrollableScrollPhysics(),
              ),
            ),

          Row(
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  children: List.generate(
                    (150 / (0.5 + 0.5)).floor(),
                        (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 5),
                padding: EdgeInsets.symmetric(horizontal: 8.0), // Padding around text
                child: Text(
                  "Massage Only",
                  style: TextStyle(
                    fontSize: Get.width*0.04,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Row(
                  children: List.generate(
                    (150 / (0.5 + 0.5)).floor(),
                        (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.white,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),

            buildRadioTileMassage(title: massageAndEntranceController.massage.value.title, subtitle: massageAndEntranceController.massage.value.subtitle, trailing:
            Text("£${massageAndEntranceController.massage.value.price}",
              style:  TextStyle(
                  color: ColorLight.white,
                  fontSize: 12.0,
                  fontFamily: fontType,
                  fontWeight: FontWeight.w600),
            ),

                values: -1),
            Padding(padding: EdgeInsets.symmetric(horizontal:
            Get.width * 0.03,vertical: Get.height*0.03),
              child: customSubmitBtn(
                  text: strContinue, voidCallback: () {massageAndEntranceController.goToPaymentMethod();}, width: Get.width),)
          ],
        ),
      ),
    );
  }

  buildRadioTile(
      {required String title,
        required String subtitle,
        required Widget trailing,
        required int values,required int index}) {
    return Obx(
            () =>Container(
        decoration: BoxDecoration(
          color: massageAndEntranceController.isSelected[index].value?appPrimaryColor:Colors.transparent,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: textFieldColor),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
        child: Obx(
              () => RadioListTile(
              value: values,
              groupValue: massageAndEntranceController.selectedValue.value,
              onChanged: (value) {
                massageAndEntranceController.selectedValue.value = value??6;
                massageAndEntranceController.isSelected.forEach((v){
                  v.value=false;
                });
                massageAndEntranceController.isSelected[index].toggle();
              },
                  toggleable: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)

              ),
              title: Text(
                title,
                style: const TextStyle(
                    color: ColorLight.white,
                    fontSize: 14.0,
                    fontFamily: fontType,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(
                    color: ColorLight.white,
                    fontSize: 12.0,
                    fontFamily: fontType,
                    fontWeight: FontWeight.w600),
              ),
              activeColor: ColorLight.white,
              dense: true,
              secondary: trailing
          ),
        )));
  }

  buildRadioTileMassage(
      {required String title,
        required String subtitle,
        required Widget trailing,
        required int values}) {
    return Container(
        decoration: BoxDecoration(
          color: appPrimaryColor,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: textFieldColor),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
        child:  RadioListTile(
              value: values,
              groupValue: -1,
              onChanged: (value) {

              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)

              ),
              title: Text(
                title,
                style: const TextStyle(
                    color: ColorLight.white,
                    fontSize: 14.0,
                    fontFamily: fontType,
                    fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                '$subtitle Minutes',
                style: const TextStyle(
                    color: ColorLight.white,
                    fontSize: 12.0,
                    fontFamily: fontType,
                    fontWeight: FontWeight.w600),
              ),
              activeColor: ColorLight.white,
              dense: true,
              secondary: trailing
          ),
        );
  }
}


class CenteredTextAboveDottedLine extends StatelessWidget {
  final String text;

  CenteredTextAboveDottedLine({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(double.infinity, 20),
              painter: DottedLinePainter(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),

              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0), // Adjust the space between text and dotted line
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 5;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2),
          paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
