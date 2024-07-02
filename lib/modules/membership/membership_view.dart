import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/membership/membership_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';

import '../../extras/constant/app_images.dart';

class MembershipView extends StatelessWidget {
  final membershipController = Get.put(MembershipController());
  MembershipView({super.key});

  @override
  Widget build(BuildContext context) {
    print("membership build ");
    return Scaffold(
        backgroundColor: ColorLight.white, body: buildBody(context));
  }

  buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        width: Get.width,
        color: ColorLight.white,
        child: Stack(
          children: [
            Image.asset(ImageConstant.imgMembership),
            Container(
              width: Get.width,
              height: Get.height,
              margin: EdgeInsets.only(top: Get.height * 0.175),
              decoration: BoxDecoration(
                  color: ColorLight.black,
                 ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.0275,
                  ),
                  const Text(
                    strMembership,
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
                        Membership membership = membershipController.memberships[index];
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
                      itemCount: membershipController.memberships.length,
                      primary: false,
                      physics: const AlwaysScrollableScrollPhysics(),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal:
                  Get.width * 0.03,vertical: Get.height*0.03),
                    child: customSubmitBtn(
                        text: strContinue, voidCallback: () {membershipController.goToPaymentMethod();}, width: Get.width),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildRadioTile(
      {required String title,
      required String subtitle,
      required Widget trailing,
      required int values,
      required int index}) {
    return Obx(
            () => Container(
        decoration: BoxDecoration(
          color: membershipController.isSelected[index].value?appPrimaryColor:Colors.transparent,
          borderRadius: BorderRadius.circular(40.0),
          border: Border.all(color: textFieldColor),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
        child: Obx(
          () => RadioListTile(
              value: values,
              groupValue: membershipController.selectedValue.value,
              onChanged: (value) {
                membershipController.selectedValue.value = value!;
                membershipController.isSelected.forEach((v){
                  v.value=false;
                });
                membershipController.isSelected[index].toggle();
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
        )));
  }
}
