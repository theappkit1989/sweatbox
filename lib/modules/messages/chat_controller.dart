import 'package:get/get.dart';
import 'package:s_box/modules/messages/menu_view.dart';

class ChatController extends GetxController{

  void goToMenu(){
    Get.to(MenuView());
  }

}