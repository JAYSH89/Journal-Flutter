import 'package:isar/isar.dart';
import 'package:journal/food/domain/models/food_unit.dart';

part 'food_entity.g.dart';

@collection
@Name("FoodEntity")
class FoodEntity {
  FoodEntity({
    this.id,
    required this.carbs,
    required this.proteins,
    required this.fats,
    required this.amount,
    required this.foodUnit,
  });

  @Name("id")
  Id? id;

  @Name("carbs")
  double carbs;

  @Name("proteins")
  double proteins;

  @Name("fats")
  double fats;

  @Name("amount")
  double amount;

  @Enumerated(EnumType.name)
  @Name("food_unit")
  FoodUnit foodUnit;
}
