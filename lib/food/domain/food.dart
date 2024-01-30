import 'package:journal/food/domain/food_unit.dart';

class Food {
  final String name;
  final double carbs;
  final double proteins;
  final double fats;
  final double amount;
  final FoodUnit unit;

  Food({
    required this.name,
    required this.carbs,
    required this.proteins,
    required this.fats,
    required this.amount,
    required this.unit,
  });
}

extension FoodExtension on Food {
  double calories() {
    final caloricFats = fats * 9;
    final caloricCarbs = carbs * 4;
    final caloricProteins = proteins * 4;
    final total = caloricCarbs + caloricProteins + caloricFats;
    return num.parse(total.toStringAsFixed(2)).toDouble();
  }
}
