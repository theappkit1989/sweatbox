import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:s_box/modules/membership/payment_method_controller.dart';

class AddNewCardController extends GetxController {
 var nameController = TextEditingController().obs;
 var cardNumberController = TextEditingController().obs;
 var cardExpiryController = TextEditingController().obs; // Combined expiry field
 var cvvController = TextEditingController().obs;

 final formKey = GlobalKey<FormState>();
 RxBool setAsDefault = true.obs;
 final storage = GetStorage();

 Future<void> saveCard() async {
  if (formKey.currentState!.validate()) {
   String expiryDate = cardExpiryController.value.text;
   List<String> expiryParts = expiryDate.split('/');
   String expiryMonth = expiryParts[0];
   String expiryYear = '20' + expiryParts[1]; // Assuming 2-digit year format

   Map<String, dynamic> newCard = {
    'name': nameController.value.text,
    'number': cardNumberController.value.text,
    'expiryMonth': expiryMonth,
    'expiryYear': expiryYear,
    'cvv': cvvController.value.text,
    'default': setAsDefault.value,
   };
   List<dynamic> cards = storage.read<List<dynamic>>('cards') ?? [];
   cards.add(newCard);
   storage.write('cards', cards);
   // Notify that a new card has been added
   Get.find<PaymentMethodController>().loadSavedCards();
   Get.back();
  }
 }


 void goToSummary() {
  saveCard();
 }
}
