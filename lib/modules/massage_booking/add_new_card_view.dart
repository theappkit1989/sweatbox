import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/massage_booking/add_new_card_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:flutter/services.dart';
import '../../extras/constant/app_color.dart';

class AddNewCardView extends StatelessWidget {
  final addNewCardController = Get.put(AddNewCardController());
  AddNewCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.white,
      appBar: AppBar(
        backgroundColor: ColorLight.white,
        centerTitle: true,
        title: const Text(
          strAddCard,
        ),
        titleTextStyle: const TextStyle(
          color: ColorLight.black,
          fontWeight: FontWeight.w700,
          fontFamily: fontType,
          fontSize: 18.0,
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.height * 0.04),
                decoration: BoxDecoration(
                  color: ColorLight.black,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // buildCard(),
                    buildForm(context),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.08,
              ),
              buildAddCard()
            ],
          ),
        ),
      ),
    );
  }

  buildCard() {
    return Container(
      width: Get.width,
      height: Get.height * 0.24,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage(ImageConstant.cardBgImg),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              ImageConstant.visaImg,
              width: Get.width * 0.15,
            ),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          const Text(
            '5643 7897 8976 3422',
            style: TextStyle(
                color: ColorLight.black,
                fontSize: 20,
                fontFamily: fontType,
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: Get.height * 0.035,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strCardHolderName,
                    style: TextStyle(
                      color: ColorLight.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: fontType,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Usama Shafique',
                    style: TextStyle(
                      color: ColorLight.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: fontType,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strExpiry,
                    style: TextStyle(
                      color: ColorLight.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: fontType,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '12/04',
                    style: TextStyle(
                      color: ColorLight.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: fontType,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              Image.asset(
                ImageConstant.chipIcon,
                width: Get.width * 0.1,
              )
            ],
          ),
        ],
      ),
    );
  }

  buildForm(BuildContext context) {
    return Form(
      key: addNewCardController.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.04,
          ),
          TextFormField(
            controller: addNewCardController.nameController.value,
            validator: (value) {
              if (value == null || value.trim() == '') {
                return 'Please Enter value';
              }
              return null;
            },
            style: TextStyle(
                fontSize: Get.height * 0.017,
                color: ColorLight.white,
                fontFamily: fontType),
            decoration: InputDecoration(
                filled: true,
                hintText: strCardHolderName,
                contentPadding: EdgeInsets.only(
                    left: Get.width * 0.06,
                    top: Get.height * 0.018,
                    bottom: Get.height * 0.018),
                hintStyle: TextStyle(
                    fontFamily: fontType,
                    fontSize: Get.height * 0.017,
                    fontWeight: FontWeight.w500,
                    color: ColorLight.white),
                fillColor: textFieldColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12))),
          ),
          SizedBox(
            height: Get.height * 0.025,
          ),
          TextFormField(
            controller: addNewCardController.cardNumberController.value,
            validator: (value) {
              RegExp visaRegex = RegExp(r'^4[0-9]{3}\s?[0-9]{4}\s?[0-9]{4}\s?[0-9]{4}$');
              RegExp mastercardRegex = RegExp(r'^5[1-5][0-9]{2}\s?[0-9]{4}\s?[0-9]{4}\s?[0-9]{4}$');


              if (!visaRegex.hasMatch(value!) &&
                  !mastercardRegex.hasMatch(value)) {
                return 'Please enter a valid Visa or Mastercard number';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberInputFormatter(),
            ],
            style: TextStyle(
                fontSize: Get.height * 0.017,
                color: ColorLight.white,
                fontFamily: fontType),
            decoration: InputDecoration(
                filled: true,
                hintText: strCardNo,
                contentPadding: EdgeInsets.only(
                    left: Get.width * 0.06,
                    top: Get.height * 0.018,
                    bottom: Get.height * 0.018),
                hintStyle: TextStyle(
                    fontFamily: fontType,
                    fontSize: Get.height * 0.017,
                    fontWeight: FontWeight.w500,
                    color: ColorLight.white),
                fillColor: textFieldColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12))),
          ),
          // SizedBox(
          //   height: Get.height * 0.025,
          // ),
          //
          // TextFormField(
          //   controller: addNewCardController.cardNumberController.value,
          //   validator: (value) {
          //     RegExp visaRegex = RegExp(r'^4[0-9]{12}(?:[0-9]{3})?$');
          //     RegExp mastercardRegex = RegExp(r'^5[1-5][0-9]{14}$');
          //
          //     if (!visaRegex.hasMatch(value!) &&
          //         !mastercardRegex.hasMatch(value)) {
          //       return 'Please enter a valid Visa or Mastercard number';
          //     }
          //     return null;
          //   },
          //   keyboardType: TextInputType.number,
          //   style: TextStyle(
          //       fontSize: Get.height * 0.017,
          //       color: ColorLight.white,
          //       fontFamily: fontType),
          //   decoration: InputDecoration(
          //       filled: true,
          //       hintText: strCardNo,
          //       contentPadding: EdgeInsets.only(
          //           left: Get.width * 0.06,
          //           top: Get.height * 0.018,
          //           bottom: Get.height * 0.018),
          //       hintStyle: TextStyle(
          //           fontFamily: fontType,
          //           fontSize: Get.height * 0.017,
          //           fontWeight: FontWeight.w500,
          //           color: ColorLight.white),
          //       fillColor: textFieldColor,
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30.0),
          //           borderSide: const BorderSide(color: Colors.black12)),
          //       focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30.0),
          //           borderSide: const BorderSide(color: Colors.black12)),
          //       enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(30.0),
          //           borderSide: const BorderSide(color: Colors.black12))),
          // ),
          SizedBox(
            height: Get.height * 0.025,
          ),
          TextFormField(
            controller: addNewCardController.cardExpiryController.value,
            validator: (value) {
              RegExp expRegex = RegExp(r'^(0[1-9]|1[0-2])\/?([0-9]{2})$');

              if (!expRegex.hasMatch(value!)) {
                return 'Please enter a valid expiry date in MM/YY format';
              }
              return null;
            },
            keyboardType: TextInputType.datetime,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
              ExpiryDateInputFormatter(),
            ],
            style: TextStyle(
                fontSize: Get.height * 0.017,
                color: ColorLight.white,
                fontFamily: fontType),
            decoration: InputDecoration(
                filled: true,
                hintText: strExpiry,
                contentPadding: EdgeInsets.only(
                    left: Get.width * 0.06,
                    top: Get.height * 0.018,
                    bottom: Get.height * 0.018),
                hintStyle: TextStyle(
                    fontFamily: fontType,
                    fontSize: Get.height * 0.017,
                    fontWeight: FontWeight.w500,
                    color: ColorLight.white),
                fillColor: textFieldColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12))),
          ),
          SizedBox(
            height: Get.height * 0.025,
          ),
          TextFormField(
            controller: addNewCardController.cvvController.value,
            validator: (value) {
              if (value == null || value
                  .trim()
                  .length != 3) {
                return 'Please enter a valid CVV';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            style: TextStyle(
                fontSize: Get.height * 0.017,
                color: ColorLight.white,
                fontFamily: fontType),
            decoration: InputDecoration(
                filled: true,
                hintText: strCvv,
                contentPadding: EdgeInsets.only(
                    left: Get.width * 0.06,
                    top: Get.height * 0.018,
                    bottom: Get.height * 0.018),
                hintStyle: TextStyle(
                    fontFamily: fontType,
                    fontSize: Get.height * 0.017,
                    fontWeight: FontWeight.w500,
                    color: ColorLight.white),
                fillColor: textFieldColor,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black12))),
          ),
        ],
      ),
    );
  }

  buildAddCard() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Checkbox(
                  value: addNewCardController.setAsDefault.value,
                  onChanged: (value) {
                    addNewCardController.setAsDefault.value = value!;
                  },
                  activeColor: appPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  checkColor: ColorLight.white,
                ),
              ),
              const Text(
                strSetAsDefault,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: fontType,
                    fontWeight: FontWeight.w500,
                    color: ColorLight.black),
              )
            ],
          ),
          customSubmitBtn(
              text: strAddCard, voidCallback: () {addNewCardController.goToSummary();}, width: Get.width)
        ],
      ),
    );
  }
}


class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = newValue.text;
    newText = newText.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      int nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != newText.length) {
        buffer.write(' ');
      }
    }

    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}


class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = newValue.text;
    newText = newText.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(newText[i]);
    }

    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
