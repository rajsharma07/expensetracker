import 'package:equatable/equatable.dart';
import 'package:expensetracker/models/loan_given.dart';

abstract class LoanPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddLoanEvent extends LoanPageEvent {
  final LoanGiven loan;
  AddLoanEvent({required this.loan});
}

class RemoveLoanEvent extends LoanPageEvent {
  final String datetime;
  RemoveLoanEvent({required this.datetime});
}

class InitLoan extends LoanPageEvent {}
