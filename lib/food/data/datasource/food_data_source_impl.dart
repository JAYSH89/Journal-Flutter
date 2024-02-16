import 'package:isar/isar.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';

class FoodDataSourceImpl extends FoodDataSource {
  FoodDataSourceImpl({required this.database});

  final Isar database;

  final deleteMe = Food(
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    unit: FoodUnit.gram,
  );

  @override
  deleteFood(String id) {}

  @override
  List<Food> getAll() {
    return [deleteMe];
  }

  @override
  Food? getFoodById(String id) {
    return null;
  }

  @override
  Food saveFood(Food food) {
    return deleteMe;
  }

  @override
  List<Food> searchFoodByName(String name) {
    return [deleteMe];
  }

  @override
  Food updateFood(String id, Food food) {
    return deleteMe;
  }
}
