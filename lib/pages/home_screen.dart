import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/utils/strings.dart';
import 'package:stack_finance_assignment/widgets/new_weight_fab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddWeightFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: my_primary_color,
      body: _buildHomeBody(),
    );
  }

  Widget _buildHomeBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(userAvatar),
            )
          ],
        ),
      ]),
    );
  }
}
