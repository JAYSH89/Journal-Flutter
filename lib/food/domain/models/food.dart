import 'package:journal/food/domain/models/food_unit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'food.freezed.dart';

@freezed
class Food with _$Food {
  factory Food({
    String? id,
    required String name,
    required double carbs,
    required double proteins,
    required double fats,
    required double amount,
    required FoodUnit unit,
  }) = _Food;
}

extension FoodExtension on Food {
  double calories() {
    final caloricFats = fats * 9;
    final caloricCarbs = carbs * 4;
    final caloricProteins = proteins * 4;
    final total = caloricCarbs + caloricProteins + caloricFats;
    return num.parse(total.toStringAsFixed(2)).toDouble();
  }

  double get percentageFats {
    final caloricFats = fats * 9;
    return caloricFats / calories();
  }

  double get percentageCarbs {
    final caloricCarbs = carbs * 4;
    return caloricCarbs / calories();
  }

  double get percentageProteins {
    final caloricProteins = proteins * 4;
    return caloricProteins / calories();
  }
}
