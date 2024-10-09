import 'package:expensetracker/bloc/exp/exp_bloc.dart';
import 'package:expensetracker/bloc/exp/exp_event.dart';
import 'package:expensetracker/bloc/exp/exp_state.dart';
import 'package:expensetracker/bloc/expenses_page/expense_page_bloc.dart';
import 'package:expensetracker/bloc/income_page/income_page_bloc.dart';
import 'package:expensetracker/screens/secondaryScreen/expenses.dart';
import 'package:expensetracker/screens/secondaryScreen/income.dart';
import 'package:expensetracker/screens/secondaryScreen/loan.dart';
import 'package:expensetracker/screens/secondaryScreen/charts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseTracker extends StatelessWidget {
  ExpenseTracker({super.key});
  final List<Widget> screens = [
    BlocProvider(
      create: (context) => ExpensePageBloc(),
      child: const Expenses(),
    ),
    BlocProvider(
      create: (context) => IncomePageBloc(),
      child: const Income(),
    ),
    const Loan(),
    const Charts()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpBloc(),
      child: BlocBuilder<ExpBloc, ExpState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(
                "ExpenseTracker",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              centerTitle: true,
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundImage: AssetImage("assets/icon.png")),
              ),
            ),
            body: screens[state.currentscreen],
            //bottomnavigation bar
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).colorScheme.primary,
              clipBehavior: Clip.antiAlias,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                currentIndex: state.currentscreen,
                selectedItemColor: Theme.of(context).colorScheme.onPrimary,
                unselectedItemColor:
                    Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
                onTap: (value) {
                  context.read<ExpBloc>().add(ChangeEvent(target: value));
                },
                backgroundColor: Theme.of(context).colorScheme.primary,
                items: const [
                  BottomNavigationBarItem(
                    label: "Expenses",
                    icon: Icon(
                      Icons.payments,
                      size: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Income",
                    icon: Icon(
                      Icons.money,
                      size: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Loans",
                    icon: Icon(
                      Icons.inventory,
                      size: 20,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Charts",
                    icon: Icon(
                      Icons.analytics,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
