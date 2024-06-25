import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/massage_booking/get_access_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';

import '../../extras/constant/app_constant.dart';

class GetAccessView extends StatelessWidget {
  final getAccessController = Get.put(GetAccessController());
  GetAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorLight.black,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  text(
                      text: strMassageEntranceFee,
                      size: 20,
                      fontWeight: FontWeight.w700,
                      color: appPrimaryColor),
                  text(
                    text: strIncludesFullAccess,
                    size: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorLight.white,
                  ),
                  ListView.builder(
                    itemBuilder: (context, index) => buildRadioTile(
                        title: getAccessController.membershipTitleList[index],
                        subtitle:
                            getAccessController.membershipSubTitleList[index],
                        trailing: Container(
                          width: Get.width * 0.3,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: ColorLight.white),
                          height: Get.height * 0.04,
                          child: Text(
                            getAccessController.trailing[index],
                            style: const TextStyle(
                              color: appPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: fontType,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        values: index),
                    itemCount:
                        getAccessController.membershipSubTitleList.length,
                    shrinkWrap: true,
                    primary: false,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.02,
                        vertical: Get.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Row(
                            children: List.generate(
                                150 ~/ 2.5,
                                (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                        height: 1,
                                      ),
                                    )),
                          ),
                        ),
                        text(
                            text: strMassageOnly,
                            size: 13,
                            fontWeight: FontWeight.w600,
                            color: ColorLight.white),
                        SizedBox(
                          width: Get.width * 0.3,
                          child: Row(
                            children: List.generate(
                                150 ~/ 2.5,
                                (index) => Expanded(
                                      child: Container(
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.grey,
                                        height: 1,
                                      ),
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildRadioTile(
                      title: 'Deep Tissue Massage',
                      subtitle: '1 hour',
                      trailing: text(
                          text: '£45',
                          size: 16,
                          fontWeight: FontWeight.w700,
                          color: ColorLight.white),
                      values: 10)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.02,
              ),
              child: customSubmitBtn(
                  text: strContinue, voidCallback: () => getAccessController.goToPaymentMethod(), width: Get.width),
            )
          ],
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
              groupValue: getAccessController.selectedValue.value,
              onChanged: (value) {
                getAccessController.selectedValue.value = value!;
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
              secondary: trailing),
        ));
  }
}
