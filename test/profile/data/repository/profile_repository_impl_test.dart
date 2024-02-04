import 'package:journal/profile/data/repository/profile_repository_impl.dart';
import 'package:journal/profile/domain/models/user_detail.dart';
import 'package:journal/profile/domain/models/weight_measurement.dart';
import 'package:journal/profile/domain/repository/profile_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeightMeasurementDataSource weightMeasurementDataSource;
  late MockUserDetailsDataSource userDetailsDataSource;
  late ProfileRepository repository;

  setUp(() {
    weightMeasurementDataSource = MockWeightMeasurementDataSource();
    userDetailsDataSource = MockUserDetailsDataSource();

    repository = ProfileRepositoryImpl(
      weightMeasurementDataSource: weightMeasurementDataSource,
      userDetailsDataSource: userDetailsDataSource,
    );
  });

  WeightMeasurement testMeasurement = WeightMeasurement(
    weight: 80,
    measuredAt: DateTime.parse("2024-01-31T17:23:02Z"),
  );

  final UserDetail testUserDetail = UserDetail(
    firstName: 'example first name',
    lastName: 'example last name',
    email: 'user@example.com',
    dateOfBirth: DateTime.parse("1989-06-10T00:00:00Z"),
  );

  group('getUserDetails()', () {
    test('get UserDetails successful', () {
      // arrange
      when(userDetailsDataSource.getUserDetail()).thenAnswer((_) {
        return testUserDetail;
      });

      // act
      final result = repository.getUserDetails();

      // assert
      expect(result, equals(testUserDetail));
      verify(userDetailsDataSource.getUserDetail());
      verifyNoMoreInteractions(userDetailsDataSource);
    });
  });

  group('saveUserDetails()', () {
    test('save UserDetails successful', () async {
      // arrange
      when(userDetailsDataSource.saveUserDetail(any)).thenAnswer((_) async {
        return testUserDetail;
      });

      // act
      final result = await repository.saveUserDetails(testUserDetail);

      // assert
      expect(result, equals(testUserDetail));
      verify(userDetailsDataSource.saveUserDetail(any));
      verifyNoMoreInteractions(userDetailsDataSource);
    });
  });

  group('clearUserDetails()', () {
    test('clear UserDetails successful', () {
      // arrange
      when(userDetailsDataSource.clear()).thenAnswer((_) {});

      // act
      repository.clearUserDetails();

      // assert
      verify(userDetailsDataSource.clear());
      verifyNoMoreInteractions(userDetailsDataSource);
    });
  });

  group('ProfileRepository getAllWeightMeasurements()', () {
    test('get all weightMeasurement successful', () {
      // arrange
      when(weightMeasurementDataSource.getAll())
          .thenAnswer((_) => [testMeasurement]);

      // act
      final result = repository.getAllWeightMeasurements();

      // assert
      expect(result, equals([testMeasurement]));
      verify(weightMeasurementDataSource.getAll());
      verifyNoMoreInteractions(weightMeasurementDataSource);
    });
  });

  group('ProfileRepository saveWeightMeasurement()', () {
    test('save weightMeasurement successful', () {
      // arrange
      when(weightMeasurementDataSource.save(any))
          .thenAnswer((_) => testMeasurement);

      // act
      final result = repository.saveWeightMeasurement(testMeasurement);

      // assert
      expect(result, equals(testMeasurement));
      verify(weightMeasurementDataSource.save(testMeasurement));
      verifyNoMoreInteractions(weightMeasurementDataSource);
    });
  });

  group('ProfileRepository deleteWeightMeasurement()', () {
    test('save weightMeasurement successful', () {
      // arrange
      const testId = "test id";
      when(weightMeasurementDataSource.delete(any)).thenAnswer((_) {});

      // act
      repository.deleteWeightMeasurement(testId);

      // assert
      verify(weightMeasurementDataSource.delete(testId));
      verifyNoMoreInteractions(weightMeasurementDataSource);
    });
  });
}
