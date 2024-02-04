import 'package:equatable/equatable.dart';
import 'package:journal/food/domain/models/food.dart';

class JournalEntry extends Equatable {
  final String? id;
  final Food food;
  final DateTime date;
  final double amount;

  const JournalEntry({
    this.id,
    required this.food,
    required this.date,
    required this.amount,
  });

  @override
  List<Object?> get props => [
        id,
        food,
        date,
        amount,
      ];
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
