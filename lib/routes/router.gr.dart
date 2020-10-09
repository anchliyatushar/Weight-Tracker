// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:stack_finance_assignment/pages/stack_finance.dart';

class Router {
  static const stackFinance = '/';
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
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
