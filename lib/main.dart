import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:stack_finance_assignment/bloc_provider.dart';
import 'package:stack_finance_assignment/utils/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  HydratedBloc.storage = await HydratedStorage.build();

  runApp(BlocProviderScreen());
}
