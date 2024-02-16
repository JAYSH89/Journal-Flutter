import 'package:injectable/injectable.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/repository/food_repository.dart';

@Injectable(as: FoodRepository)
class FoodRepositoryImpl implements FoodRepository {
  FoodRepositoryImpl({required this.dataSource});

  final FoodDataSource dataSource;

  @override
  Stream<List<Food>> watchAll() => dataSource //
      .watchAll()
      .map((event) => event.map((foodEntity) {
            return foodEntity.toFood();
          }).toList());

  @override
  Future<List<Food>> getAll() => dataSource //
      .getAll()
      .then((entityList) => entityList.map((foodEntity) {
            return foodEntity.toFood();
          }).toList());

  @override
  Future<Food?> getFoodById({required int id}) => dataSource //
      .getFoodById(id)
      .then((value) => value?.toFood());

  @override
  Future<List<Food>> searchFoodByName({required String name}) => dataSource //
      .searchFoodByName(name)
      .then((entityList) => entityList.map((foodEntity) {
            return foodEntity.toFood();
          }).toList());

  @override
  Future<Food?> saveFood(Food food) => dataSource
      .saveFood(FoodEntity.fromFood(food: food))
      .then((value) => value?.toFood());

  @override
  Future<bool> deleteFood({required int id}) => dataSource.deleteFood(id);
}
