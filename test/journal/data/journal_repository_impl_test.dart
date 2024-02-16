import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/journal/data/repository/journal_repository_impl.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';
import 'package:journal/journal/domain/repository/journal_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockJournalDataSource dataSource;
  late JournalRepository repository;

  setUp(() {
    dataSource = MockJournalDataSource();
    repository = JournalRepositoryImpl(dataSource: dataSource);
  });

  final potato = Food(
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    foodUnit: FoodUnit.gram,
  );

  final testJournalEntry = JournalEntry(
    food: potato,
    date: DateTime.parse("2023-06-01T00:00:00Z"),
    amount: 1.0,
  );

  group("JournalRepository getAll()", () {
    test("get all successful", () {
      // arrange
      when(dataSource.getAll()).thenAnswer((_) => [testJournalEntry]);

      // act
      final result = repository.getAll();

      // assert
      expect(result, equals([testJournalEntry]));
      verify(dataSource.getAll());
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository getById()", () {
    test("get food by id successful", () {
      // arrange
      when(dataSource.getById(any)).thenAnswer((_) => testJournalEntry);

      // act
      final result = repository.getById("example id");

      // assert
      expect(result, equals(testJournalEntry));
      verify(dataSource.getById(any));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository getBetween()", () {
    test("getBetween successful", () {
      // arrange
      when(dataSource.getBetween(any, any))
          .thenAnswer((_) => [testJournalEntry]);

      // act
      final start = DateTime.parse("2023-05-01T00:00:00Z");
      final end = DateTime.parse("2023-07-01T00:00:00Z");
      final result = repository.getBetween(start, end);

      // assert
      expect(result, equals([testJournalEntry]));
      verify(dataSource.getBetween(any, any));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository update()", () {
    test("update successful", () {
      // arrange
      when(dataSource.update(any, testJournalEntry))
          .thenAnswer((_) => testJournalEntry);

      // act
      repository.update("id", testJournalEntry);

      // assert
      verify(dataSource.update("id", testJournalEntry));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository save()", () {
    test("save successful", () {
      // arrange
      when(dataSource.save(testJournalEntry))
          .thenAnswer((_) => testJournalEntry);

      // act
      repository.save(testJournalEntry);

      // assert
      verify(dataSource.save(any));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository delete()", () {
    test("delete successful", () {
      // arrange
      when(dataSource.delete(any)).thenAnswer((_) {});

      // act
      repository.delete("some id");

      // assert
      verify(dataSource.delete(any));
      verifyNoMoreInteractions(dataSource);
    });
  });
}
