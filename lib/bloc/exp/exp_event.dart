import 'package:equatable/equatable.dart';

abstract class ExpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeEvent extends ExpEvent {
  final int target;
  ChangeEvent({required this.target});
}
