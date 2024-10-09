import 'package:expensetracker/models/income_model.dart';
import 'package:expensetracker/runTimeData/categories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomeCard extends StatelessWidget {
  const IncomeCard({super.key, required this.inc});
  final IncomeModel inc;
  @override
  Widget build(BuildContext context) {
    return Card(
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
                          inc.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        )),
                        Row(
                          children: [
                            const Text("Category: "),
                            Text(categories[inc.category] ?? "Others")
                          ],
                        ),
                        Row(
                          children: [const Text("Date: "), Text(inc.datetime)],
                        ),
                        Row(
                          children: [
                            const Text("Amount: "),
                            Text(inc.amount.toString())
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
        title: Text(inc.title),
        trailing: Text(inc.amount.toString()),
        subtitle: Text(inc.datetime),
      ),
    );
  }
}
