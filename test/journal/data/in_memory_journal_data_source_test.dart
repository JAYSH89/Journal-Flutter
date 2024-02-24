import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/journal/data/datasource/in_memory_journal_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/journal/data/local/journal_entry_entity.dart';

void main() {
  late InMemoryJournalDataSource dataSource;

  final potato = Food(
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    foodUnit: FoodUnit.gram,
  );

  final testJournalEntry = JournalEntryEntity()
    ..food.value = FoodEntity.fromFood(food: potato)
    ..date = DateTime.parse("2023-06-01T00:00:00Z")
    ..amount = 1.0;

  setUp(() {
    dataSource = InMemoryJournalDataSource();
  });

  group('getAll()', () {
    test('should return list of JournalEntryEntity', () async {
      // arrange
      final expected = await dataSource.save(testJournalEntry);

      // act
      final result = await dataSource.getAll();

      // assert
      expect(result, equals([expected]));
    });

    test('get all entries no elements should return empty list', () async {
      // arrange + act
      final result = await dataSource.getAll();

      // assert
      expect(result.length, equals(0));
    });
  });

  group('getById()', () {
    test('should return entry successful if list contains id', () async {
      // arrange
      await dataSource.save(testJournalEntry);

      // act
      final result = await dataSource.getById(1);

      // assert
      expect(result, isNotNull);
    });

    test('should return null if list not contains id', () async {
      final result = await dataSource.getById(-1);
      expect(result, isNull);
    });
  });

  group('getBetween()', () {
    test('should successfully JournalEntryEntity in range start end', () async {
      // arrange
      final start = DateTime.parse("2023-05-01T00:00:00Z");
      final end = DateTime.parse("2023-07-01T00:00:00Z");
      await dataSource.save(testJournalEntry);

      // act
      final result = await dataSource.getBetween(start, end);

      // assert
      expect(result.length, equals(1));
    });

    test('should return empty list if not in range start end', () async {
      // arrange
      final start = DateTime.parse("2023-06-01T00:00:00Z");
      final end = DateTime.parse("2023-06-08T00:00:00Z");

      // act
      final result = await dataSource.getBetween(start, end);

      // assert
      expect(result, equals(List.empty()));
    });

    test('should throw error if start > end', () {
      // arrange
      final start = DateTime.parse("2001-01-01T00:00:00Z");
      final end = DateTime.parse("2000-01-01T00:00:00Z");

      // act + assert
      expect(
        () async => await dataSource.getBetween(start, end),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('save()', () {
    test('save JournalEntryEntity successful', () async {
      // arrange + act
      final result = await dataSource.save(testJournalEntry);

      // assert
      expect(result!.id, equals(1));
    });

    test('saving same ID updates JournalEntryEntity', () async {
      // arrange
      final savedEntry = await dataSource.save(testJournalEntry);
      const double updatedAmount = 10.0;

      final entryToUpdate = JournalEntryEntity()
        ..id = savedEntry!.id
        ..date = savedEntry.date
        ..food.value = savedEntry.food.value
        ..amount = updatedAmount;

      // act
      final result = await dataSource.save(entryToUpdate);
      final total = await dataSource.getAll();

      // assert
      expect(result!.id, equals(savedEntry.id));
      expect(result.amount, equals(updatedAmount));
      expect(total.length, equals(1));
    });
  });

  group('delete()', () {
    test('should delete JournalEntryEntity successful', () async {
      // arrange
      await dataSource.save(testJournalEntry);

      // act
      final result = await dataSource.delete(1);
      final exists = await dataSource.getById(1);

      // assert
      expect(exists, isNull);
      expect(result, equals(true));
    });

    test('should return false if id not in list', () async {
      final result = await dataSource.delete(1);
      expect(result, false);
    });
  });
}
