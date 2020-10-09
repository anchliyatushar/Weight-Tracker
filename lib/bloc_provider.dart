import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_finance_assignment/app.dart';
import 'package:stack_finance_assignment/cubits/login_cubit/login_cubit.dart';
import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:stack_finance_assignment/repositories/login_repository.dart';

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
      // BlocProvider(
      //   create: (context) => NavigatorCubit(),
      // ),
    ], child: App());
  }
}
