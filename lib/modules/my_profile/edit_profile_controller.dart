import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../extras/constant/shared_pref_constant.dart';
import '../../services/repo/common_repo.dart';
import '../../themes/loading_dialofg.dart';
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
    token = storage.read(userToken);
    user_id = storage.read(userid).toString();
    nameCont.value.text = storage.read(firstName);
    lastNameCont.value.text = storage.read(lastName);
    usernameCont.value.text = storage.read(userName);
    emailCont.value.text = storage.read(userEmail);
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
        var homeCont = Get.find<MyProfileController>();
        homeCont.onInit();
        Get.back();
      } else {
        _dismissDialog();
        Get.snackbar("Error", _response.message ?? 'Something went wrong!');
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
