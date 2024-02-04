import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';
import 'package:journal/profile/domain/repository/weight_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final WeightMeasurementDataSource weightMeasurementDataSource;

  ProfileRepositoryImpl({required this.weightMeasurementDataSource});

  @override
  List<WeightMeasurement> getAllWeightMeasurements() {
    return weightMeasurementDataSource.getAll();
  }

  @override
  WeightMeasurement saveWeightMeasurement(WeightMeasurement measurement) {
    return weightMeasurementDataSource.save(measurement);
  }

  @override
  deleteWeightMeasurement(String id) {
    weightMeasurementDataSource.delete(id);
  }
}
