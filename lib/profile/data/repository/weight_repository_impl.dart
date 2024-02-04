import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';
import 'package:journal/profile/domain/repository/weight_repository.dart';

class WeightRepositoryImpl extends WeightRepository {
  final WeightMeasurementDataSource dataSource;

  WeightRepositoryImpl({required this.dataSource});

  @override
  List<WeightMeasurement> getAll() {
    return dataSource.getAll();
  }

  @override
  WeightMeasurement save(WeightMeasurement measurement) {
    return dataSource.save(measurement);
  }

  @override
  delete(String id) {
    dataSource.delete(id);
  }
}
