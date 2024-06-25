import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/modules/splash/controller/splash_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SplashView extends StatelessWidget {
  final loginController = Get.put(SplashController());
  SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> widgetList = [];
    var child = Scaffold(
        backgroundColor: Colors.black,
        body:  Center(
          child: SizedBox(
            child: Image.asset(ImageConstant.splashIcon, width: Get.width*0.6,
              height: Get.height*0.11,fit: BoxFit.fill,),
          ),
        ));
    widgetList.add(child);
    final modal = Obx(
          () => loginController.showLoader.value
          ?  const Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          Center(
            child: CircularProgressIndicator(
              valueColor:
              AlwaysStoppedAnimation<Color>(ColorLight.colorPrimary),
            ),
          ),
        ],
      )
          : const SizedBox(),
    );
    widgetList.add(modal);
    return Stack(children: widgetList);
  }

}
