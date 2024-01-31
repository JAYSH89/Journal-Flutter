import 'package:journal/food/domain/models/food_unit.dart';
import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String? id;
  final String name;
  final double carbs;
  final double proteins;
  final double fats;
  final double amount;
  final FoodUnit unit;

  const Food({
    this.id,
    required this.name,
    required this.carbs,
    required this.proteins,
    required this.fats,
    required this.amount,
    required this.unit,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        carbs,
        proteins,
        fats,
        amount,
        unit,
      ];
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
