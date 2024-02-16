import 'package:journal/food/data/local/food_entity.dart';

abstract class FoodDataSource {
  Stream<List<FoodEntity>> watchAll();

  Future<List<FoodEntity>> getAll();

  Future<FoodEntity?> getFoodById(int id);

  Future<List<FoodEntity>> searchFoodByName(String name);

  Future<FoodEntity?> saveFood(FoodEntity food);

  Future<bool> deleteFood(int id);
}
