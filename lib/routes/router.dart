import 'package:auto_route/auto_route_annotations.dart';
import 'package:stack_finance_assignment/pages/add_weight_screen.dart';
import 'package:stack_finance_assignment/pages/edit_weight_screen.dart';
import 'package:stack_finance_assignment/pages/stack_finance.dart';

// use this command to generate routes only - flutter packages pub run build_runner
// use this command to generate routes and to watch - flutter packages pub run build_runner watch

@autoRouter
class $Router {
  @initial
  StackFinance stackFinance;
  @MaterialRoute(fullscreenDialog: true)
  AddWeightScreen addWeightScreen;
  @MaterialRoute(fullscreenDialog: true)
  EditWeightScreen editWeightScreen;
}
