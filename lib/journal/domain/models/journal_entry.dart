import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal/food/domain/models/food.dart';

part 'journal_entry.freezed.dart';

@freezed
class JournalEntry with _$JournalEntry {
  factory JournalEntry({
    int? id,
    required Food food,
    required DateTime date,
    required double amount,
  }) = _JournalEntry;
}

extension JournalEntryExtension on JournalEntry {
  double getFats() => amount * food.fats / food.amount;

  double getProteins() => amount * food.proteins / food.amount;

  double getCarbs() => amount * food.carbs / food.amount;

  double getCalories() {
    final caloricFats = getFats() * 9;
    final caloricCarbs = getCarbs() * 4;
    final caloricProteins = getProteins() * 4;
    final total = caloricCarbs + caloricProteins + caloricFats;
    return num.parse(total.toStringAsFixed(2)).toDouble();
  }
}
