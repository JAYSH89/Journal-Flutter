class WeightMeasurement {
  final String? id;
  final int weight;
  final DateTime measuredAt;

  const WeightMeasurement({
    this.id,
    required this.weight,
    required this.measuredAt,
  });
}
