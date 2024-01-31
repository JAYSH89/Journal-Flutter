import 'package:journal/core/errors/exceptions.dart';
import 'package:journal/profile/data/datasource/in_memory_weight_measurement_data_source.dart';
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';

void main() {
  late WeightMeasurementDataSource datasource;

  setUp(() {
    datasource = InMemoryWeightMeasurementDataSource();
  });

  final testWeightMeasurement = WeightMeasurement(
    weight: 80,
    measuredAt: DateTime.parse("2024-01-31T17:23:02Z"),
  );

  group('getAll()', () {
    test('get all successful', () {
      // arrange
      datasource.save(testWeightMeasurement);

      // act
      final result = datasource.getAll();

      // assert
      expect(result.length, equals(1));
      expect(result, isA<List<WeightMeasurement>>());
    });

    test('should return empty list if no elements', () {
      // act
      final result = datasource.getAll();

      // assert
      expect(result.isEmpty, equals(true));
      expect(result, isA<List<WeightMeasurement>>());
    });
  });

  group('save()', () {
    test('should save successful', () {
      // act
      datasource.save(testWeightMeasurement);
      final savedMeasurement = datasource.getAll().first;

      // assert
      expect(savedMeasurement.weight, testWeightMeasurement.weight);
      expect(savedMeasurement.measuredAt, testWeightMeasurement.measuredAt);
      expect(savedMeasurement, isA<WeightMeasurement>());
    });

    test('when save successful id should not be null', () {
      // act
      final result = datasource.save(testWeightMeasurement);

      // assert
      expect(result.id, isNotNull);
      expect(result, isA<WeightMeasurement>());
    });

    test('should throw InvalidInputException when weight < 0', () {
      // arrange
      final invalidMeasurement = WeightMeasurement(
        weight: -20,
        measuredAt: DateTime.parse("2024-01-31T17:23:02Z"),
      );

      // act + assert
      expect(
        () => datasource.save(invalidMeasurement),
        throwsA(isA<InvalidInputException>()),
      );
    });

    test('should throw InvalidInputException when DateTime already has value',
        () {
      datasource.save(testWeightMeasurement);

      expect(
        () => datasource.save(testWeightMeasurement),
        throwsA(isA<InvalidInputException>()),
      );
    });
  });

  group('delete()', () {
    test('should delete successful', () {
      // arrange
      final newMeasurement = datasource.save(testWeightMeasurement);

      // act
      datasource.delete(newMeasurement.id!);
      final result = datasource.getAll();

      // assert
      expect(result.isEmpty, equals(true));
    });

    test('should throw InMemoryNotFoundException id not found', () {
      // act + assert
      expect(
        () => datasource.delete('invalid id'),
        throwsA(isA<InMemoryNotFoundException>()),
      );
    });
  });
}
