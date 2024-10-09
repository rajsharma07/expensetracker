import 'package:equatable/equatable.dart';
import 'package:expensetracker/models/loan_given.dart';

class LoanPageState extends Equatable {
  final List<LoanGiven> loans;
  const LoanPageState({this.loans = const []});

  LoanPageState copyWith({List<LoanGiven>? loans}) {
    return LoanPageState(loans: loans ?? this.loans);
  }

  @override
  List<Object> get props => [];
}
