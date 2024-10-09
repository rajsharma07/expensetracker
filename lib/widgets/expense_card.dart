import 'package:expensetracker/models/expense_model.dart';
import 'package:expensetracker/runTimeData/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({super.key, required this.exp});
  final ExpenseModel exp;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: const Color.fromARGB(22, 104, 58, 183),
      child: ListTile(
        onTap: () {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          exp.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        )),
                        Row(
                          children: [
                            const Text("Category: "),
                            Text(categories[exp.category] ?? "Others")
                          ],
                        ),
                        Row(
                          children: [const Text("Date: "), Text(exp.datetime)],
                        ),
                        Row(
                          children: [
                            const Text("Amount: "),
                            Text(exp.amount.toString())
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Ok"))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        title: Text(exp.title),
        trailing: Text(exp.amount.toString()),
        subtitle: Text(exp.datetime),
      ),
    );
  }
}
