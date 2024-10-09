import 'package:expensetracker/dbms_handler/crud.dart';
import 'package:expensetracker/models/chart_data.dart';
import 'package:expensetracker/runTimeData/categories.dart';
import 'package:expensetracker/widgets/chart_draw.dart';
import 'package:flutter/material.dart';

class Charts extends StatefulWidget {
  const Charts({super.key});
  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  List<ChartData> expensesData = [];
  List<ChartData> incomeData = [];
  List<ChartData> loanDebtData = [];
  Future<bool> getData() async {
    expensesData = [];
    incomeData = [];
    loanDebtData = [];
    // getting expense data
    final d = await dbobj.database!.rawQuery(
        "SELECT category, SUM(amount) as amt FROM Expense GROUP BY category");
    for (var i in d) {
      expensesData
          .add(ChartData(categories[i["category"]] as String, i["amt"] as int));
    }
    // getting income data
    final i = await dbobj.database!.rawQuery(
        "SELECT source, SUM(amount) as amt FROM Income GROUP BY source");
    for (var inc in i) {
      incomeData.add(ChartData(inc["source"] as String, inc["amt"] as int));
    }

    final loan =
        await dbobj.database!.rawQuery("SELECT SUM(amount) as total FROM Loan");
    final debt =
        await dbobj.database!.rawQuery("SELECT SUM(amount) as total FROM Debt");
    final inc = await dbobj.database!
        .rawQuery("SELECT SUM(amount) as total FROM Income");
    var l = loan.first["total"] ?? "0";
    loanDebtData.add(ChartData("Loan", int.parse(l as String)));
    l = debt.first["total"] ?? "0";
    loanDebtData.add(ChartData("Debt", int.parse(l as String)));
    l = inc.first["total"] ?? "0";
    loanDebtData.add(ChartData("Income", int.parse(l as String)));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: (expensesData.isEmpty &&
                    incomeData.isEmpty &&
                    loanDebtData[0].value == 0 &&
                    loanDebtData[1].value == 0 &&
                    loanDebtData[2].value == 0)
                ? const Text("No data Available")
                : Column(
                    children: [
                      ChartDraw(title: "Stats", data: loanDebtData),
                      const Divider(),
                      if (expensesData.isEmpty)
                        const Text("No Data Available")
                      else
                        ChartDraw(
                          title: "Expenses",
                          data: expensesData,
                        ),
                      const Divider(),
                      if (incomeData.isEmpty)
                        const Text("No data available")
                      else
                        ChartDraw(
                          title: "Income",
                          data: incomeData,
                        )
                    ],
                  ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: Text("Something went wrong"),
        );
      },
    );
  }
}
