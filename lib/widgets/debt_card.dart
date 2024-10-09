import 'package:expensetracker/models/debt.dart';
import 'package:flutter/material.dart';

class DebtCard extends StatelessWidget {
  const DebtCard({super.key, required this.debt});
  final Debt debt;

  @override
  Widget build(BuildContext context) {
    int dueTime = DateTime.parse(debt.duedate)
        .difference(DateTime.parse(debt.datetime))
        .inDays;
    return ListTile(
      leading: const Icon(Icons.attach_money),
      title: Text(debt.title),
      trailing: Text(
        "Due: $dueTime",
        style: TextStyle(color: dueTime < 0 ? Colors.red : null),
      ),
      subtitle: Text("${debt.lender} : ${debt.datetime} Due: ${debt.duedate}"),
    );
  }
}
