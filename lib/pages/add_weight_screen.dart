import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_finance_assignment/cubits/add_weight_cubit/add_weight_cubit.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';
import 'package:stack_finance_assignment/utils/strings.dart';
import 'package:stack_finance_assignment/widgets/my_date_picker.dart';
import 'package:stack_finance_assignment/widgets/my_weight_inidcator.dart';
import 'package:stack_finance_assignment/widgets/save_fab.dart';

class AddWeightScreen extends StatefulWidget {
  const AddWeightScreen();
  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWeightCubit, WeightModel>(builder: (context, state) {
      return Scaffold(
        backgroundColor: my_primary_color,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SaveFab(state),
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
              child: MyDatePicker(state),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: my_primary_light_color,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
            ),
            MyWeightIndicator(state),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      );
    });
  }
}
