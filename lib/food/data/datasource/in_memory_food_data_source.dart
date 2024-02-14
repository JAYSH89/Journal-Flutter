import 'package:journal/core/errors/exceptions.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:uuid/uuid.dart';
import 'package:fpdart/fpdart.dart';

class InMemoryFoodDataSource implements FoodDataSource {
  List<Food> foods = List<Food>.empty(growable: true);

  @override
  List<Food> getAll() => foods;

  @override
  Food? getFoodById(String id) {
    final result = foods.filter((t) => t.id == id);
    if (result.isEmpty) return null;

    return result.first;
  }

  @override
  List<Food> searchFoodByName(String name) {
    if (name.isEmpty) return [];

    final query = name.toLowerCase();
    final result = foods.where(
      (food) => food.name.toLowerCase().contains(query),
    );

    return result.toList();
  }

  @override
  Food updateFood(String id, Food food) {
    final toUpdate = foods.where((food) => food.id == id).toList().firstOrNull;

    if (toUpdate == null) {
      throw InMemoryNotFoundException('update food: $id not found');
    }

    foods = List.from(foods)..remove(toUpdate);
    final updatedFood = Food(
      id: toUpdate.id,
      name: food.name,
      carbs: food.carbs,
      proteins: food.proteins,
      fats: food.fats,
      amount: food.amount,
      unit: food.unit,
    );
    foods.add(updatedFood);
    return updatedFood;
  }

  @override
  Food saveFood(Food food) {
    final String id = const Uuid().v8();
    final newFood = Food(
      id: id,
      name: food.name,
      carbs: food.carbs,
      proteins: food.proteins,
      fats: food.fats,
      amount: food.amount,
      unit: food.unit,
    );
    foods.add(newFood);
    return newFood;
  }

  @override
  deleteFood(String id) {
    final toDelete = foods.where((food) => food.id == id).toList();
    if (toDelete.isNotEmpty) {
      foods = List.from(foods)..remove(toDelete.first);
      return;
    }

    throw InMemoryNotFoundException('delete food: $id not found');
  }
}
