import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:fpdart/fpdart.dart';

class InMemoryFoodDataSource implements FoodDataSource {
  List<Food> foods = List<Food>.empty(growable: true);
  List<FoodEntity> foodEntities = List<FoodEntity>.empty(growable: true);

  @override
  Future<List<FoodEntity>> getAll() async => foodEntities;

  @override
  Future<FoodEntity?> getFoodById(int id) async {
    final result = foodEntities.filter((t) => t.id == id);
    if (result.isEmpty) return null;

    return result.first;
  }

  @override
  Future<List<FoodEntity>> searchFoodByName(String name) async {
    if (name.isEmpty) return [];

    final query = name.toLowerCase();
    final result = foodEntities.where(
      (food) => food.name.toLowerCase().contains(query),
    );

    return result.toList();
  }

  @override
  Future<FoodEntity?> saveFood(FoodEntity food) async {
    final exists = foodEntities //
        .where((food) => food.id == food.id)
        .toList()
        .firstOrNull;

    if (exists != null) {
      return _updateFood(currentFood: exists, newFood: food);
    }

    final newFood = FoodEntity(
      id: _generateId(),
      name: food.name,
      carbs: food.carbs,
      proteins: food.proteins,
      fats: food.fats,
      amount: food.amount,
      foodUnit: food.foodUnit,
    );

    foodEntities.add(newFood);
    return newFood;
  }

  @override
  Future<bool> deleteFood(int id) async {
    final toDelete = foodEntities.where((food) => food.id == id).toList();
    if (toDelete.isNotEmpty) {
      foodEntities = List.from(foodEntities)..remove(toDelete.first);
      return true;
    }

    return false;
  }

  FoodEntity _updateFood({
    required FoodEntity currentFood,
    required FoodEntity newFood,
  }) {
    foodEntities = List.from(foodEntities)..remove(currentFood);

    final updatedFood = FoodEntity(
      id: currentFood.id,
      name: newFood.name,
      carbs: newFood.carbs,
      proteins: newFood.proteins,
      fats: newFood.fats,
      amount: newFood.amount,
      foodUnit: newFood.foodUnit,
    );

    foodEntities.add(updatedFood);
    return updatedFood;
  }

  int _generateId() {
    if (foods.isEmpty) return 1;
    final ids = foodEntities.map((e) => e.id).toList();
    final maxId = ids.reduce((left, right) => left! > right! ? left : right);
    return maxId! + 1;
  }
}
