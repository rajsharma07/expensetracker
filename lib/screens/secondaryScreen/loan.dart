import 'package:expensetracker/bloc/debt_page/debt_page_bloc.dart';
import 'package:expensetracker/bloc/loan_page/loan_page_bloc.dart';
import 'package:expensetracker/widgets/loan_page_debtwidget.dart';
import 'package:expensetracker/widgets/loan_page_loanwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Loan extends StatefulWidget {
  const Loan({super.key});

  @override
  State<Loan> createState() => _LoanState();
}

class _LoanState extends State<Loan> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocProvider(
            create: (context) => LoanPageBloc(),
            child: const LoanPageLoanwidget(),
          ),
          BlocProvider(
            create: (context) => DebtPageBloc(),
            child: const LoanPageDebtwidget(),
          ),
        ],
      ),
    );
  }
}
