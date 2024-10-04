import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

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

      throw Exception('Failed to make  payment ${response.body}');
    }
  }
  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    // Format the date and time using intl package
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    String formatted = formatter.format(now);
    return formatted;
  }
  Future<int> processPayment(String orderRef,String amount, String currency, String paymentBrand, String cardNumber, String holder, String expiryMonth, String expiryYear, String cvv) async {
    // final String cardNumber = "5590490202169114";
    // final String CardHolderName = "Muhammad Yasir Shahzad";
    // final String cardCvc = "467";
    // final String cardExpiryMonth = "07";
    // final String cardExpiryYear = "27";
    // final String orderNumber = "Payment ref D13";
    // final String currency = "GBP";
    // final String amountToCollect = "0.5";
    // final String secretKey = "ad3defe8-2c6a-4e0e-a866-6f67dfdfc1d6"; // Replace with your actual secret key
 final String cardNumberP = cardNumber;
    final String CardHolderName = holder;
    final String cardCvc = cvv;
    final String cardExpiryMonth = expiryMonth;
    final String cardExpiryYear = expiryYear;
    final String orderNumber = "${orderRef} ${getCurrentDateTime()}"  ;
    final String currency = "GBP";
    final String amountToCollect = amount;
    final String secretKey = "ad3defe8-2c6a-4e0e-a866-6f67dfdfc1d6"; // Replace with your actual secret key


    final Map<String, dynamic> paymentData =
    {
      "type": "Payment",
      "paymentMethodsToUse": ["debitcard"],
      "parameters": {

        "cardNumber": cardNumber,
        "CardHolderName": CardHolderName,

        "cardCvc": cardCvc,
        "cardExpiryMonth": cardExpiryMonth,
        "cardExpiryYear": cardExpiryYear
      },


      "order": {
        "orderNumber": orderNumber
      },
      "billingAddress" : {
        "firstName" : holder,
        "lastName" : '',
      },
      "currency": currency,
      "amountToCollect": amountToCollect
    };

    // Convert paymentData to JSON string
    final String jsonBody = json.encode(paymentData);

    // Concatenate the secret key and the JSON body
    final String dataToHash = secretKey + jsonBody;

    // Generate the SHA-512 hash
    final String sha512Hash = sha512.convert(utf8.encode(dataToHash)).toString();

    final url = 'https://gateway.cashflows.com/api/gateway/payment-jobs';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'configurationId': '240726117314217984',
        'Hash': sha512Hash,
      },
      body: jsonBody,
    );

    print(response.statusCode);
    if (response.statusCode == 201) {

      final responseData = json.decode(response.body);
      final actionUrl = responseData['links']['action']['url'];
      final returnUrlSuccess = responseData['data']['payments'][0]['attributes']['returnUrlSuccess'];
      final returnUrlFailed = responseData['data']['payments'][0]['attributes']['returnUrlFailed'];
      final returnUrlCancelled = responseData['data']['payments'][0]['attributes']['returnUrlCancelled'];
      print('action url is $actionUrl');
      _dismissDialog();
      final paymentResult = await Get.to(PaymentWebView(url: actionUrl, urlSuccess: returnUrlSuccess, urlFailed: returnUrlFailed, urlCancelled: returnUrlCancelled,));
      // SuccessPayment(actionUrl);
      if (paymentResult == 'success') {
        return 200;
        Get.snackbar('Success', 'Payment was successful');
      } else if (paymentResult == 'failed') {
        Get.snackbar('Failed', 'Payment failed');
        return 250;
      } else if (paymentResult == 'cancel') {
        return 260;
        Get.snackbar('Cancelled', 'Payment was cancelled');
      }


      return 0;
    } else
      _dismissDialog();
      print('Payment failed with status ${response.statusCode}: ${response.body}');
 return response.statusCode;

    }
  Future<int> processPaymentApplepay(String orderRef,String amount, String currency, String paymentBrand, String cardNumber, String holder, String expiryMonth, String expiryYear, String cvv) async {
    // final String cardNumber = "5590490202169114";
    // final String CardHolderName = "Muhammad Yasir Shahzad";
    // final String cardCvc = "467";
    // final String cardExpiryMonth = "07";
    // final String cardExpiryYear = "27";
    // final String orderNumber = "Payment ref D13";
    // final String currency = "GBP";
    // final String amountToCollect = "0.5";
    // final String secretKey = "ad3defe8-2c6a-4e0e-a866-6f67dfdfc1d6"; // Replace with your actual secret key
 final String cardNumberP = cardNumber;
    final String CardHolderName = holder;
    final String cardCvc = cvv;
    final String cardExpiryMonth = expiryMonth;
    final String cardExpiryYear = expiryYear;
    final String orderNumber = "${orderRef} ${getCurrentDateTime()}"  ;
    final String currency = "GBP";
    final String amountToCollect = amount;
    final String secretKey = "ad3defe8-2c6a-4e0e-a866-6f67dfdfc1d6"; // Replace with your actual secret key



    final Map<String, dynamic> paymentData =
    {"amountToCollect": amountToCollect,
      "currency": "GBP",

      "locale": "en_GB",
      "order": {
        "orderNumber":orderNumber,
        "billingAddress" : {
          "firstName" : holder,
          "lastName" : '',

        },

      }
    };
    // {
    //   "type": "Payment",
    //   "paymentMethodsToUse": ["debitcard"],
    //   "parameters": {
    //
    //     "cardNumber": cardNumber,
    //     "CardHolderName": CardHolderName,
    //
    //     "cardCvc": cardCvc,
    //     "cardExpiryMonth": cardExpiryMonth,
    //     "cardExpiryYear": cardExpiryYear
    //   },
    //
    //
    //   "order": {
    //     "orderNumber": orderNumber
    //   },
    //   "currency": currency,
    //   "amountToCollect": amountToCollect
    // };

    // Convert paymentData to JSON string
    final String jsonBody = json.encode(paymentData);

    // Concatenate the secret key and the JSON body
    final String dataToHash = secretKey + jsonBody;

    // Generate the SHA-512 hash
    final String sha512Hash = sha512.convert(utf8.encode(dataToHash)).toString();

    final url = 'https://gateway.cashflows.com/api/gateway/payment-jobs';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'configurationId': '240726117314217984',
        'Hash': sha512Hash,
      },
      body: jsonBody,
    );

    print(response.statusCode);
    if (response.statusCode == 201) {

      final responseData = json.decode(response.body);
      final actionUrl = responseData['links']['action']['url'];
      final returnUrlSuccess = responseData['data']['payments'][0]['attributes']['returnUrlSuccess'];
      final returnUrlFailed = responseData['data']['payments'][0]['attributes']['returnUrlFailed'];
      final returnUrlCancelled = responseData['data']['payments'][0]['attributes']['returnUrlCancelled'];
      print('action url is $actionUrl');
      _dismissDialog();
      final paymentResult = await Get.to(PaymentWebView(url: actionUrl, urlSuccess: returnUrlSuccess, urlFailed: returnUrlFailed, urlCancelled: returnUrlCancelled,));
      // SuccessPayment(actionUrl);
      if (paymentResult == 'success') {
        return 200;
        Get.snackbar('Success', 'Payment was successful');
      } else if (paymentResult == 'failed') {
        Get.snackbar('Failed', 'Payment failed');
        return 250;
      } else if (paymentResult == 'cancelled') {
        return 260;
        Get.snackbar('Cancelled', 'Payment was cancelled');
      }


      return 0;
    } else
      _dismissDialog();
      print('Payment failed with status ${response.statusCode}: ${response.body}');
 return response.statusCode;

    }
  }
void _dismissDialog() {
  Navigator.of(Get.overlayContext!).pop();
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

 enum PaymentJobParameter
{
  Sha512,
  CardNumber,
  CardCvc,
  CardExpiryMonth,
  CardExpiryYear
  // Add other parameters as necessary
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


class PaymentWebView extends StatefulWidget {
  final String url;
  final String urlSuccess;
  final String urlFailed;
  final String urlCancelled;

  PaymentWebView({required this.url,required this.urlSuccess,required this.urlFailed,required this.urlCancelled});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  WebViewController webViewController = WebViewController();

  setWebController(){
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(progress);
          },
          onPageStarted: (String url) {},
            onPageFinished: (url) {
              // You can handle actions here after the page is finished loading
              // For example, you might check for success indicators in the URL
              print("page finished url is $url");
              if (url.contains('https://admin.sweatboxsoho.com/success')) {
                Navigator.pop(context, 'success'); // Pass success status
              } else if (url.contains('https://admin.sweatboxsoho.com/failed')) {
                Navigator.pop(context, 'failed'); // Pass failure status
              } else if (url.contains("https://admin.sweatboxsoho.com/cancel")) {
                Navigator.pop(context, 'cancelled'); // Pass cancelled status
              } else {
                print("Unknown status URL: $url");
                // Navigator.pop(context, 'failed');
              }
            },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
  @override
  void initState() {

    super.initState();
    setWebController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Confirmation'),
      ),
      body:WebViewWidget(
          controller: webViewController,
      )
      // WebView(
      //   initialUrl: url,
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onPageFinished: (url) {
      //     // You can handle actions here after the page is finished loading
      //     // For example, you might check for success indicators in the URL
      //     if (url.contains('success')) {
      //       Navigator.of(context).pushReplacementNamed('/payment-success');
      //     } else if (url.contains('error')) {
      //       Navigator.of(context).pushReplacementNamed('/payment-failed');
      //     }
      //   },
      // ),
    );
  }
}
