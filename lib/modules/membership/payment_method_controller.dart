import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/membership/summary_view.dart';
import 'package:s_box/modules/membership/add_new_card_view.dart';
import 'package:s_box/modules/membership/membership_controller.dart';

import '../../extras/constant/shared_pref_constant.dart';

class PaymentMethodController extends GetxController {
  RxInt selectedValue = 0.obs;
  var membership = Membership(title: '', user_id: '', price: 0, discount: '').obs;
  RxList<dynamic> cards = <Map<String, dynamic>>[].obs;
  var storage = GetStorage();

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
    final selectedCard = cards[selectedValue.value];
    Get.to(SummaryView(), arguments: {'membership': membership.value, 'card': selectedCard});
  }
}
