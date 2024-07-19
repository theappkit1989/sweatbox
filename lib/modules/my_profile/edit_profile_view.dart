import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/my_profile/edit_profile_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import '../../extras/constant/AutoCapitalizeTextInputFormatter.dart';
import '../../extras/constant/app_color.dart';
import '../../extras/constant/app_constant.dart';
import '../../extras/constant/app_images.dart';
import '../../extras/constant/common_validation.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../../services/api/api_endpoint.dart';

class EditProfileView extends StatelessWidget {
  final editProfileController = Get.put(EditProfileController());
  EditProfileView({super.key});
  var storage = GetStorage();
  String userImage = '';

  @override
  Widget build(BuildContext context) {
    storage.writeIfNull(image, '');
    userImage = storage.read(image);
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
                  buildImage(userImage),
                  buildFormContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildImage(String userImage) {
    return Obx(() {
      return GestureDetector(
        onTap: () => editProfileController.pickImage(),
        // child: Align(
        //   alignment: Alignment.topCenter,
        //   child: SizedBox(
        //       child: editProfileController.selectedImage.value!=null?Container(
        //           width: Get.width * 0.3,
        //           height: Get.height * 0.15,
        //           margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
        //           decoration: BoxDecoration(
        //               shape: BoxShape.circle,
        //               image: editProfileController.selectedImage.value != null
        //                   ? DecorationImage(
        //                   image: FileImage(editProfileController.selectedImage.value!),
        //                   fit: BoxFit.cover)
        //                   :  DecorationImage(
        //                   image: NetworkImage("${ApiEndpoint.baseUrlImage+editProfileController.userImage.value}"),
        //                   fit: BoxFit.cover),
        //               border: Border.all(color: ColorLight.white, width: 2.0)),
        //           alignment: Alignment.center,
        //           child: editProfileController.selectedImage.value == null
        //               ? Image.asset(
        //             ImageConstant.camera,
        //             width: 40,
        //           )
        //               : null,
        //         ):ClipOval(
        //           child: Container(
        //           width: Get.width * 0.25,
        //           height: Get.height * 0.15,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //
        //             border: Border.all(
        //               color: Colors.white24,
        //               // Set the border color here
        //               width: 1.0, // Set the border width here
        //             ),
        //           ),
        //
        //           child: Image.network(
        //             "${ApiEndpoint.baseUrlImage+editProfileController.userImage.value}",
        //             width: Get.width * 0.3,
        //             height: Get.height * 0.15,
        //             fit: BoxFit.cover,
        //             loadingBuilder: (BuildContext context,
        //                 Widget child,
        //                 ImageChunkEvent? loadingProgress) {
        //               if (loadingProgress == null) {
        //                 return child;
        //               } else {
        //                 return Center(
        //                   child: CircularProgressIndicator(
        //                     color: Colors.amber,
        //                     value:
        //                     loadingProgress.expectedTotalBytes !=
        //                         null
        //                         ? loadingProgress
        //                         .cumulativeBytesLoaded /
        //                         (loadingProgress
        //                             .expectedTotalBytes ??
        //                             1)
        //                         : null,
        //                   ),
        //                 );
        //               }
        //             },
        //             errorBuilder: (context, error, stackTrace) {
        //               // If there is an error loading the network image, show a placeholder image
        //               return Center(
        //                 child: Icon(
        //                   Icons.person,
        //                   size: 50.0,
        //                   color: appPrimaryColor, // Color of the person icon
        //                 ),
        //               ); // You can replace this with your custom error widget
        //             },
        //           ),
        //
        //           //
        //           // child: CircleAvatar(
        //           //   radius: 50.0,
        //           //   backgroundImage: Image.network("${logo}",
        //           //
        //           //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        //           //       if (loadingProgress == null) {
        //           //         return child;
        //           //       } else {
        //           //         return Center(
        //           //           child: CircularProgressIndicator(
        //           //             value: loadingProgress.expectedTotalBytes != null
        //           //                 ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
        //           //                 : null,
        //           //           ),
        //           //         );
        //           //       }
        //           //     },
        //           //     errorBuilder: (context, error, stackTrace) {
        //           //       // If there is an error loading the network image, show a placeholder image
        //           //       return  Center(
        //           //         child: Icon(
        //           //           Icons.person,
        //           //           size: 50.0,
        //           //           color: AppColors.color_primary, // Color of the person icon
        //           //         ),
        //           //       );// You can replace this with your custom error widget
        //           //     },),
        //           //   backgroundColor: Colors.transparent,
        //           // ),
        //                         ),
        //         )),
        // ),
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
                  : editProfileController.userImage.value!=''? DecorationImage(
                  image: NetworkImage("${ApiEndpoint.baseUrlImage+editProfileController.userImage.value}"),
                  fit: BoxFit.cover):DecorationImage(
                  image: AssetImage(ImageConstant.placeholderImage),
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
              inputFormatters: [AutoCapitalizeTextInputFormatter()],
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
              inputFormatters: [AutoCapitalizeTextInputFormatter()],
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
