import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentServiceApplePay {
  final String _accessToken = 'OGFjN2E0Yzg4ZmViODM2ZDAxOGZlZDA5OGY0MDAyNWV8VDlTajY4N0NaZzhHaE1TQQ==';
  final String _entityId = '8ac7a4c88feb836d018fed0b84160266';
  final String _host = 'https://eu-test.oppwa.com/';

  Future<Map<String, dynamic>> makePayment(String amount, String currency, String paymentBrand, String token) async {
    final url = Uri.parse('${_host}v1/payments');

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
        'paymentToken': token,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to make payment');
    }
  }
}
