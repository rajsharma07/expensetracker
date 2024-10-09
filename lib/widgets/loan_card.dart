import 'package:expensetracker/models/loan_given.dart';
import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  const LoanCard({super.key, required this.loan});
  final LoanGiven loan;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.attach_money),
      title: Text(loan.title),
      trailing: Text(loan.amount.toString()),
      subtitle:
          Text("${loan.borrower} : ${loan.datetime} Due: ${loan.duedate}"),
    );
  }
}
