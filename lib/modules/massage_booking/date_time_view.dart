import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_box/extras/constant/app_color.dart';
import 'package:s_box/extras/constant/string_constant.dart';
import 'package:s_box/modules/commonWidgets/common.dart';
import 'package:s_box/modules/commonWidgets/submitBtn.dart';
import 'package:s_box/modules/massage_booking/date_time_controller.dart';
import 'package:s_box/modules/massage_booking/massage_controller.dart';
import 'package:s_box/themes/colors/color_light.dart';
import 'package:table_calendar/table_calendar.dart';

class DateTimeView extends StatelessWidget {

  DateTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorLight.black,
      appBar: AppBar(
        backgroundColor: ColorLight.black,
        centerTitle: true,
        title: const Text(
          strSelectDateTime,
        ),
        titleTextStyle: const TextStyle(
          color: ColorLight.white,
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: ColorLight.white,
          ),
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: GetBuilder<DateTimeController>(
          init: DateTimeController(),
          builder: (controller) {
            return Column(
              children: [
            Container(
            decoration: BoxDecoration(
            color: ColorLight.black,

            ),
              child:   buildCalendar(controller),
            ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics().parent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorLight.black,

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          buildSelectTime(controller),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
            Container(
              padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
            color: ColorLight.black,

              
            ),
              child:   buildContinueBtn(controller),)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildCalendar(DateTimeController dateTimeController) {
    return Obx(() => TableCalendar(
      focusedDay: dateTimeController.focusedDay.value,
      firstDay: DateTime.now(),
      lastDay: DateTime(2500),
      currentDay: dateTimeController.selectedDay.value,
      selectedDayPredicate: (day) {
        return isSameDay(day, dateTimeController.selectedDay.value);
      },
      onDaySelected: (selectedDay, focusedDay) {
        dateTimeController.onDaySelected(selectedDay, focusedDay);
      },
      calendarFormat: dateTimeController.calendarFormat.value,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: ColorLight.white),
        weekendStyle: TextStyle(color: ColorLight.white),
      ),
      availableGestures: AvailableGestures.horizontalSwipe,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: true,
        rightChevronVisible: true,
        leftChevronMargin: EdgeInsets.only(left: Get.width * 0.25),
        rightChevronMargin: EdgeInsets.only(right: Get.width * 0.25),
        leftChevronIcon: const Icon(
          Icons.keyboard_arrow_left,
          color: ColorLight.white,
        ),
        rightChevronIcon: const Icon(
          Icons.keyboard_arrow_right,
          color: ColorLight.white,
        ),
        titleCentered: true,
        titleTextStyle: const TextStyle(color: ColorLight.white),
      ),
      calendarStyle: const CalendarStyle(
        todayTextStyle: TextStyle(color: ColorLight.white),
        defaultDecoration: BoxDecoration(
          color: ColorLight.black,
        ),
        defaultTextStyle: TextStyle(color: ColorLight.white),
        disabledTextStyle: TextStyle(color: ColorLight.white),
        isTodayHighlighted: true,
        markerDecoration: BoxDecoration(color: appPrimaryColor, shape: BoxShape.circle),
        selectedDecoration: BoxDecoration(shape: BoxShape.circle, color: appPrimaryColor),
        todayDecoration: BoxDecoration(color: appPrimaryColor, shape: BoxShape.circle),
        holidayTextStyle: TextStyle(color: ColorLight.white),
        weekendTextStyle: TextStyle(color: ColorLight.white),
      ),
    ));
  }

  Widget buildSelectTime(DateTimeController dateTimeController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: const Divider(
            color: textFieldColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: Get.height * 0.02,
          ),
          child: text(
            text: strSelectTime,
            size: 14,
            fontWeight: FontWeight.w700,
            color: ColorLight.white,
          ),
        ),
        Obx(() => Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.start,
          children: List.generate(dateTimeController.timeSlots.length, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05 ,
                  vertical: Get.height*0.011),
              child: ChoiceChip(
                selectedColor: appPrimaryColor,
                backgroundColor: ColorLight.black,
                label: Text(
                  dateTimeController.timeSlots[index],
                  style:  TextStyle(color: ColorLight.white ,
                      fontSize: Get.height*0.0175 , fontWeight: dateTimeController.timeSelected[index].value ? FontWeight.w700:FontWeight.w400),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.0395,
                  vertical: Get.height*0.0125,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: textFieldColor),
                ),
                showCheckmark: false,
                selected: dateTimeController.timeSelected[index].value,
                onSelected: (selected) {
                  if (selected) {
                    // Deselect all other time slots
                    for (int j = 0; j < dateTimeController.timeSelected.length; j++) {
                      dateTimeController.timeSelected[j].value = false;
                    }
                    // Select the current time slot
                    dateTimeController.timeSelected[index].value = true;
                    // Gather details when time slot is selected
                    dateTimeController.gatherDetails(dateTimeController.timeSlots[index]);
                  } else {
                    // Deselect the current time slot
                    dateTimeController.timeSelected[index].value = false;
                  }
                },
              ),
            );
          }),
        )),
        const SizedBox(height: 20,),
      ],
    );
  }

  Widget buildContinueBtn(DateTimeController dateTimeController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: customSubmitBtn(
        text: strContinue,
        voidCallback: () {
          if (!dateTimeController.isTimeSlotSelected()) {
            Get.snackbar("Sweatbox", "Please select a time slot.",colorText: Colors.white);
            return;
          }
          dateTimeController.goToSummary();
          // Here you can navigate to the next screen or perform other actions
        },
        width: Get.width,
      ),
    );
  }
}
