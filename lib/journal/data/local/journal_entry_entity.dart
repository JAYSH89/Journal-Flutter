import 'package:isar/isar.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';

part 'journal_entry_entity.g.dart';

@collection
@Name("JournalEntryEntity")
class JournalEntryEntity {
  @Name("id")
  Id? id;

  @Name("food")
  final food = IsarLink<FoodEntity>();

  @Name("date")
  late DateTime date;

  @Name("amount")
  late double amount;

  static JournalEntryEntity fromJournalEntry({required JournalEntry entry}) {
    return JournalEntryEntity()
      ..id = entry.id
      ..food.value = FoodEntity.fromFood(food: entry.food)
      ..date = entry.date
      ..amount = entry.amount;
  }
}

extension JournalEntryEntityMapper on JournalEntryEntity {
  JournalEntry toJournalEntry() => JournalEntry(
        id: id,
        food: food.value!.toFood(),
        date: date,
        amount: amount,
      );
}
