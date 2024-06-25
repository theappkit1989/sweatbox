import 'package:get/get.dart';
import 'package:s_box/modules/home_screen/home_view.dart';
import 'package:s_box/modules/login/view/login_view.dart';
import 'package:s_box/modules/membership/membership_view.dart';

class PasswordUpdatedController extends GetxController{

  void goToHome(){
    Get.offAll(LoginView());
  }

}