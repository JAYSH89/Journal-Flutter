import 'package:injectable/injectable.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/repository/food_repository.dart';

@Injectable(as: FoodRepository)
class FoodRepositoryImpl implements FoodRepository {
  FoodRepositoryImpl({required this.dataSource});

  final FoodDataSource dataSource;

  @override
  List<Food> getAll() => dataSource.getAll();

  @override
  Food? getFoodById(String id) => dataSource.getFoodById(id);

  @override
  List<Food> searchFoodByName(String name) => dataSource.searchFoodByName(name);

  @override
  Food updateFood(String id, Food food) => dataSource.updateFood(id, food);

  @override
  Food saveFood(Food food) => dataSource.saveFood(food);

  @override
  deleteFood(String id) {
    dataSource.deleteFood(id);
  }
}
