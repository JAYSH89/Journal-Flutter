import 'package:injectable/injectable.dart';
import 'package:journal/core/errors/exceptions.dart';
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';
import 'package:uuid/uuid.dart';

@Singleton(as: WeightMeasurementDataSource)
class InMemoryWeightMeasurementDataSource
    implements WeightMeasurementDataSource {
  List<WeightMeasurement> weightMeasurements =
      List<WeightMeasurement>.empty(growable: true);

  @override
  List<WeightMeasurement> getAll() => weightMeasurements;

  @override
  WeightMeasurement save(WeightMeasurement measurement) {
    if (measurement.weight < 0) {
      throw InvalidInputException("weight cannot be a negative value");
    }

    final measurementExists = weightMeasurements
        .where((element) => element.measuredAt == element.measuredAt)
        .toList();

    if (measurementExists.isNotEmpty) {
      throw InvalidInputException(
          "measurement with {$measurement.measuredAt} already exists");
    }

    final newMeasurement = WeightMeasurement(
      id: const Uuid().v8(),
      weight: measurement.weight,
      measuredAt: measurement.measuredAt,
    );

    weightMeasurements.add(newMeasurement);
    return newMeasurement;
  }

  @override
  delete(String id) {
    final toDelete = weightMeasurements
        .where((measurement) => measurement.id == id)
        .toList();

    if (toDelete.isNotEmpty) {
      weightMeasurements.remove(toDelete.first);
      return;
    }

    throw InMemoryNotFoundException('delete measurement: $id not found');
  }
}
