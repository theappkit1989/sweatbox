import 'package:get/get.dart';
import 'package:s_box/modules/massage_booking/payment_method_view.dart';

class GetAccessController extends GetxController{

  List<String> membershipTitleList = ['24 hr Pass ','48 hr Pass','Weekly Pass','25 & Under','One Month','Twelve Months'];
  List<String> membershipSubTitleList = ['£23','£28','£50','£15*','£95','£950'];
  List<String> trailing = ['Save 40%','Save 40%','Save 20%','Valid photo ID','Save 45%','Save 50%'];
  RxInt selectedValue = 0.obs;

  void goToPaymentMethod(){
    Get.to(MassagePaymentMethodView());
  }



}