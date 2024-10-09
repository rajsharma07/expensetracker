import 'package:expensetracker/bloc/loan_page/loan_page_event.dart';
import 'package:expensetracker/bloc/loan_page/loan_page_state.dart';
import 'package:expensetracker/dbms_handler/crud.dart';
import 'package:expensetracker/models/loan_given.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoanPageBloc extends Bloc<LoanPageEvent, LoanPageState> {
  LoanPageBloc() : super(const LoanPageState()) {
    on<InitLoan>(
      (event, emit) async {
        List<Map<String, Object?>> data = await dbobj.database!.query("Loan");
        List<LoanGiven> loans = [];
        for (var e in data) {
          loans.add(LoanGiven(
              datetime: e["date_time"] as String,
              title: e["title"] as String,
              duedate: e["due_date"] as String,
              borrower: e["borrower"] as String,
              amount: e["amount"] as int));
        }

        emit(state.copyWith(loans: loans));
      },
    );

    on<AddLoanEvent>(
      (event, emit) {
        LoanGiven l = event.loan;
        dbobj.database!.insert("Loan", {
          "date_time": l.datetime,
          "borrower": l.borrower,
          "due_date": l.duedate,
          "amount": l.amount,
          "title": l.title
        });
        List<LoanGiven> loans = [];
        for (var i in state.loans) {
          loans.add(i);
        }
        loans.add(l);
        emit(state.copyWith(loans: loans));
      },
    );

    on<RemoveLoanEvent>(
      (event, emit) {
        dbobj.database!.delete("Loan",
            where: "date_time = ?", whereArgs: [event.datetime]);
        state.loans.removeWhere(
          (element) {
            return element.datetime == event.datetime;
          },
        );
        emit(state.copyWith());
      },
    );
  }
}
