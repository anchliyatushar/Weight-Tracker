import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stack_finance_assignment/cubits/user_cubit/user_cubit.dart';
import 'package:stack_finance_assignment/pages/home_screen.dart';
import 'package:stack_finance_assignment/pages/login_screen.dart';

class StackFinance extends StatefulWidget {
  const StackFinance();

  @override
  _StackFinanceState createState() => _StackFinanceState();
}

class _StackFinanceState extends State<StackFinance> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoggedIn) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
