import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../model/weight_model.dart';

@immutable
abstract class WeightState extends Equatable {}

class InitialState extends WeightState{
  @override

  List<Object?> get props => [];

}

class WeightAdding extends WeightState {
  @override
  List<Object?> get props => [];
}

class WeightAdded extends WeightState{
  @override
  List<Object?> get props =>[];

}

class WeightError extends WeightState {
  final String error;

  WeightError(this.error);
  @override
  List<Object?> get props => [error];
}

class WeightLoading extends WeightState {
  @override
  List<Object?> get props =>[];

}

class WeightLoaded extends WeightState {
  late List<WeightModel> myData;
  WeightLoaded(this.myData);
  @override
  List<Object?> get props =>[myData];

}
class WeightDeleting extends WeightState {
  @override
  List<Object?> get props =>[];

}

class WeightDeleted extends WeightState {
  @override
  List<Object?> get props =>[];

}