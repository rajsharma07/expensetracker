import 'package:equatable/equatable.dart';
import 'package:expensetracker/models/debt.dart';

abstract class DebtPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddDebtEvent extends DebtPageEvent {
  final Debt debt;
  AddDebtEvent({required this.debt});
}

class RemoveDebtEvent extends DebtPageEvent {
  final String datetime;
  RemoveDebtEvent({required this.datetime});
}

class Initdebt extends DebtPageEvent {}
