import 'package:get/get.dart';
import 'package:s_box/modules/massage_booking/massage_payment_method_view.dart';
import 'package:s_box/modules/membership/payment_method_view.dart';

import 'massage_controller.dart';

class MassageAndEntranceController extends GetxController{
  var massage = Massage(title: '', subtitle: '', price: 0,).obs;
  RxString selectedDate=''.obs;
  RxString selectedtime=''.obs;
  RxString selectedduration=''.obs;
  List<Membership> memberships = [
    Membership(title: '24 hr Pass', price: 23, discount: '', user_id: ''),
    Membership(title: '48 hr Pass', price: 28, discount: 'Popular', user_id: ''),
    Membership(title: 'Weekly Pass', price: 50, discount: '', user_id: ''),
    Membership(title: '25 & Under', price: 15, discount: 'Valid photo ID', user_id: ''),
    Membership(title: 'One Month', price: 95, discount: '', user_id: ''),
    Membership(title: 'Twelve Months', price: 950, discount: '', user_id: ''),
  ];
  List<String> membershipTitleList = ['24 hr Pass ','48 hr Pass','Weekly Pass','25 & Under','One Month','Twelve Months'];
  List<String> membershipSubTitleList = ['£23','£28','£50','£15*','£95','£950'];
  List<RxBool> isSelected = [false.obs,false.obs,false.obs,false.obs,false.obs,false.obs];
  RxInt selectedValue = 6.obs;

  void goToPaymentMethod() {
    if(selectedValue.value==6){
      print("not selected");
      Get.to(MassagePaymentMethodView(), arguments: [massage.value,selectedDate.value,selectedtime.value,massage.value.subtitle,"1"]);
    }else{
      Get.to(MassagePaymentMethodView(), arguments: [massage.value,selectedDate.value,selectedtime.value,massage.value.subtitle,"2",memberships[selectedValue.value]]);
      print("membership selected${memberships[selectedValue.value].title}");
    }
    // Membership selectedMembership = memberships[selectedValue.value];
    // Get.to(PaymentMethodView(), arguments: selectedMembership);
  }
  List<String> trailing = ['Save 40%','Save 40%','Save 20%','Valid photo ID','Save 45%','Save 50%'];

// void goToPaymentMethod(){
//   Get.to(PaymentMethodView());
// }
}
class Membership {
  final String title;
  final String user_id;
  final int price;
  final String? activeTime;
  final String? expireTime;
  final String discount;

  Membership({required this.title,required this.user_id, required this.price,  this.activeTime,  this.expireTime, required this.discount});
}