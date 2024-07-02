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
        backgroundColor: ColorLight.white, body: buildBody(context));
  }

  buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        width: Get.width,
        color: ColorLight.white,
        child: Container(
          width: Get.width,
          height: Get.height,

          decoration: BoxDecoration(
              color: ColorLight.black,
              borderRadius: BorderRadius.circular(25)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.0275,
              ),
              const Text(
                strMassageEntranceFee,
                style: TextStyle(
                  color: appPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                  fontFamily: fontType,
                ),
              ),
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
            Stack(
              alignment: Alignment.center,
              children: [
                Row(
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
              ],
            ),

              buildRadioTileMassage(title: massageAndEntranceController.massage.value.title, subtitle: massageAndEntranceController.massage.value.subtitle, trailing: Text("£${massageAndEntranceController.massage.value.price}"), values: -1),
              Padding(padding: EdgeInsets.symmetric(horizontal:
              Get.width * 0.03,vertical: Get.height*0.03),
                child: customSubmitBtn(
                    text: strContinue, voidCallback: () {massageAndEntranceController.goToPaymentMethod();}, width: Get.width),)
            ],
          ),
        ),
      ),
    );
  }

  buildRadioTile(
      {required String title,
        required String subtitle,
        required Widget trailing,
        required int values}) {
    return Container(
        decoration: BoxDecoration(
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
        ));
  }

  buildRadioTileMassage(
      {required String title,
        required String subtitle,
        required Widget trailing,
        required int values}) {
    return Container(
        decoration: BoxDecoration(
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
        );
  }
}
