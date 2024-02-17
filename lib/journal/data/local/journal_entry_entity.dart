import 'package:isar/isar.dart';
import 'package:journal/food/data/local/food_entity.dart';

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
}
