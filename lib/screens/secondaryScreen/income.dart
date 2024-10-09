import 'package:expensetracker/bloc/income_page/income_page_bloc.dart';
import 'package:expensetracker/bloc/income_page/income_page_event.dart';
import 'package:expensetracker/bloc/income_page/income_page_state.dart';
import 'package:expensetracker/models/income_model.dart';
import 'package:expensetracker/widgets/add_income.dart';
import 'package:expensetracker/widgets/income_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  late IncomePageBloc incbloc;
  void addincomefunc(IncomeModel inc) {
    context.read<IncomePageBloc>().add(AddIncome(income: inc));
  }

  void addincome() {
    showBottomSheet(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.4),
      context: context,
      builder: (context) {
        return Addincome(addincomefunc);
      },
    );
  }

  @override
  void initState() {
    incbloc = BlocProvider.of<IncomePageBloc>(context)..add(InitIncome());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IncomePageBloc, IncomePageState>(
      bloc: incbloc,
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: IconButton.filled(
              onPressed: () {
                addincome();
              },
              icon: const Icon(Icons.add)),
          body: Column(
            children: [
              if (state.incomes.isEmpty)
                Center(
                  child: Text(
                    "No Data",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                )
              else
                ...state.incomes.map(
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
                      child: IncomeCard(inc: e),
                      onDismissed: (direction) {
                        context
                            .read<IncomePageBloc>()
                            .add(RemoveIncome(datatime: e.datetime));
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
