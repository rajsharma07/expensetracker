import 'package:equatable/equatable.dart';
import 'package:expensetracker/models/income_model.dart';

class IncomePageState extends Equatable {
  final List<IncomeModel> incomes;

  const IncomePageState({this.incomes = const []});
  IncomePageState copywith({List<IncomeModel>? l}) {
    return IncomePageState(incomes: l ?? incomes);
  }

  @override
  List<Object> get props => [incomes];
}
