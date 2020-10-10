import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_finance_assignment/cubits/add_weight_cubit/add_weight_cubit.dart';
import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';
import 'package:stack_finance_assignment/routes/router.gr.dart' as myRouter;

class SaveFab extends StatefulWidget {
  final WeightModel weightModel;
  SaveFab(this.weightModel);

  @override
  _SaveFabState createState() => _SaveFabState();
}

class _SaveFabState extends State<SaveFab> {
  String uid;
  @override
  void initState() {
    super.initState();
    UserState userState = context.bloc<UserCubit>().state;
    if (userState is UserLoggedIn) {
      uid = userState.userModel.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddWeightCubit, WeightModel>(
      listener: (context, state) {
        switch (state.status) {
          case WeightStatus.Initial:
            break;
          case WeightStatus.Loading:
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 24),
                      Text("Please Wait"),
                    ],
                  ),
                ),
              ),
            );
            break;
          case WeightStatus.Success:
            myRouter.Router.navigator.pop();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Success"),
                content: Text("Your Weight Added"),
                actions: [
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      myRouter.Router.navigator.pop();
                    },
                  ),
                ],
              ),
            );
            break;
          case WeightStatus.Error:
            myRouter.Router.navigator.pop();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Failed"),
                content: Text("Some Error Occured"),
                actions: [
                  FlatButton(
                    child: Text("Retry"),
                    onPressed: () {
                      myRouter.Router.navigator.pop();
                    },
                  ),
                ],
              ),
            );
            break;
        }
      },
      child: FloatingActionButton.extended(
          onPressed: () {
            context
                .bloc<AddWeightCubit>()
                .sendDataToDb(widget.weightModel, uid);
          },
          label: Container(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: widget.weightModel.status == WeightStatus.Loading
                ? CircularProgressIndicator()
                : Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
          )),
    );
  }
}
