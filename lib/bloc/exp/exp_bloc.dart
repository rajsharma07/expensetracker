import 'package:expensetracker/bloc/exp/exp_event.dart';
import 'package:expensetracker/bloc/exp/exp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpBloc extends Bloc<ExpEvent, ExpState> {
  ExpBloc() : super(const ExpState()) {
    on<ChangeEvent>(
      (event, emit) {
        emit(state.copywith(currentscreen: event.target));
      },
    );
  }
}
