import 'package:expensetracker/bloc/loan_page/loan_page_bloc.dart';
import 'package:expensetracker/bloc/loan_page/loan_page_event.dart';
import 'package:expensetracker/bloc/loan_page/loan_page_state.dart';
import 'package:expensetracker/models/loan_given.dart';
import 'package:expensetracker/widgets/add_loan.dart';
import 'package:expensetracker/widgets/loan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoanPageLoanwidget extends StatefulWidget {
  const LoanPageLoanwidget({super.key});
  @override
  State<LoanPageLoanwidget> createState() => _LoanPageLoanwidgetState();
}

class _LoanPageLoanwidgetState extends State<LoanPageLoanwidget> {
  void addLoanToDb(LoanGiven l, BuildContext ctx) {
    ctx.read<LoanPageBloc>().add(AddLoanEvent(loan: l));
  }

  late LoanPageBloc loanbloc;
  @override
  void initState() {
    loanbloc = BlocProvider.of<LoanPageBloc>(context)..add(InitLoan());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanPageBloc, LoanPageState>(
      bloc: loanbloc,
      builder: (ctxx, state) {
        return Card.filled(
          color: const Color.fromARGB(28, 104, 58, 183),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text("Loans"),
                      const Spacer(),
                      IconButton.filled(
                          onPressed: () {
                            showBottomSheet(
                              context: context,
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.sizeOf(context).height * 0.4),
                              builder: (context) {
                                return AddLoan(
                                  addLoanToDb: addLoanToDb,
                                  ctx: ctxx,
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  if (state.loans.isEmpty)
                    const Text("No Loan")
                  else
                    ...state.loans.map(
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
                            onDismissed: (direction) {
                              ctxx
                                  .read<LoanPageBloc>()
                                  .add(RemoveLoanEvent(datetime: e.datetime));
                            },
                            child: LoanCard(loan: e));
                      },
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
