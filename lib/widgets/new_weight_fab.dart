import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/routes/router.gr.dart' as myRouter;

class AddWeightFab extends StatefulWidget {
  @override
  _AddWeightFabState createState() => _AddWeightFabState();
}

class _AddWeightFabState extends State<AddWeightFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          myRouter.Router.navigator.pushNamed(myRouter.Router.addWeightScreen);
        },
        label: Container(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Add New Weight",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
