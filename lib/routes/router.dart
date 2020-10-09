import 'package:auto_route/auto_route_annotations.dart';
import 'package:stack_finance_assignment/pages/stack_finance.dart';

// use this command to generate routes and to watch - flutter packages pub run build_runner watch
// use this command to generate routes only - flutter packages pub run build_runner

@autoRouter
class $Router {
  @initial
  StackFinance stackFinance;
}
