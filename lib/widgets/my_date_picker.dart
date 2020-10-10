import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as myDate;
import 'package:stack_finance_assignment/cubits/add_weight_cubit/add_weight_cubit.dart';
import 'package:stack_finance_assignment/cubits/edit_weight_cubit/edit_weight_cubit.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';

class MyDatePicker extends StatefulWidget {
  final WeightModel weightModel;
  MyDatePicker(this.weightModel);

  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWeightCubit, WeightModel>(builder: (context, state) {
      return Theme(
        data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(
                bodyText2: TextStyle(color: Colors.white),
                bodyText1: TextStyle(color: Colors.white))),
        child: myDate.DayPicker(
          selectedDate: state.selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          onChanged: (val) {
            state.id.isEmpty
                ? BlocProvider.of<AddWeightCubit>(context)
                    .emitNewTimeStamp(state, val)
                : BlocProvider.of<EditWeightCubit>(context)
                    .emitNewTimeStamp(state, val);
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
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              dayHeaderStyle: myDate.DayHeaderStyle(
                  textStyle: TextStyle(color: Colors.white54))),
        ),
      );
    });
  }
}
