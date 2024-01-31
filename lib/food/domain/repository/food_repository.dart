import 'package:journal/food/domain/models/food.dart';

abstract class FoodRepository {
  List<Food> getAll();

  Food? getFoodById(String id);

  List<Food> searchFoodByName(String name);

  Food updateFood(String id, Food food);

  Food saveFood(Food food);

  deleteFood(String id);
}
