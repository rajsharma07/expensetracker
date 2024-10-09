import 'package:equatable/equatable.dart';
import 'package:expensetracker/models/expense_model.dart';

abstract class ExpensePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddExpense extends ExpensePageEvent {
  final ExpenseModel exp;
  AddExpense({required this.exp});
}

class RemoveExpense extends ExpensePageEvent {
  final String datatime;
  RemoveExpense({required this.datatime});
}

class InitExpense extends ExpensePageEvent {}
