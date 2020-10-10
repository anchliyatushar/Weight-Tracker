// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightModel _$WeightModelFromJson(Map<String, dynamic> json) {
  return WeightModel(
    id: json['id'] as String,
    height: (json['height'] as num)?.toDouble(),
    weight: (json['weight'] as num)?.toDouble(),
    timestamp: json['timestamp'] as String,
    selectedDate: json['selectedDate'] == null
        ? null
        : DateTime.parse(json['selectedDate'] as String),
  );
}

Map<String, dynamic> _$WeightModelToJson(WeightModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'height': instance.height,
      'weight': instance.weight,
      'selectedDate': instance.selectedDate?.toIso8601String(),
      'timestamp': instance.timestamp,
    };
