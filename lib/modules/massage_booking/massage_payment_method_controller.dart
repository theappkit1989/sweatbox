import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pay/pay.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/modules/massage_booking/massage_summary_view.dart';
import 'package:s_box/modules/massage_booking/add_new_card_view.dart';
import 'package:s_box/modules/massage_booking/testpaymentService/PaymentService.dart';


import '../../extras/constant/shared_pref_constant.dart';

class MassagePaymentMethodController extends GetxController {
  RxInt selectedValue = 0.obs;
  var massage = Massage(title: '', subtitle: '', price: 0,).obs;
  RxString selectedDate=''.obs;
  RxString selectedtime=''.obs;
  RxString selectedduration=''.obs;
  RxList<dynamic> cards = <Map<String, dynamic>>[].obs;
  var storage = GetStorage();

  @override

  @override
  void onInit() {
    super.onInit();
    loadSavedCards();
  }

  Future<void> loadSavedCards() async {
    List<dynamic> cardList = storage.read<List<dynamic>>('cards') ?? [];
    if (cardList.isNotEmpty) {
      print('card number is ${cardList.length}');
      cards.value = List<Map<String, dynamic>>.from(cardList);
    } else {
      print('card length is ${cardList.length}');
    }
  }

  @override
  void onReady() {
    super.onReady();
    ever(cards, (_) {
      // Update the list when cards change
      loadSavedCards();
    });
  }

  // @override
  // void onResume() {
  //   super.on();
  //   loadSavedCards();
  // }

  void goToAddNewCard() {
    Get.to(AddNewCardView());
  }


  void goToSummary() {
    final paymentType = selectedValue.value == -1 ? 'Apple Pay' : selectedValue.value == -2 ? 'Google Pay' : 'Credit Card';
    print('card value is ${selectedValue.value}');
    if(selectedValue.value==0&&cards[selectedValue.value]==null){
      Get.snackbar("Error", "Select One Payment method");
    }else {
      if (selectedValue.value != -1) {
        if (selectedValue.value == -2) {
          final selectedCard = '';
          final Massage _massage = Massage(title: massage.value.title,
              subtitle: massage.value.subtitle,
              price: massage.value.price,
              date: selectedDate.toString(),
              time: selectedtime.toString(),
              duration: selectedduration.toString());
          // Pass the membership and card details to the SummaryView
          Get.to(MassageSummaryView(), arguments: {
            'massage': _massage,
            'card': selectedCard,
            'paymentType': paymentType,
          });
        } else {
          print("card valu is${cards[selectedValue.value]}");
          final selectedCard = cards[selectedValue.value];
          final Massage _massage = Massage(title: massage.value.title,
              subtitle: massage.value.subtitle,
              price: massage.value.price,
              date: selectedDate.toString(),
              time: selectedtime.toString(),
              duration: selectedduration.toString());
          // Pass the membership and card details to the SummaryView
          Get.to(MassageSummaryView(), arguments: {
            'massage': _massage,
            'card': selectedCard,
            'paymentType': paymentType,
          });
        }
      } else {
        final selectedCard = '';
        final Massage _massage = Massage(title: massage.value.title,
            subtitle: massage.value.subtitle,
            price: massage.value.price,
            date: selectedDate.toString(),
            time: selectedtime.toString(),
            duration: selectedduration.toString());
        // Pass the membership and card details to the SummaryView
        Get.to(MassageSummaryView(), arguments: {
          'massage': _massage,
          'card': selectedCard,
          'paymentType': paymentType,
        });
      }
    }



  }




}
