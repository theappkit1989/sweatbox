import 'package:get/get.dart';
import 'package:s_box/modules/massage_booking/date_time_view.dart';
import 'package:s_box/modules/massage_booking/payment_method_view.dart';

class MassageController extends GetxController{

  RxInt selectedValue = 0.obs;
  List<Massage> massages = [
    Massage(title: 'Full Body Massage ', price: 40, subtitle: '30'),
    Massage(title: 'Full Body Massage ', price: 60, subtitle: '60'),
    Massage(title: 'Full Body Massage ',price: 80,subtitle: '90'),

  ];

  void goToPaymentMethod() {
    Massage selectedMassage = massages[selectedValue.value];
    Get.to(DateTimeView(), arguments: [selectedMassage]);
  }

}

class Massage {
   String title;
   String subtitle;
   String? date;
   String? time;
   String? duration;
   int price;

  Massage({
    required this.title,
    this.date,
    this.time,
    this.duration,
    required this.subtitle,
    required this.price,
  });
}