import 'package:isar/isar.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';

part 'food_entity.g.dart';

@collection
@Name("FoodEntity")
class FoodEntity {
  FoodEntity({
    this.id,
    required this.name,
    required this.carbs,
    required this.proteins,
    required this.fats,
    required this.amount,
    required this.foodUnit,
  });

  @Name("id")
  Id? id;

  @Name("name")
  String name;

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

  static FoodEntity fromFood({required Food food}) => FoodEntity(
        id: food.id,
        name: food.name,
        carbs: food.carbs,
        proteins: food.proteins,
        fats: food.fats,
        amount: food.amount,
        foodUnit: food.foodUnit,
      );
}

extension FoodEntityMapper on FoodEntity {
  Food toFood() => Food(
        id: id,
        name: name,
        carbs: carbs,
        proteins: proteins,
        fats: fats,
        amount: amount,
        foodUnit: foodUnit,
      );
}
