import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_finance_assignment/cubits/home_cubit/home_cubit.dart';
import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';
import 'package:stack_finance_assignment/utils/strings.dart';
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
      body: _buildHomeBody(),
    );
  }

  Widget _buildHomeBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
        StreamBuilder(
            stream:
                BlocProvider.of<HomeCubit>(context).getUserWeightsStream(uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _buildRecentWeights(snapshot.data);
              }
              return Center(child: CircularProgressIndicator());
            }),
        SizedBox(height: 40),
      ]),
    );
  }

  Widget _buildRecentWeights(List<WeightModel> listWeightModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(
          height: 8,
        ),
        shrinkWrap: true,
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
                              await context.bloc<HomeCubit>().deleteUserWeights(
                                  listWeightModel[index], uid);
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
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${timeago.format(listWeightModel[index].selectedDate)}",
                        style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    if (index == listWeightModel.length - 1) ...{
                      if (listWeightModel[index].weight >
                          listWeightModel[0].weight) ...{
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: Colors.red,
                                  size: 22,
                                ),
                                Text(
                                    "${listWeightModel[index].weight - listWeightModel[0].weight} Kgs",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 22)),
                              ],
                            ))
                      },
                      if (listWeightModel[index].weight <
                          listWeightModel[0].weight) ...{
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.green,
                                  size: 22,
                                ),
                                Text(
                                    "${listWeightModel[0].weight - listWeightModel[index].weight} Kgs",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 22)),
                              ],
                            ))
                      } else ...{
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "${listWeightModel[0].weight - listWeightModel[index].weight} Kgs",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 22)),
                        )
                      }
                    } else ...{
                      if (listWeightModel[index].weight >
                          listWeightModel[index + 1].weight) ...{
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: Colors.red,
                                  size: 22,
                                ),
                                Text(
                                    "${listWeightModel[index].weight - listWeightModel[index + 1].weight} Kgs",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 22)),
                              ],
                            ))
                      },
                      if (listWeightModel[index].weight <
                          listWeightModel[index + 1].weight) ...{
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.green,
                                  size: 22,
                                ),
                                Text(
                                    "${listWeightModel[index + 1].weight - listWeightModel[index].weight} Kgs",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 22)),
                              ],
                            ))
                      },
                      if (listWeightModel[index].weight ==
                          listWeightModel[index + 1].weight) ...{
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    "${listWeightModel[index + 1].weight - listWeightModel[index].weight} Kgs",
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 22)),
                              ],
                            ))
                      }
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
      ),
    );
  }
}
