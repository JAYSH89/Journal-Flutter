import 'package:journal/profile/domain/models/weight_measurement.dart';

abstract class ProfileRepository {
  List<WeightMeasurement> getAllWeightMeasurements();

  WeightMeasurement saveWeightMeasurement(WeightMeasurement measurement);

  deleteWeightMeasurement(String id);
}
