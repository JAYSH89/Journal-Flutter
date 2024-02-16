import 'package:journal/core/errors/exceptions.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/journal/data/datasource/in_memory_journal_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';

void main() {
  late InMemoryJournalDataSource dataSource;

  setUp(() {
    dataSource = InMemoryJournalDataSource();
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

  group('getAll()', () {
    test('get all entries should return list of JournalEntry', () {
      // arrange
      final expected = dataSource.save(testJournalEntry);

      // act
      final result = dataSource.getAll();

      // assert
      expect(result, isA<List<JournalEntry>>());
      expect(result, equals([expected]));
    });

    test('get all entries no elements should return empty list', () {
      // arrange + act
      final result = dataSource.getAll();

      // assert
      expect(result, equals(List<JournalEntry>.empty()));
      expect(result, isA<List<JournalEntry>>());
    });
  });

  group('getById()', () {
    test('should return JournalEntry if list contains JournalEntry.id', () {
      // arrange
      final expected = dataSource.save(testJournalEntry);

      // act
      final result = dataSource.getById(expected.id!);

      // assert
      expect(result, equals(expected));
      expect(result, isA<JournalEntry>());
    });

    test('should return null if list not contains id', () {
      final result = dataSource.getById("non existing id");
      expect(result, isNull);
    });
  });

  group('getBetween()', () {
    test('should successfully return journal entries in range start end', () {
      // arrange
      final start = DateTime.parse("2023-05-01T00:00:00Z");
      final end = DateTime.parse("2023-07-01T00:00:00Z");
      dataSource.save(testJournalEntry);

      // act
      final result = dataSource.getBetween(start, end);

      // assert
      expect(result.length, equals(1));
    });

    test('should return empty list if no elements in range start end', () {
      // arrange
      final start = DateTime.parse("2023-06-01T00:00:00Z");
      final end = DateTime.parse("2023-06-08T00:00:00Z");

      // act
      final result = dataSource.getBetween(start, end);

      // assert
      expect(result, equals(List.empty()));
    });

    test('should throw error if start > end', () {
      // arrange
      final start = DateTime.parse("2001-01-01T00:00:00Z");
      final end = DateTime.parse("2000-01-01T00:00:00Z");

      // act + assert
      expect(
        () => dataSource.getBetween(start, end),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('update()', () {
    test('should update JournalEntry successful with id unchanged', () {
      // arrange
      final savedJournalEntry = dataSource.save(testJournalEntry);
      const double updatedAmount = 10.0;

      final journalEntryToUpdate = JournalEntry(
        food: potato,
        date: testJournalEntry.date,
        amount: updatedAmount,
      );

      // act
      final result = dataSource.update(
        savedJournalEntry.id!,
        journalEntryToUpdate,
      );

      // assert
      expect(result.id, equals(savedJournalEntry.id));
      expect(result.amount, equals(updatedAmount));
    });

    test('should throw InMemoryNotFoundException if id not in list', () {
      expect(
        () => dataSource.update("non existent id", testJournalEntry),
        throwsA(isA<InMemoryNotFoundException>()),
      );
    });
  });

  group('save()', () {
    test('save JournalEntry should generate UUID for id field', () {
      // arrange + act
      final result = dataSource.save(testJournalEntry);

      // assert
      expect(result.id, isNotNull);
    });
  });

  group('delete()', () {
    test('should delete journal entry successful', () {
      // arrange
      final newJournalEntry = dataSource.save(testJournalEntry);

      // act
      dataSource.delete(newJournalEntry.id!);
      final result = dataSource.getById(newJournalEntry.id!);

      // assert
      expect(result, isNull);
    });

    test('should throw InMemoryNotFoundException if id not in list', () {
      expect(
        () => dataSource.delete("non existent id"),
        throwsA(isA<InMemoryNotFoundException>()),
      );
    });
  });
}
