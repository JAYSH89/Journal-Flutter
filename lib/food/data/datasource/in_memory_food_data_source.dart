import 'dart:async';

import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:fpdart/fpdart.dart';

class InMemoryFoodDataSource implements FoodDataSource {
  List<FoodEntity> foods = List<FoodEntity>.empty(growable: true);
  final _foodsStreamController = StreamController<List<FoodEntity>>.broadcast();

  InMemoryFoodDataSource() {
    _foodsStreamController.add(foods);
  }

  @override
  Stream<List<FoodEntity>> watchAll() {
    return _foodsStreamController.stream;
  }

  @override
  Future<List<FoodEntity>> getAll() async => foods;

  @override
  Future<FoodEntity?> getFoodById(int id) async {
    final result = foods.filter((t) => t.id == id);
    if (result.isEmpty) return null;

    return result.first;
  }

  @override
  Future<List<FoodEntity>> searchFoodByName(String name) async {
    if (name.isEmpty) return [];

    final query = name.toLowerCase();
    final result = foods.where(
      (food) => food.name.toLowerCase().contains(query),
    );

    return result.toList();
  }

  @override
  Future<FoodEntity?> saveFood(FoodEntity food) async {
    final exists = foods //
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

    foods.add(newFood);
    _foodsStreamController.add(List<FoodEntity>.from(foods));
    return newFood;
  }

  @override
  Future<bool> deleteFood(int id) async {
    final toDelete = foods.where((food) => food.id == id).toList();
    if (toDelete.isNotEmpty) {
      foods = List.from(foods)..remove(toDelete.first);
      _foodsStreamController.add(List<FoodEntity>.from(foods));
      return true;
    }

    return false;
  }

  FoodEntity _updateFood({
    required FoodEntity currentFood,
    required FoodEntity newFood,
  }) {
    foods = List.from(foods)..remove(currentFood);

    final updatedFood = FoodEntity(
      id: currentFood.id,
      name: newFood.name,
      carbs: newFood.carbs,
      proteins: newFood.proteins,
      fats: newFood.fats,
      amount: newFood.amount,
      foodUnit: newFood.foodUnit,
    );

    foods.add(updatedFood);
    _foodsStreamController.add(List<FoodEntity>.from(foods));
    return updatedFood;
  }

  int _generateId() {
    if (foods.isEmpty) return 1;
    final ids = foods.map((e) => e.id).toList();
    final maxId = ids.reduce((left, right) => left! > right! ? left : right);
    return maxId! + 1;
  }
}
