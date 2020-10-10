// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:stack_finance_assignment/pages/stack_finance.dart';
import 'package:stack_finance_assignment/pages/add_weight_screen.dart';
import 'package:stack_finance_assignment/pages/edit_weight_screen.dart';
import 'package:stack_finance_assignment/models/weight_model.dart';

class Router {
  static const stackFinance = '/';
  static const addWeightScreen = '/add-weight-screen';
  static const editWeightScreen = '/edit-weight-screen';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.stackFinance:
        return MaterialPageRoute(
          builder: (_) => StackFinance(),
          settings: settings,
        );
      case Router.addWeightScreen:
        return MaterialPageRoute(
          builder: (_) => AddWeightScreen(),
          settings: settings,
          fullscreenDialog: true,
        );
      case Router.editWeightScreen:
        if (hasInvalidArgs<WeightModel>(args)) {
          return misTypedArgsRoute<WeightModel>(args);
        }
        final typedArgs = args as WeightModel;
        return MaterialPageRoute(
          builder: (_) => EditWeightScreen(typedArgs),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
