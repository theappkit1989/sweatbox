import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';

import '../commonWidgets/submitBtn.dart';

class MassageView extends StatelessWidget {

  final massageController = Get.put(MassageController());
  MassageView({super.key});

  @override
  Widget build(BuildContext context) {
    print("massage build ");
    return Scaffold(
        backgroundColor: ColorLight.black,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: Get.height * 0.09),
              padding: EdgeInsets.only(top: Get.height * 0.1,
                  left: Get.width * 0.05 , right: Get.width * 0.05),
              decoration: BoxDecoration(
                color: ColorLight.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  text(
                      text: 'Book a Massage',
                      size: 20,
                      fontWeight: FontWeight.w700,
                      color: ColorLight.white),
                  SizedBox(
                    height: Get.height * 0.007,
                  ),
                  text(
                      text: strMassages,
                      size: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Massage massage=MassageController().massages[index];
                        return buildRadioListTile(
                          index: index,
                          title: "${massage.title}",
                          subtitle: "${massage.subtitle} min",
                          trailing: "£${massage.price}",
                          values: index);},
                      primary: false,
                      shrinkWrap: true,
                      itemCount: massageController.massages.length,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03,vertical: 50),
                    child: customSubmitBtn(
                        text: strContinue, voidCallback: () {massageController.goToPaymentMethod();}, width: Get.width),)
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorLight.white, width: 2.0),
                  image: const DecorationImage(
                      image: AssetImage(ImageConstant.massageImg))),
              width: Get.width * 0.45,
              height: Get.height * 0.15,
              margin: EdgeInsets.only(top: Get.height * 0.012),
            ),
          ],
        ));
  }

  buildRadioListTile(
      {required String title,
      required String subtitle,
      required String trailing,
      required int values ,required int index}) {
    return Obx(
            () =>Container(
      decoration: BoxDecoration(
        color: massageController.isSelected[index].value?appPrimaryColor:Colors.transparent,
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(color: textFieldColor),
      ),
      margin: EdgeInsets.only(top: Get.height * 0.02),
      child: Obx(
        () => RadioListTile(
            value: values,
            groupValue: massageController.selectedValue.value,
            onChanged: (value) {
              massageController.selectedValue.value = value!;
              massageController.isSelected.forEach((v){
                v.value=false;
              });
              massageController.isSelected[index].toggle();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
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
            secondary: text(
                text: trailing,
                size: 16,
                fontWeight: FontWeight.w700,
                color: ColorLight.white)),
      ),
    ));
  }
}
