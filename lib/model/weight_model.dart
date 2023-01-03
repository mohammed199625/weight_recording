
class WeightModel {

  final String name;
  final String weight;
  WeightModel({
    required this.name,
    required this.weight});

  factory WeightModel.fromJson(Map<String, dynamic> json) {
    return WeightModel(
        name: json['name'],
        weight: json['weight']);
  }
}
