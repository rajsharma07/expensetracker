import 'package:equatable/equatable.dart';

class ExpState extends Equatable {
  final int currentscreen;
  const ExpState({this.currentscreen = 0});
  ExpState copywith({int? currentscreen}) {
    return ExpState(currentscreen: currentscreen ?? this.currentscreen);
  }

  @override
  List<Object> get props => [currentscreen];
}
