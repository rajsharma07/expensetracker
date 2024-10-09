import 'package:expensetracker/runTimeData/categories.dart';
import 'package:expensetracker/models/income_model.dart';
import 'package:flutter/material.dart';

class Addincome extends StatefulWidget {
  const Addincome(this.addincfunc, {super.key});
  final Function(IncomeModel inc) addincfunc;
  @override
  State<Addincome> createState() {
    return AddincomeState();
  }
}

class AddincomeState extends State<Addincome> {
  final formkey = GlobalKey<FormState>();
  String source = "";
  DateTime dt = DateTime.now();
  int amount = 0;
  int category = 0;
  String title = "";
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Title"),
              ),
              onSaved: (newValue) {
                title = newValue ?? "";
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Source"),
              ),
              onSaved: (newValue) {
                source = newValue ?? "";
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text("Amount"),
              ),
              onSaved: (newValue) {
                amount = int.parse(newValue ?? "0");
              },
            ),
            DropdownButtonFormField(
              value: 0,
              items: [
                ...categories.keys.map(
                  (e) {
                    return DropdownMenuItem(
                        value: e, child: Text(categories[e]!));
                  },
                )
              ],
              onChanged: (value) {
                category = value ?? 0;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  formkey.currentState!.save();
                  IncomeModel inc = IncomeModel(
                      datetime: dt.toString(),
                      title: title,
                      userId: "007",
                      source: source,
                      category: category,
                      amount: amount);
                  widget.addincfunc(inc);
                  Navigator.of(context).pop();
                },
                child: const Text("Add expense"))
          ],
        ));
  }
}
