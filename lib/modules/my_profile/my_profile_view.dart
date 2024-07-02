import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/app_constant.dart';
import 'package:s_box/modules/my_profile/my_profile_controller.dart';
import 'package:s_box/services/commonModels/userAllData.dart';
import 'package:s_box/services/api/api_endpoint.dart';
import 'package:s_box/themes/colors/color_light.dart';

import '../../extras/constant/app_images.dart';
import '../../extras/constant/shared_pref_constant.dart';
import '../../extras/constant/string_constant.dart';
import '../commonWidgets/common.dart';

class MyProfileView extends StatelessWidget {
  final myProfileController = Get.put(MyProfileController());
  var storage = GetStorage();

  MyProfileView({super.key});

  String username = '';
  String useremail = '';
  String userImage = '';

  @override
  Widget build(BuildContext context) {
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    storage.writeIfNull(image, '');
    username = storage.read(userName);
    useremail = storage.read(userEmail);
    userImage = storage.read(image);

    print("image profile url is ${ApiEndpoint.baseUrlImage+userImage}");
    return Scaffold(
        backgroundColor: ColorLight.black,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: Get.height * 0.05),
              padding: EdgeInsets.only(
                  top: Get.height * 0.07,
                  bottom: Get.height * 0.06,
                  left: Get.width * 0.05,
                  right: Get.width * 0.05),
              decoration: BoxDecoration(
                color: ColorLight.black,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 10,),
                  buildUserDetails(username, useremail),
                  buildMembership(myProfileController.memberships.value),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => buildListTile(
                          title: myProfileController.titles[index],
                          icon: myProfileController.leading[index],
                          voidCallback: () => handleTileTap(index)),
                      itemCount: myProfileController.titles.length,
                      primary: true,
                      shrinkWrap: true,
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   alignment: Alignment.bottomRight,
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(color: ColorLight.white, width: 2.0),
            //       image: const DecorationImage(
            //           image: AssetImage(ImageConstant.massageImg))),
            //   width: Get.width * 0.275,
            //   height: Get.height * 0.1,
            //   margin: EdgeInsets.only(top: Get.height * 0.0),
            //   /*Container(
            //     width: Get.width * 0.1,
            //     padding: const EdgeInsets.all(5.0),
            //     decoration: BoxDecoration(
            //         color: appPrimaryColor,
            //         shape: BoxShape.circle,
            //         border: Border.all(color: ColorLight.white, width: 2.0)),
            //     child: Image.asset(ImageConstant.userEditIcon),
            //   ),*/
            // ),

      Obx(()=> Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  child: myProfileController.imagee.value!=''? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white24,
                        // Set the border color here
                        width: 1.0, // Set the border width here
                      ),
                    ),

                    child: ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey,
                        child: Image.network(
                          myProfileController.imagee.value,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context,
                              Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.amber,
                                  value:
                                  loadingProgress.expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      (loadingProgress
                                          .expectedTotalBytes ??
                                          1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // If there is an error loading the network image, show a placeholder image
                            return Center(
                              child: Icon(
                                Icons.person,
                                size: 50.0,
                                color: appPrimaryColor, // Color of the person icon
                              ),
                            ); // You can replace this with your custom error widget
                          },
                        ),
                      ),)


                    //
                    // child: CircleAvatar(
                    //   radius: 50.0,
                    //   backgroundImage: Image.network("${logo}",
                    //
                    //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    //       if (loadingProgress == null) {
                    //         return child;
                    //       } else {
                    //         return Center(
                    //           child: CircularProgressIndicator(
                    //             value: loadingProgress.expectedTotalBytes != null
                    //                 ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    //                 : null,
                    //           ),
                    //         );
                    //       }
                    //     },
                    //     errorBuilder: (context, error, stackTrace) {
                    //       // If there is an error loading the network image, show a placeholder image
                    //       return  Center(
                    //         child: Icon(
                    //           Icons.person,
                    //           size: 50.0,
                    //           color: AppColors.color_primary, // Color of the person icon
                    //         ),
                    //       );// You can replace this with your custom error widget
                    //     },),
                    //   backgroundColor: Colors.transparent,
                    // ),
                  ):Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: AssetImage(ImageConstant.imgMembership),
                          fit: BoxFit.cover),
                      border: Border.all(
                        color: Colors.white24,
                        // Set the border color here
                        width: 1.0, // Set the border width here
                      ),
                    ),)),
            ),)
          ],
        ));
  }

  void handleTileTap(int index) {
    switch (index) {
      case 0:
        myProfileController.goToEditProfile();
        break;
      case 1:
        myProfileController.goToUpdatePassword();
        break;
      case 2:
        myProfileController.rateApp();
        break;
      case 3:
        _showLogoutDialog();
        break;
      case 4:
        _showDeleteAccountDialog();
        break;
    }
  }

  void _showDeleteAccountDialog() {
    Get.defaultDialog(
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      onConfirm: () {
        myProfileController.deleteAccount();
        Get.back();
      },
    );
  }

  void _showLogoutDialog() {
    Get.defaultDialog(
      title: 'Are you sure? ',
      middleText: 'Are you sure you want to logout your account?',
      textCancel: 'Cancel',
      textConfirm: 'Log Out',
      confirmTextColor: Colors.white,
      onConfirm: () {
        myProfileController.logout();
        Get.back();
      },
    );
  }

  buildUserDetails(String username, String useremail) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        text(
            text: username,
            size: 18,
            fontWeight: FontWeight.w700,
            color: ColorLight.white),
        text(
            text: useremail,
            size: 13,
            fontWeight: FontWeight.w500,
            color: ColorLight.white),
      ],
    );
  }

  // buildMembership() {
  //   return Container(
  //     width: Get.width,
  //     decoration: BoxDecoration(
  //       color: yellowF5EA25,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     margin: EdgeInsets.symmetric(vertical: Get.height * 0.025),
  //     padding: EdgeInsets.symmetric(
  //         horizontal: Get.width * 0.05, vertical: Get.height * 0.0125),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Image.asset(
  //           ImageConstant.profileImg,
  //           width: Get.width * 0.18,
  //           height: Get.height * 0.1,
  //         ),
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               text(
  //                   text: '48 hours pass',
  //                   size: 15,
  //                   fontWeight: FontWeight.w700,
  //                   color: ColorLight.black),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Image.asset(
  //                     ImageConstant.clockBlack,
  //                     width: 24,
  //                   ),
  //                   SizedBox(
  //                     width: Get.width * 0.01,
  //                   ),
  //                   text(
  //                       text: '38:45:10 Sec',
  //                       size: 11,
  //                       fontWeight: FontWeight.w400,
  //                       color: ColorLight.black),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           width: Get.width * 0.02,
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: appPrimaryColor,
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           padding: EdgeInsets.symmetric(
  //               horizontal: Get.width * 0.03, vertical: Get.height * 0.01),
  //           child: text(
  //               text: strSeeDetails,
  //               size: 11,
  //               fontWeight: FontWeight.w600,
  //               color: ColorLight.white),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // Widget buildMembership() {
  //   return Obx(() {
  //     if (myProfileController.memberships.isEmpty) {
  //       return SizedBox.shrink(); // If no memberships, hide the section
  //     } else {
  //       return Container(
  //         width: Get.width,
  //         decoration: BoxDecoration(
  //           color: yellowF5EA25,
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         margin: EdgeInsets.symmetric(vertical: Get.height * 0.025),
  //         padding: EdgeInsets.symmetric(
  //           horizontal: Get.width * 0.05,
  //           vertical: Get.height * 0.0125,
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               myProfileController.servicesList.last.name??"",
  //               style: TextStyle(
  //                 color: ColorLight.black,
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //             ),
  //             SizedBox(height: Get.height * 0.01),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Image.asset(
  //                   ImageConstant.clockBlack,
  //                   width: 24,
  //                 ),
  //                 SizedBox(width: Get.width * 0.01),
  //                 Obx(() => Text(
  //                   myProfileController.countdownText.value,
  //                   style: TextStyle(
  //                     color: ColorLight.black,
  //                     fontSize: 11,
  //                     fontWeight: FontWeight.w400,
  //                   ),
  //                 )),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   });
  // }
  buildMembership(List<Membership> value) {
    if (myProfileController.memberships.isEmpty) {
      return SizedBox(height: Get.height*0.1,); // If no memberships, hide the section
    } else {

        return Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: yellowF5EA25,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.symmetric(vertical: Get.height * 0.025),
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05, vertical: Get.height * 0.0125),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // CircularProgressIndicator(
                  //   value: myProfileController.progress.value,
                  //   backgroundColor: Colors.grey,
                  //   valueColor: AlwaysStoppedAnimation<Color>(appPrimaryColor),
                  // ),
                  Image.asset(
                    ImageConstant.profileImg,
                    width: Get.width * 0.18,
                    height: Get.height * 0.1,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(
                        text: value.last.name ?? "",
                        size: 15,
                        fontWeight: FontWeight.w700,
                        color: ColorLight.black),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageConstant.clockBlack,
                          width: 24,
                        ),
                        SizedBox(width: Get.width * 0.01),
                        Obx(() {
                          return text(
                              text: myProfileController.countdownText.value,
                              size: 12,
                              fontWeight: FontWeight.w400,
                              color: ColorLight.black);
                        }),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        myProfileController.goToOrderDetails(myProfileController.memberships.last);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: appPrimaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.03,
                            vertical: Get.height * 0.01),
                        child: text(
                            text: strSeeDetails,
                            size: 11,
                            fontWeight: FontWeight.w600,
                            color: ColorLight.white),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        );
      }

  }

  buildListTile(
      {required String title,
      required String icon,
      required VoidCallback voidCallback}) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      child: ListTile(
        onTap: voidCallback,
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(icon),
        title: Text(
          title,
          style: const TextStyle(
            color: ColorLight.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: fontType,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: ColorLight.white,
          size: 15,
        ),
      ),
    );
  }
}
