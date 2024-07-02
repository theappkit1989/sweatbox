import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:s_box/modules/my_profile/my_profile_view.dart';
import 'dart:io';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/api/api_endpoint.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
import '../home_screen/home_controller.dart';
import 'my_profile_controller.dart';

class EditProfileController extends GetxController {
  var storage = GetStorage();
  String token = '';
  String user_id = '';

  final formKey = GlobalKey<FormState>();
  var nameCont = TextEditingController().obs;
  var lastNameCont = TextEditingController().obs;
  var usernameCont = TextEditingController().obs;
  var emailCont = TextEditingController().obs;
  var passCont = TextEditingController().obs;
  var cPassCont = TextEditingController().obs;
  RxString userImage=''.obs;
  var emailFocus = FocusNode();
  var passFocus = FocusNode();
  var cPassFocus = FocusNode();
  var selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    storage.writeIfNull(userToken, '');
    storage.writeIfNull(userid, '');
    storage.writeIfNull(firstName, '');
    storage.writeIfNull(lastName, '');
    storage.writeIfNull(userName, '');
    storage.writeIfNull(userEmail, '');
    storage.writeIfNull(image, '');
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();
    nameCont.value.text = storage.read(firstName);
    lastNameCont.value.text = storage.read(lastName);
    usernameCont.value.text = storage.read(userName);
    emailCont.value.text = storage.read(userEmail);
    userImage.value=storage.read(image);
    // print("token is $token and id is $user_id");
    super.onInit();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  updateProfile() async {
    FocusScope.of(Get.context!).unfocus();

    if (formKey.currentState!.validate()) {
      _showLoadingDialog();
      // print(' id is ${user_id.toString()}');
      var _response = await ApiController().updateProfile(

        user_id.toString(),
        nameCont.value.text,
        lastNameCont.value.text,
        usernameCont.value.text,
        emailCont.value.text,
        token.toString(),
        image: selectedImage.value,
      );
      if (_response.status == true) {
        _dismissDialog();

        storage.write(userEmail, emailCont.value.text);
        storage.write(firstName, nameCont.value.text ?? '');
        storage.write(lastName, lastNameCont.value.text ?? '');
        storage.write(userName, usernameCont.value.text ?? '');
        storage.write(image,_response.user?.image ?? '');

        print("message is ${_response.message}");
        // Get.snackbar("Success", _response.message ?? '');
        // var homecont= Get.find<MainScreenController>();
        // homecont.tabIndex.value=3;
        // homecont.update();
        // var bookingcont= Get.find<MyProfileController>();
        // bookingcont.imagee.value = '${ApiEndpoint.baseUrlImage + _response.user!.image!} ' ;
        // bookingcont.onInit();
        // bookingcont.update();
        // print("object${Get.find<MainScreenController>().tabIndex.value}");
        // Get.close(0);


        var homeCont = Get.find<MyProfileController>();

        homeCont.onInit();
        homeCont.imagee.value='${ApiEndpoint.baseUrlImage + _response.user!.image!}';
        homeCont.update();
        Get.back();
      } else {
        _dismissDialog();
        Get.snackbar("Sweatbox", _response.message ?? 'Something went wrong!',colorText: Colors.white);
      }
    }
  }

  void _showLoadingDialog() {
    CustomLoadingDialog.showLoadingDialog();
  }

  void _dismissDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
