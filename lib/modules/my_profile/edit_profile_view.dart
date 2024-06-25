import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/my_profile/edit_profile_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../../extras/constant/common_validation.dart';
import '../../extras/constant/string_constant.dart';

class EditProfileView extends StatelessWidget {
  final editProfileController = Get.put(EditProfileController());
  EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        backgroundColor: ColorLight.black,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Colors.white,)),
        title: const Text(
          strEditProfile, style: TextStyle(color: Colors.white),
        ),
        titleTextStyle: const TextStyle(
          color: ColorLight.black,
          fontWeight: FontWeight.w700,
          fontFamily: fontType,
          fontSize: 18.0,
        ),
      ),
      body: SafeArea(
        child: Scaffold(
          backgroundColor: ColorLight.black,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
              decoration: BoxDecoration(
                  color: ColorLight.black,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildImage(),
                  buildFormContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildImage() {
    return Obx(() {
      return GestureDetector(
        onTap: () => editProfileController.pickImage(),
        child: Container(
          width: Get.width * 0.3,
          height: Get.height * 0.15,
          margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: editProfileController.selectedImage.value != null
                  ? DecorationImage(
                  image: FileImage(editProfileController.selectedImage.value!),
                  fit: BoxFit.cover)
                  : const DecorationImage(
                  image: AssetImage(ImageConstant.imgMembership),
                  fit: BoxFit.cover),
              border: Border.all(color: ColorLight.white, width: 2.0)),
          alignment: Alignment.center,
          child: editProfileController.selectedImage.value == null
              ? Image.asset(
            ImageConstant.camera,
            width: 40,
          )
              : null,
        ),
      );
    });
  }

  buildFormContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05, vertical: Get.height * 0.04),
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildForm(),
        ],
      ),
    );
  }

  buildForm() {
    return Form(
        key: editProfileController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              style: TextStyle(
                  fontSize: Get.height * 0.017,
                  color: ColorLight.white,
                  fontFamily: fontType),
              controller: editProfileController.nameCont.value,
              cursorColor: ColorLight.white,
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Please Enter Name';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: strFirstName,
                  filled: true,
                  hintStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.w500,
                      color: ColorLight.white),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.07,
                      vertical: Get.height * 0.018),
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
              style: TextStyle(
                  fontSize: Get.height * 0.017,
                  color: ColorLight.white,
                  fontFamily: fontType),
              controller: editProfileController.lastNameCont.value,
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Please Enter Name';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: strLastName,
                  hintStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.w500,
                      color: ColorLight.white),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.07,
                      vertical: Get.height * 0.018),
                  filled: true,
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
              style: TextStyle(
                  fontSize: Get.height * 0.017,
                  color: ColorLight.white,
                  fontFamily: fontType),
              controller: editProfileController.usernameCont.value,
              validator: (value) {
                if (value == null || value.trim() == '') {
                  return 'Please Enter username';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: strUsername,
                  hintStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.w500,
                      color: ColorLight.white),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.07,
                      vertical: Get.height * 0.018),
                  fillColor: textFieldColor,
                  filled: true,
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
              style: TextStyle(
                  fontSize: Get.height * 0.016,
                  color: ColorLight.white,
                  fontFamily: fontType),
              controller: editProfileController.emailCont.value,
              validator: (value) {
                if (!isValidEmail(value ?? '')) {
                  return errorValidEmail;
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: strEmail,
                  hintStyle: TextStyle(
                      fontFamily: fontType,
                      fontSize: Get.height * 0.017,
                      fontWeight: FontWeight.w500,
                      color: ColorLight.white),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.07,
                      vertical: Get.height * 0.018),
                  fillColor: textFieldColor,
                  filled: true,
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
            SizedBox(
              height: Get.height * 0.01,
            ),
            customSubmitBtn(
                text: strSaveChanges, voidCallback: () { editProfileController.updateProfile(); }, width: Get.width)
          ],
        ));
  }

  buildLogo() {
    return Container(
      width: Get.width * 0.5,
      margin: EdgeInsets.only(top: Get.height * 0.075),
      child: Image.asset(
        ImageConstant.appLogo,
      ),
    );
  }
}
