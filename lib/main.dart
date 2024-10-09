import 'package:expensetracker/screens/mainScreens/error_screen.dart';
import 'package:expensetracker/screens/mainScreens/expense_tracker.dart';
import 'package:expensetracker/screens/mainScreens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:expensetracker/dbms_handler/crud.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: FutureBuilder(
          future: dbobj.createdb(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return ExpenseTracker();
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            return const ErrorScreen();
          },
        ));
  }
}
