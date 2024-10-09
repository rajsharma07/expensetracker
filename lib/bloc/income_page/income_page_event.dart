import 'package:equatable/equatable.dart';
import 'package:expensetracker/models/income_model.dart';

abstract class IncomePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddIncome extends IncomePageEvent {
  final IncomeModel income;
  AddIncome({required this.income});
}

class RemoveIncome extends IncomePageEvent {
  final String datatime;
  RemoveIncome({required this.datatime});
}

class InitIncome extends IncomePageEvent {}
