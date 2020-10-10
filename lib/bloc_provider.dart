import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_finance_assignment/app.dart';
import 'package:stack_finance_assignment/cubits/add_weight_cubit/add_weight_cubit.dart';
import 'package:stack_finance_assignment/cubits/home_cubit/home_cubit.dart';
import 'package:stack_finance_assignment/cubits/login_cubit/login_cubit.dart';
import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';
import 'package:stack_finance_assignment/repositories/login_repository.dart';
import 'package:stack_finance_assignment/repositories/weight_repository.dart';

class BlocProviderScreen extends StatefulWidget {
  @override
  _BlocProviderScreenState createState() => _BlocProviderScreenState();
}

class _BlocProviderScreenState extends State<BlocProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => UserCubit(),
      ),
      BlocProvider(
        create: (context) => LoginCubit(
          LoginRepository(),
          BlocProvider.of<UserCubit>(context),
        ),
      ),
      BlocProvider(
        create: (context) => HomeCubit(
          WeightRepository(),
        ),
      ),
      BlocProvider(
          create: (context) => AddWeightCubit(
              WeightRepository(),
              WeightModel(
                  height: 5,
                  weight: 50,
                  selectedDate: DateTime.now(),
                  timestamp: DateTime.now().toString(),
                  id: "",
                  status: WeightStatus.Initial))),
    ], child: App());
  }
}
