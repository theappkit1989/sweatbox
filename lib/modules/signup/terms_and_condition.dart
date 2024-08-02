import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../extras/constant/string_constant.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final VoidCallback onProceed;

  TermsAndConditionsScreen({required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: Text('Terms and Conditions',style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            strTermsAndcondition,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: Text('Accept Terms and Conditions'),
                content: Text('Do you accept the terms and conditions?'),
                actions: [

                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                      Get.back();
                      Get.back();// Close the Terms and Conditions screen
                    },
                    child: Text('Decline'),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                      Get.back(); // Close the Terms and Conditions screen
                      onProceed();
                    },
                    child: Text('Accept',style: TextStyle(fontWeight: FontWeight.w900),),
                  ),
                ],
              ),
            );
          },
          child: Text('Proceed'),
        ),
      ),
    );
  }
}


class SexualEtiquetteScreen extends StatelessWidget {
  final VoidCallback onProceed;

  SexualEtiquetteScreen({required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(child: Text('Sexual Etiquette',style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            strSexualEtiqutes,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: Text('Accept Sexual Etiquette'),
                content: Text('Do you accept the sexual etiquette?'),
                actions: [

                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                      Get.back();
                      Get.back();// Close the Sexual Etiquette screen
                    },
                    child: Text('Decline'),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close the dialog
                      Get.back(); // Close the Sexual Etiquette screen
                      onProceed();
                    },
                    child: Text('Accept',style: TextStyle(fontWeight: FontWeight.w900),),
                  ),
                ],
              ),
            );
          },
          child: Text('Proceed'),
        ),
      ),
    );
  }
}
