import 'package:expensetracker/bloc/expenses_page/expense_page_event.dart';
import 'package:expensetracker/bloc/expenses_page/expense_page_state.dart';
import 'package:expensetracker/dbms_handler/crud.dart';
import 'package:expensetracker/models/expense_model.dart';
import 'package:expensetracker/runTimeData/categories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensePageBloc extends Bloc<ExpensePageEvent, ExpensePageState> {
  ExpensePageBloc() : super(const ExpensePageState()) {
    on<InitExpense>(
      (event, emit) async {
        List<Map<String, Object?>> catData =
            await dbobj.database!.query("Categories");
        for (var e in catData) {
          categories[e["id"] as int] = e["name"] as String;
        }
        List<Map<String, Object?>> expmap =
            await dbobj.database!.query("Expense");
        List<ExpenseModel> data = [];
        if (expmap.isNotEmpty) {
          data = expmap.map(
            (e) {
              return ExpenseModel(
                  datetime: e["date_time"] as String,
                  title: e["title"] as String,
                  userId: e["userId"] as String,
                  source: e["source"] as String,
                  category: e["category"] as int,
                  amount: e["amount"] as int);
            },
          ).toList();
        }
        emit(state.copywith(l: data));
      },
    );
    on<AddExpense>(
      (event, emit) async {
        ExpenseModel exp = event.exp;
        await dbobj.database!.insert("Expense", {
          "date_time": exp.datetime,
          "title": exp.title,
          "userId": exp.userId,
          "category": exp.category,
          "amount": exp.amount,
          "source": exp.source,
        });
        List<ExpenseModel> data = [];
        for (var element in state.expenses) {
          data.add(element);
        }
        data.add(event.exp);
        emit(state.copywith(l: data));
      },
    );
    on<RemoveExpense>(
      (event, emit) async {
        await dbobj.database!.delete("Expense",
            where: "date_time = ?", whereArgs: [event.datatime]);
        state.expenses.removeWhere(
          (element) => (element.datetime == event.datatime),
        );
        emit(state.copywith(l: state.expenses));
      },
    );
  }
}
