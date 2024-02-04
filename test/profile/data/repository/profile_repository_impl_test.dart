import 'package:journal/profile/data/repository/profile_repository_impl.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';
import 'package:journal/profile/domain/repository/weight_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeightMeasurementDataSource dataSource;
  late ProfileRepository repository;

  setUp(() {
    dataSource = MockWeightMeasurementDataSource();
    repository = ProfileRepositoryImpl(weightMeasurementDataSource: dataSource);
  });

  WeightMeasurement testMeasurement = WeightMeasurement(
    weight: 80,
    measuredAt: DateTime.parse("2024-01-31T17:23:02Z"),
  );

  group('ProfileRepository getAllWeightMeasurements()', () {
    test('get all weightMeasurement successful', () {
      // arrange
      when(dataSource.getAll()).thenAnswer((_) => [testMeasurement]);

      // act
      final result = repository.getAllWeightMeasurements();

      // assert
      expect(result, equals([testMeasurement]));
      verify(dataSource.getAll());
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('ProfileRepository saveWeightMeasurement()', () {
    test('save weightMeasurement successful', () {
      // arrange
      when(dataSource.save(any)).thenAnswer((_) => testMeasurement);

      // act
      final result = repository.saveWeightMeasurement(testMeasurement);

      // assert
      expect(result, equals(testMeasurement));
      verify(dataSource.save(testMeasurement));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('ProfileRepository deleteWeightMeasurement()', () {
    test('save weightMeasurement successful', () {
      // arrange
      const testId = "test id";
      when(dataSource.delete(any)).thenAnswer((_) {});

      // act
      repository.deleteWeightMeasurement(testId);

      // assert
      verify(dataSource.delete(testId));
      verifyNoMoreInteractions(dataSource);
    });
  });
}
