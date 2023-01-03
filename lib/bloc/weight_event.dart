import 'package:equatable/equatable.dart';


abstract class WeightEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Create extends WeightEvent {
  final String name;
  final String weight;

  Create(this.name, this.weight);

}

class GetData extends WeightEvent{
  GetData();
}

class DeleteData extends WeightEvent{
  DeleteData();
}