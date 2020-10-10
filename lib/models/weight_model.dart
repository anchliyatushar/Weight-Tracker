import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'weight_model.g.dart';

enum WeightStatus { Initial, Loading, Success, Error }

@JsonSerializable()
class WeightModel {
  @JsonKey(ignore: true)
  final WeightStatus status;
  final String id;
  final double height;
  final double weight;
  final DateTime selectedDate;
  final String timestamp;

  const WeightModel({
    @required this.status,
    @required this.id,
    @required this.height,
    @required this.weight,
    @required this.timestamp,
    @required this.selectedDate,
  });

  @override
  List<Object> get props => [id, height, weight, timestamp, selectedDate];

  factory WeightModel.fromJson(Map<dynamic, dynamic> json) =>
      _$WeightModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeightModelToJson(this);
  WeightModel copyWith({
    final double height,
    final double weight,
    final String id,
    final DateTime selectedDate,
    final WeightStatus status,
  }) {
    return WeightModel(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      selectedDate: selectedDate ?? this.selectedDate,
      id: id ?? this.id,
      status: status ?? this.status,
      timestamp: this.timestamp,
    );
  }
}
