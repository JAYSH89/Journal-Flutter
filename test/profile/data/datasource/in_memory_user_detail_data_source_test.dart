import 'package:journal/profile/data/datasource/in_memory_user_detail_data_source.dart';
import 'package:journal/profile/data/datasource/user_details_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/profile/domain/models/user_detail.dart';

void main() {
  late UserDetailsDataSource dataSource;

  setUp(() {
    dataSource = InMemoryUserDetailDataSource();
  });

  final UserDetail testUserDetail = UserDetail(
    firstName: 'example first name',
    lastName: 'example last name',
    email: 'user@example.com',
    dateOfBirth: DateTime.parse("1989-06-10T00:00:00Z"),
  );

  group('getUserDetail()', () {
    test('getUserDetail() successful should return UserDetail', () {
      // arrange
      dataSource.saveUserDetail(testUserDetail);

      // act
      final result = dataSource.getUserDetail();

      // assert
      expect(result, equals(testUserDetail));
    });
  });

  group('saveUserDetail()', () {
    test('saveUserDetail successful should override user detail', () async {
      // arrange + act
      final result = await dataSource.saveUserDetail(testUserDetail);

      // assert
      expect(result, equals(testUserDetail));
    });
  });

  group('clear()', () {
    test('clear should remove all user detail properties', () async {
      // arrange
      await dataSource.saveUserDetail(testUserDetail);

      // act
      dataSource.clear();
      final result = dataSource.getUserDetail();

      // assert
      expect(result.firstName, isNull);
      expect(result.lastName, isNull);
      expect(result.email, isNull);
      expect(result.dateOfBirth, isNull);
    });
  });
}
