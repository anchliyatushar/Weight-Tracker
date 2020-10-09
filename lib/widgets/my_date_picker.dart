import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as myDate;

class MyDatePicker extends StatefulWidget {
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
              bodyText2: TextStyle(color: Colors.white),
              bodyText1: TextStyle(color: Colors.white))),
      child: myDate.DayPicker(
        selectedDate: _selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        onChanged: (val) {
          setState(() {
            _selectedDate = val;
          });
          print(val);
        },
        datePickerLayoutSettings: myDate.DatePickerLayoutSettings(
            scrollPhysics: NeverScrollableScrollPhysics(),
            showPrevMonthEnd: true,
            showNextMonthStart: true),
        datePickerStyles: myDate.DatePickerRangeStyles(
            defaultDateTextStyle: TextStyle(
              color: Colors.white54,
            ),
            selectedPeriodMiddleTextStyle: TextStyle(
              color: Colors.white54,
            ),
            disabledDateStyle: TextStyle(color: Colors.white54),
            displayedPeriodTitle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            dayHeaderStyle: myDate.DayHeaderStyle(
                textStyle: TextStyle(color: Colors.white54))),
      ),
    );
  }
}
