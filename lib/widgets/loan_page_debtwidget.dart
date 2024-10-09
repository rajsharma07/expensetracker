import 'package:expensetracker/bloc/debt_page/debt_page_bloc.dart';
import 'package:expensetracker/bloc/debt_page/debt_page_event.dart';
import 'package:expensetracker/bloc/debt_page/debt_page_state.dart';
import 'package:expensetracker/models/debt.dart';
import 'package:expensetracker/widgets/add_debt.dart';
import 'package:expensetracker/widgets/debt_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoanPageDebtwidget extends StatefulWidget {
  const LoanPageDebtwidget({super.key});
  @override
  State<LoanPageDebtwidget> createState() => _LoanPageDebtwidgetState();
}

class _LoanPageDebtwidgetState extends State<LoanPageDebtwidget> {
  void addDebtToDb(Debt d, BuildContext ctx) {
    ctx.read<DebtPageBloc>().add(AddDebtEvent(debt: d));
  }

  late DebtPageBloc dbtbloc;
  @override
  void initState() {
    dbtbloc = BlocProvider.of<DebtPageBloc>(context)..add(Initdebt());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtPageBloc, DebtPageState>(
      bloc: dbtbloc,
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
                      const Text("Debt"),
                      const Spacer(),
                      IconButton.filled(
                          onPressed: () {
                            showBottomSheet(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.sizeOf(context).height * 0.4),
                              context: context,
                              builder: (context) {
                                return AddDebt(
                                    addDebtToDb: addDebtToDb, ctx: ctxx);
                              },
                            );
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  if (state.debts.isEmpty)
                    const Text("No Debt")
                  else
                    ...state.debts.map(
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
                                  .read<DebtPageBloc>()
                                  .add(RemoveDebtEvent(datetime: e.datetime));
                            },
                            child: DebtCard(debt: e));
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
