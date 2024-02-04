import 'package:journal/profile/data/repository/weight_repository_impl.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';
import 'package:journal/profile/domain/repository/weight_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeightMeasurementDataSource dataSource;
  late WeightRepository repository;

  setUp(() {
    dataSource = MockWeightMeasurementDataSource();
    repository = WeightRepositoryImpl(dataSource: dataSource);
  });

  WeightMeasurement testMeasurement = WeightMeasurement(
    weight: 80,
    measuredAt: DateTime.parse("2024-01-31T17:23:02Z"),
  );

  group('WeightRepository getAll()', () {
    test('get all successful', () {
      // arrange
      when(dataSource.getAll()).thenAnswer((_) => [testMeasurement]);

      // act
      final result = repository.getAll();

      // assert
      expect(result, equals([testMeasurement]));
      verify(dataSource.getAll());
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('WeightRepository save()', () {
    test('save measurement successful', () {
      // arrange
      when(dataSource.save(any)).thenAnswer((_) => testMeasurement);

      // act
      final result = repository.save(testMeasurement);

      // assert
      expect(result, equals(testMeasurement));
      verify(dataSource.save(testMeasurement));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('WeightRepository delete()', () {
    test('', () {
      // arrange
      const testId = "test id";
      when(dataSource.delete(any)).thenAnswer((_) {});

      // act
      repository.delete(testId);

      // assert
      verify(dataSource.delete(testId));
      verifyNoMoreInteractions(dataSource);
    });
  });
}
