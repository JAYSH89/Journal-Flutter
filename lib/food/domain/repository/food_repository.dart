import 'package:journal/food/domain/models/food.dart';

abstract class FoodRepository {
  Stream<List<Food>> watchAll();

  Future<List<Food>> getAll();

  Future<Food?> getFoodById({required int id});

  Future<List<Food>> searchFoodByName({required String name});

  Future<Food?> saveFood(Food food);

  Future<bool> deleteFood({required int id});
}
