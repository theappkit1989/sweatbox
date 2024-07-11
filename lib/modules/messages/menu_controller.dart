import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_images.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/messages/block_user_view.dart';
import 'package:s_box/modules/messages/delete_user_view.dart';
import 'package:s_box/modules/messages/report_user_view.dart';

import '../../services/commonModels/freshFacesResponse.dart';

class DotMenuController extends GetxController{
  var  user = Users().obs;
  List<String> icons = [ImageConstant.delete,ImageConstant.block,ImageConstant.report];
  List<String> title = [strDelete,strBlock,strReport];

  void goToDeleteUser(){
    Get.to(DeleteUserView(),arguments:{'user':user.value});
  }

  void goToBlockUser(){
    Get.to(BlockUserView());
  }

  void goToReportUser(){
    Get.to(ReportUserView());
  }

}