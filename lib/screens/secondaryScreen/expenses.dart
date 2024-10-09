import 'package:expensetracker/bloc/expenses_page/expense_page_bloc.dart';
import 'package:expensetracker/bloc/expenses_page/expense_page_event.dart';
import 'package:expensetracker/bloc/expenses_page/expense_page_state.dart';
import 'package:expensetracker/models/expense_model.dart';
import 'package:expensetracker/widgets/add_expense.dart';
import 'package:expensetracker/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void initpage(BuildContext context) async {
    context.read<ExpensePageBloc>().add(InitExpense());
  }

  void addingexp(ExpenseModel exp) {
    context.read<ExpensePageBloc>().add(AddExpense(exp: exp));
  }

  void addexp() {
    showBottomSheet(
        enableDrag: true,
        showDragHandle: true,
        context: context,
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.4),
        builder: (context) {
          return Addexpense(addingexp);
        });
  }

  late ExpensePageBloc expbloc;
  @override
  void initState() {
    expbloc = BlocProvider.of<ExpensePageBloc>(context)..add(InitExpense());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensePageBloc, ExpensePageState>(
      bloc: expbloc,
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: IconButton.filled(
              onPressed: () {
                addexp();
              },
              icon: const Icon(Icons.add)),
          body: Column(
            children: [
              if (state.expenses.isEmpty)
                Center(
                  child: Text(
                    "Please add expense",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                )
              else
                ...state.expenses.map(
                  (e) {
                    return Dismissible(
                      background: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.error),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            Spacer(),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      key: Key(e.datetime),
                      child: ExpenseCard(exp: e),
                      onDismissed: (direction) {
                        context
                            .read<ExpensePageBloc>()
                            .add(RemoveExpense(datatime: e.datetime));
                      },
                    );
                  },
                )
            ],
          ),
        );
      },
    );
  }
}
