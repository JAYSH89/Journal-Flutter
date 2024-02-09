import 'package:journal/food/domain/models/food.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';

void main() {
  final potato = Food(
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    unit: FoodUnit.gram,
  );

  final journalEntry = JournalEntry(
    id: "id",
    food: potato,
    date: DateTime.parse("2024-01-31T17:23:02Z"),
    amount: 2,
  );

  group('JournalEntryExtension:', () {
    test('should return fats relative to food.fats', () {
      final fats = journalEntry.getFats();
      expect(fats, equals(0.2));
    });

    test('should return protein relative to food.protein', () {
      final fats = journalEntry.getProteins();
      expect(fats, equals(6.2));
    });

    test('should return carbs relative to food.carbs', () {
      final carbs = journalEntry.getCarbs();
      expect(carbs, equals(46.4));
    });

    test('should calculate calories successful', () {
      final calories = journalEntry.getCalories();
      expect(calories, equals(212.2));
    });
  });
}
