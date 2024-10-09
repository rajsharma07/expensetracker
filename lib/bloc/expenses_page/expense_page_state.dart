import 'package:equatable/equatable.dart';
import 'package:expensetracker/models/expense_model.dart';

class ExpensePageState extends Equatable {
  final List<ExpenseModel> expenses;

  const ExpensePageState({this.expenses = const []});
  ExpensePageState copywith({List<ExpenseModel>? l}) {
    return ExpensePageState(expenses: l ?? []);
  }

  @override
  List<Object> get props => [expenses];
}
