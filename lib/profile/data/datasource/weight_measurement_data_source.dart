import 'package:journal/profile/domain/models/weight_measurement.dart';

abstract class WeightMeasurementDataSource {
  List<WeightMeasurement> getAll();
  WeightMeasurement save(WeightMeasurement measurement);
  delete(String id);
}
