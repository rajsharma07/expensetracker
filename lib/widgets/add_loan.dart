import 'package:expensetracker/models/loan_given.dart';
import 'package:flutter/material.dart';

class AddLoan extends StatefulWidget {
  const AddLoan({super.key, required this.addLoanToDb, required this.ctx});
  final Function(LoanGiven l, BuildContext ctx) addLoanToDb;
  final BuildContext ctx;
  @override
  State<AddLoan> createState() => _AddLoanState();
}

class _AddLoanState extends State<AddLoan> {
  final formKey = GlobalKey<FormState>();
  String dueDate = "";
  String title = "";
  int amount = 0;
  String borrower = "";
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
                label: Text("Borrower"),
              ),
              validator: (value) {
                if (value == "") {
                  return "Enter valid Borrower name!!";
                }
                return null;
              },
              onSaved: (newValue) {
                borrower = newValue!;
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
                      widget.addLoanToDb(
                          LoanGiven(
                              datetime: DateTime.now().toString(),
                              title: title,
                              duedate: dueDate,
                              borrower: borrower,
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
