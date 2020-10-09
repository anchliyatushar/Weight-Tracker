import 'package:flutter/material.dart';
import 'package:stack_finance_assignment/pages/stack_finance.dart';
import 'package:stack_finance_assignment/utils/strings.dart';
import 'package:stack_finance_assignment/routes/router.gr.dart' as myRouter;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: my_font,
        accentColor: my_accent_color,
        primaryColor: my_primary_color,
        primaryColorDark: my_primary_color,
        inputDecorationTheme: InputDecorationTheme(
            helperStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            focusColor: Colors.white,
            hoverColor: Colors.white,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            labelStyle: TextStyle(decorationColor: Colors.white),
            fillColor: Colors.white),
      ),
      onGenerateRoute: myRouter.Router.onGenerateRoute,
      navigatorKey: myRouter.Router.navigatorKey,
      home: SafeArea(
        child: Scaffold(
          body: StackFinance(),
        ),
      ),
    );
  }
}
