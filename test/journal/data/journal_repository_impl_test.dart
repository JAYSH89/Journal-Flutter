import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/journal/data/local/journal_entry_entity.dart';
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
    id: 1,
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    foodUnit: FoodUnit.gram,
  );

  final journalEntryEntity = JournalEntryEntity()
    ..id = 1
    ..date = DateTime.parse("2024-01-31T17:23:02Z")
    ..food.value = FoodEntity.fromFood(food: potato)
    ..amount = 1.0;

  final journalEntry = JournalEntry(
    id: 1,
    food: potato,
    date: DateTime.parse("2024-01-31T17:23:02Z"),
    amount: 1.0,
  );

  group("JournalRepository getAll()", () {
    test("get all successful", () async {
      // arrange
      when(dataSource.getAll()).thenAnswer((_) async => [journalEntryEntity]);

      // act
      final result = await repository.getAll();

      // assert
      expect(result, equals([journalEntry]));
      verify(dataSource.getAll());
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository getById()", () {
    test("get food by id successful", () async {
      // arrange
      when(dataSource.getById(any)).thenAnswer((_) async => journalEntryEntity);

      // act
      final result = await repository.getById(1);

      // assert
      expect(result, equals(journalEntry));
      verify(dataSource.getById(any));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository getBetween()", () {
    test("successful", () async {
      // arrange
      when(dataSource.getBetween(any, any))
          .thenAnswer((_) async => [journalEntryEntity]);

      // act
      final start = DateTime.parse("2023-05-01T00:00:00Z");
      final end = DateTime.parse("2023-07-01T00:00:00Z");
      final result = await repository.getBetween(start, end);

      // assert
      expect(result, equals([journalEntry]));
      verify(dataSource.getBetween(any, any));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository save()", () {
    test("save successful", () async {
      // arrange
      when(dataSource.save(any)).thenAnswer((_) async => journalEntryEntity);

      // act
      final result = await repository.save(journalEntry);

      // assert
      expect(result, equals(journalEntry));
      verify(dataSource.save(any));
      verifyNoMoreInteractions(dataSource);
    });
  });

  group("JournalRepository delete()", () {
    test("delete successful", () async {
      // arrange
      when(dataSource.delete(any)).thenAnswer((_) async => true);

      // act
      await repository.delete(1);

      // assert
      verify(dataSource.delete(any));
      verifyNoMoreInteractions(dataSource);
    });
  });
}
