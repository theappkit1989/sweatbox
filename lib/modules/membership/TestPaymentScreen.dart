import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentService {
  final String _accessToken = 'OGFjN2E0Yzg4ZmViODM2ZDAxOGZlZDA5OGY0MDAyNWV8VDlTajY4N0NaZzhHaE1TQQ==';
  final String _entityId = '8ac7a4c88feb836d018fed0b84160266';
  final String _host = 'https://eu-test.oppwa.com/';

  Future<int> makePayment(String amount, String currency, String paymentBrand, String cardNumber, String holder, String expiryMonth, String expiryYear, String cvv) async {
    final url = Uri.parse('${_host}v1/checkouts');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'entityId': _entityId,
        'amount': amount,
        'currency': currency,
        'paymentBrand': paymentBrand,
        'card.number': cardNumber,
        'card.holder': holder,
        'card.expiryMonth': expiryMonth,
        'card.expiryYear': expiryYear,
        'card.cvv': cvv,
        'paymentType': "DB",
        'shopperResultUrl': "http://13.51.255.89",
      },
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      // return jsonDecode(response.body);
      return response.statusCode;
    } else {

      throw Exception('Failed to make payment ${response.body}');
    }
  }


  String parseException(String exception) {
    try {
      // Extract JSON part from the exception string
      final jsonString = exception.substring(exception.indexOf('{'));
      final Map<String, dynamic> errorResponse = json.decode(jsonString);

      // Extract relevant error details
      final String errorCode = errorResponse['result']['code'];
      final String errorDescription = errorResponse['result']['description'];
      final List<dynamic> parameterErrors = errorResponse['result']['parameterErrors'];

      if (parameterErrors.isNotEmpty) {
        final String parameterName = parameterErrors[0]['name'];
        if (parameterName == 'card.number') {
          return 'Card number is invalid';
        } else if (parameterName == 'card.expiry') {
          return 'Card expiry date is invalid';
        } else if (parameterName == 'card.cvv') {
          return 'Card CVV is invalid';
        } else {
          return 'Invalid parameter: $parameterName';
        }
      } else {
        return errorDescription;
      }
    } catch (e) {
      // If parsing fails, return a generic error message
      return 'An error occurred. Please try again.';
    }
  }

}


class PaymentController extends GetxController {
  final PaymentService paymentService = PaymentService();
  var isLoading = false.obs;
  var paymentResult = {}.obs;

  final amountController = TextEditingController();
  final cardNumberController = TextEditingController();
  final holderController = TextEditingController();
  final expiryMonthController = TextEditingController();
  final expiryYearController = TextEditingController();
  final cvvController = TextEditingController();

  void makePayment() async {
    isLoading.value = true;
    try {
      final result = await paymentService.makePayment(
        amountController.text,
        'GBP', // Specify your currency
        'VISA', // Specify your card type
        cardNumberController.text,
        holderController.text,
        expiryMonthController.text,
        expiryYearController.text,
        cvvController.text,
      );
      // paymentResult.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Payment failed: ${e}',colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}


class PaymentScreen extends StatelessWidget {
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: paymentController.amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: paymentController.cardNumberController,
              decoration: InputDecoration(labelText: 'Card Number'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: paymentController.holderController,
              decoration: InputDecoration(labelText: 'Card Holder'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: paymentController.expiryMonthController,
                    decoration: InputDecoration(labelText: 'Expiry Month'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: paymentController.expiryYearController,
                    decoration: InputDecoration(labelText: 'Expiry Year'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            TextField(
              controller: paymentController.cvvController,
              decoration: InputDecoration(labelText: 'CVV'),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() => paymentController.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                paymentController.makePayment();
              },
              child: Text('Make Payment'),
            )),
            SizedBox(height: 20),
            Obx(() {
              if (paymentController.paymentResult.isNotEmpty) {
                return Text('Payment Result: ${paymentController.paymentResult}');
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }
}
