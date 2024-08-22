import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        title: Text(' '),
        backgroundColor: Colors.black, // Set background color to black
        foregroundColor: Colors.white,
      ),
      body: Column(
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
                  validateYear()&&validateDate()&&
                  isAtLeast18YearsOld()) {
                String formattedDate = formatDateString(
                  dayController.text,
                  monthController.text,
                  yearController.text,
                ) ?? 'Invalid Date';
                Get.back(
                  result: formattedDate,
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
    );
  }
  bool isAtLeast18YearsOld() {
    try {
      DateTime birthDate = DateTime.parse('${yearController.text}-${monthController.text.padLeft(2, '0')}-${dayController.text.padLeft(2, '0')}');
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age >= 18;
    } catch (e) {
      return false;
    }
  }
  bool validateDate() {
    try {
      DateTime inputDate = DateTime.parse('${yearController.text}-${monthController.text.padLeft(2, '0')}-${dayController.text.padLeft(2, '0')}');
      DateTime today = DateTime.now();
      return inputDate.isBefore(today) || inputDate.isAtSameMomentAs(today.subtract(Duration(days: 1)));
    } catch (e) {
      return false;
    }
  }
  String? formatDateString(String day, String month, String year) {
    try {
      DateTime date = DateTime.parse('$year-${month.padLeft(2, '0')}-${day.padLeft(2, '0')}');
      return DateFormat('MMM dd, yyyy').format(date); // Format to "Feb 5, 2010"
    } catch (e) {
      return null;
    }
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
