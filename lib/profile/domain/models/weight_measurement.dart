import 'package:freezed_annotation/freezed_annotation.dart';

part 'weight_measurement.freezed.dart';

@freezed
class WeightMeasurement with _$WeightMeasurement {
  factory WeightMeasurement({
    final String? id,
    required int weight,
    required DateTime measuredAt,
  }) = _WeightMeasurement;
}
