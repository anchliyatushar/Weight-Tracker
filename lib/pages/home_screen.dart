import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_finance_assignment/cubits/home_cubit/home_cubit.dart';
import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';
import 'package:stack_finance_assignment/utils/strings.dart';
import 'package:stack_finance_assignment/widgets/bmi_widget.dart';
import 'package:stack_finance_assignment/widgets/new_weight_fab.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:stack_finance_assignment/routes/router.gr.dart' as myRouter;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
        floatingActionButton: AddWeightFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: my_primary_color,
        body: StreamBuilder(
            stream:
                BlocProvider.of<HomeCubit>(context).getUserWeightsStream(uid),
            builder: (context, AsyncSnapshot<List<WeightModel>> snapshot) {
              if (snapshot.hasData) {
                return _buildHomeBody(snapshot);
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  Widget _buildHomeBody(AsyncSnapshot<List<WeightModel>> snapshot) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 8, 15, 0),
      child: ListView(physics: BouncingScrollPhysics(), children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(userAvatar),
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app_rounded),
              color: Colors.white,
              onPressed: () {
                context.bloc<UserCubit>().emitUserNotLoggedIn();
              },
            )
          ],
        ),
        SizedBox(height: 24),
        Text(
          "BMI Calculator",
          style: TextStyle(
              color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(height: 12),
        Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: my_primary_light_color,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: BmiMarker(getBmi(snapshot.data[0] ?? 0))),
        SizedBox(height: 24),
        Text(
          "History",
          style: TextStyle(
              color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(height: 12),
        _buildRecentWeights(snapshot.data),
        SizedBox(height: 40),
      ]),
    );
  }

  Widget _buildRecentWeights(List<WeightModel> listWeightModel) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(
        height: 8,
      ),
      itemCount: listWeightModel.length,
      itemBuilder: (context, index) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Dismissible(
            key: Key(index.toString()),
            confirmDismiss: (direction) async {
              return await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Are you sure ?"),
                      content: Text("You want to delete this entry"),
                      actions: [
                        FlatButton(
                          child: Text("YES"),
                          onPressed: () async {
                            await context
                                .bloc<HomeCubit>()
                                .deleteUserWeights(listWeightModel[index], uid);
                            myRouter.Router.navigator.pop(true);
                          },
                        ),
                        FlatButton(
                          child: Text("NO"),
                          onPressed: () {
                            myRouter.Router.navigator.pop(false);
                          },
                        ),
                      ],
                    ),
                  ) ??
                  false;
            },
            child: ListTile(
              onTap: () {
                myRouter.Router.navigator.pushNamed(
                    myRouter.Router.editWeightScreen,
                    arguments: listWeightModel[index]);
              },
              contentPadding: EdgeInsets.all(10),
              tileColor: my_primary_light_color,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${timeago.format(listWeightModel[index].selectedDate)}",
                    style: TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  if (index == listWeightModel.length - 1) ...{
                    if (listWeightModel[index].weight >
                        listWeightModel[0].weight) ...{
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Colors.red,
                            size: 22,
                          ),
                          Text(
                              "${listWeightModel[index].weight - listWeightModel[0].weight} Kgs",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 22)),
                        ],
                      )
                    },
                    if (listWeightModel[index].weight <
                        listWeightModel[0].weight) ...{
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.green,
                            size: 22,
                          ),
                          Text(
                              "${listWeightModel[0].weight - listWeightModel[index].weight} Kgs",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 22)),
                        ],
                      )
                    } else ...{
                      Text(
                          "${listWeightModel[0].weight - listWeightModel[index].weight} Kgs",
                          style: TextStyle(color: Colors.white54, fontSize: 22))
                    }
                  } else ...{
                    if (listWeightModel[index].weight >
                        listWeightModel[index + 1].weight) ...{
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_up_rounded,
                            color: Colors.red,
                            size: 22,
                          ),
                          Text(
                              "${listWeightModel[index].weight - listWeightModel[index + 1].weight} Kgs",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 22)),
                        ],
                      )
                    },
                    if (listWeightModel[index].weight <
                        listWeightModel[index + 1].weight) ...{
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.green,
                            size: 22,
                          ),
                          Text(
                              "${listWeightModel[index + 1].weight - listWeightModel[index].weight} Kgs",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 22)),
                        ],
                      )
                    },
                  }
                ],
              ),
              trailing: RichText(
                  text: TextSpan(
                      text: "${listWeightModel[index].weight}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                      children: [
                    TextSpan(
                        text: " Kg",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 8))
                  ])),
            ),
          ),
        );
      },
    );
  }
}

double getBmi(WeightModel data) {
  return data.weight / pow(getInMeters(data.height), 2);
}

double getInMeters(double height) {
  int feet = height.floor();
  int inches = ((height % 1) * 10).floor();
  return ((feet * 0.3048) + (inches * 0.0254));
}
