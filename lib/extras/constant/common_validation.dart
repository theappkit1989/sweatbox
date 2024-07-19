import 'package:flutter/services.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
bool isValidEmail(String email) {
  return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);
}

showSnackbar(String type,String message) {
  return Get.snackbar(type, message,
      backgroundColor: Colors.white70,colorText: ColorLight.colorPrimary);
}
String connectionStatus = 'Unknown';
final Connectivity connectivity = Connectivity();
bool internetCheck = true;

bool _loaderCheck = false;
bool get loaderCheck => _loaderCheck;




//---------internet-checker-functions----------------------

Future<void> initConnectivity() async {
  ConnectivityResult? result;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = (await connectivity.checkConnectivity()) as ConnectivityResult?;
    // notifyListeners();
  } on PlatformException catch (e) {
    // log(e.toString());
  }
  // log('updateConnectionStatus');
  return updateConnectionStatus(result!);
}

Future<void> updateConnectionStatus(ConnectivityResult result) async {
  // log('updateConnectionStatus  $result');
  switch (result) {
    case ConnectivityResult.wifi:
    case ConnectivityResult.mobile:
    case ConnectivityResult.none:
      connectionStatus = result.toString();
      if (result != ConnectivityResult.none) {
        internetCheck = true;
      } else {
        internetCheck = false;
        // log('InternetOFF');
      }
      // notifyListeners();
      break;
    default:
      connectionStatus =' ErrorStrings.failed_to_connectivity';
      // notifyListeners();
      break;
  }
}

Future<bool> isConnected() async {
  // Get the current connectivity status
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

  // Check if the connectivity is either WiFi or mobile
  if (connectivityResult.contains(ConnectivityResult.mobile ) ||
      connectivityResult.contains(ConnectivityResult.wifi)) {
    return true; // Connected to the internet
  } else {
    return false; // Not connected to the internet
  }
}
