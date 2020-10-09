import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:stack_finance_assignment/utils/strings.dart';
import 'package:stack_finance_assignment/widgets/my_date_picker.dart';
import 'package:stack_finance_assignment/routes/router.gr.dart' as myRouter;
import 'package:stack_finance_assignment/widgets/my_weight_inidcator.dart';

class AddWeightScreen extends StatefulWidget {
  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: my_primary_color,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Container(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
      appBar: AppBar(
        title: Text(
          "New Weight",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
            child: MyDatePicker(),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: my_primary_light_color,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          MyWeightIndicator(),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
