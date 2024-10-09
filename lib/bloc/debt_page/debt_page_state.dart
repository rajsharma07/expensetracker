import 'package:equatable/equatable.dart';
import 'package:expensetracker/models/debt.dart';

class DebtPageState extends Equatable {
  final List<Debt> debts;
  const DebtPageState({this.debts = const []});

  DebtPageState copyWith({List<Debt>? debts}) {
    return DebtPageState(debts: debts ?? this.debts);
  }

  @override
  List<Object> get props => [];
}
