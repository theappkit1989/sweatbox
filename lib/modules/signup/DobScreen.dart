import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../themes/colors/color_light.dart';

class DobScreen extends StatefulWidget {
  @override
  _DobScreenState createState() => _DobScreenState();
}

class _DobScreenState extends State<DobScreen> {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final FocusNode dayFocusNode = FocusNode();
  final FocusNode monthFocusNode = FocusNode();
  final FocusNode yearFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    dayFocusNode.addListener(() {
      if (!dayFocusNode.hasFocus && dayController.text.length == 1) {
        setState(() {
          dayController.text = dayController.text.padLeft(2, '0');
        });
      }
    });
    monthFocusNode.addListener(() {
      if (!monthFocusNode.hasFocus && monthController.text.length == 1) {
        setState(() {
          monthController.text = monthController.text.padLeft(2, '0');
        });
      }
    });
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    dayFocusNode.dispose();
    monthFocusNode.dispose();
    yearFocusNode.dispose();
    super.dispose();
  }

  bool validateYear() {
    if (yearController.text.length != 4) {
      return false;
    }
    int year = int.parse(yearController.text);
    int currentYear = DateTime.now().year;
    return year <= currentYear;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: ColorLight.white,
      ),
      body: Center(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.2),
                Container(
                  margin: EdgeInsets.only(left: Get.width * 0.08),
                  child: Text(
                    'Your Birthday',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: Get.width * 0.08),
                  child: Text(
                    'Only your age will be visible to others.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: Get.width * 0.08),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildTextField(
                        controller: dayController,
                        hint: 'DD',
                        maxLength: 2,
                        focusNode: dayFocusNode,
                      ),
                      SizedBox(width: 10),
                      buildTextField(
                        controller: monthController,
                        hint: 'MM',
                        maxLength: 2,
                        focusNode: monthFocusNode,
                      ),
                      SizedBox(width: 10),
                      buildTextField(
                        controller: yearController,
                        hint: 'YYYY',
                        maxLength: 4,
                        focusNode: yearFocusNode,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: Get.width * 0.08),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle_notifications_rounded,
                        color: Colors.white54,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Only your age will be visible to others.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (dayController.text.isNotEmpty &&
                    monthController.text.isNotEmpty &&
                    yearController.text.isNotEmpty &&
                    validateYear()) {
                  Get.back(
                    result:
                    '${dayController.text}-${monthController.text}-${yearController.text}',
                  );
                } else {
                  Get.snackbar(
                    'Invalid Date',
                    'Please enter a valid date.',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required int maxLength,
    FocusNode? focusNode,
  }) {
    return Container(
      width: maxLength == 4 ? Get.width * 0.3 : Get.width * 0.2,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
        focusNode: focusNode,
        decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white54),
          filled: true,
          fillColor: Colors.black12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
