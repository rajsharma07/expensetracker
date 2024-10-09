import 'package:expensetracker/bloc/debt_page/debt_page_event.dart';
import 'package:expensetracker/bloc/debt_page/debt_page_state.dart';
import 'package:expensetracker/dbms_handler/crud.dart';
import 'package:expensetracker/models/debt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtPageBloc extends Bloc<DebtPageEvent, DebtPageState> {
  DebtPageBloc() : super(const DebtPageState()) {
    on<Initdebt>(
      (event, emit) async {
        List<Map<String, Object?>> data = await dbobj.database!.query("Debt");
        List<Debt> debts = [];
        for (var e in data) {
          debts.add(Debt(
              datetime: e["date_time"] as String,
              title: e["title"] as String,
              duedate: e["due_date"] as String,
              lender: e["lender"] as String,
              amount: e["amount"] as int));
        }
        emit(state.copyWith(debts: debts));
      },
    );

    on<AddDebtEvent>(
      (event, emit) {
        Debt l = event.debt;
        dbobj.database!.insert("debt", {
          "date_time": l.datetime,
          "lender": l.lender,
          "due_date": l.duedate,
          "amount": l.amount,
          "title": l.title
        });
        List<Debt> debts = [];
        for (var i in state.debts) {
          debts.add(i);
        }
        debts.add(l);
        emit(state.copyWith(debts: debts));
      },
    );

    on<RemoveDebtEvent>(
      (event, emit) {
        dbobj.database!.delete("debt",
            where: "date_time = ?", whereArgs: [event.datetime]);
        state.debts.removeWhere(
          (element) {
            return element.datetime == event.datetime;
          },
        );
        emit(state.copyWith());
      },
    );
  }
}
