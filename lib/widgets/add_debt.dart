import 'package:expensetracker/models/debt.dart';
import 'package:flutter/material.dart';

class AddDebt extends StatefulWidget {
  const AddDebt({super.key, required this.addDebtToDb, required this.ctx});
  final Function(Debt l, BuildContext ctx) addDebtToDb;
  final BuildContext ctx;
  @override
  State<AddDebt> createState() => _AddDebtState();
}

class _AddDebtState extends State<AddDebt> {
  final formKey = GlobalKey<FormState>();
  String dueDate = "";
  String title = "";
  int amount = 0;
  String lender = "";
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Title:"),
              ),
              validator: (value) {
                if (value == "") {
                  return "Enter valid title";
                }
                return null;
              },
              onSaved: (newValue) {
                title = newValue!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Lender"),
              ),
              validator: (value) {
                if (value == "") {
                  return "Enter valid Lender name!!";
                }
                return null;
              },
              onSaved: (newValue) {
                lender = newValue!;
              },
            ),
            Row(
              children: [
                const Text("Due date:"),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: () async {
                      final v = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 30),
                        ),
                      );
                      dueDate = v.toString();
                    },
                    icon: const Icon(Icons.calendar_month)),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Amount"),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null ||
                    value == "" ||
                    value == "0" ||
                    int.tryParse(value) == null) {
                  return "Enter valid Amount";
                }
                return null;
              },
              onSaved: (newValue) {
                amount = int.parse(newValue!);
              },
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      widget.addDebtToDb(
                          Debt(
                              datetime: DateTime.now().toString(),
                              title: title,
                              duedate: dueDate,
                              lender: lender,
                              amount: amount),
                          widget.ctx);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Save")),
            )
          ],
        ));
  }
}
