import 'package:expensetracker/bloc/income_page/income_page_event.dart';
import 'package:expensetracker/bloc/income_page/income_page_state.dart';
import 'package:expensetracker/models/income_model.dart';
import 'package:expensetracker/dbms_handler/crud.dart';
import 'package:expensetracker/runTimeData/categories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomePageBloc extends Bloc<IncomePageEvent, IncomePageState> {
  IncomePageBloc() : super(const IncomePageState()) {
    on<InitIncome>(
      (event, emit) async {
        List<Map<String, Object?>> catData =
            await dbobj.database!.query("Categories");
        for (var e in catData) {
          categories[e["id"] as int] = e["name"] as String;
        }
        List<Map<String, Object?>> expmap =
            await dbobj.database!.query("Income");
        List<IncomeModel> data = [];
        if (expmap.isNotEmpty) {
          data = expmap.map(
            (e) {
              return IncomeModel(
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
    on<AddIncome>(
      (event, emit) async {
        final inc = event.income;
        await dbobj.database!.insert("Income", {
          "date_time": inc.datetime,
          "title": inc.title,
          "userId": inc.userId,
          "category": inc.category,
          "amount": inc.amount,
          "source": inc.source,
        });
        List<IncomeModel> data = [];
        for (var i in state.incomes) {
          data.add(i);
        }
        data.add(inc);
        emit(state.copywith(l: data));
      },
    );
    on<RemoveIncome>(
      (event, emit) async {
        await dbobj.database!.delete("Income",
            where: "date_time = ?", whereArgs: [event.datatime]);
        state.incomes.removeWhere(
          (element) => (element.datetime == event.datatime),
        );
        emit(state.copywith(l: state.incomes));
      },
    );
  }
}
