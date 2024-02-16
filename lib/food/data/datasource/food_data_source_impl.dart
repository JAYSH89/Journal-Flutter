import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/data/local/food_entity.dart';

@Injectable(as: FoodDataSource)
class FoodDataSourceImpl extends FoodDataSource {
  FoodDataSourceImpl({required this.database});

  final Isar database;

  @override
  Future<List<FoodEntity>> getAll() async {
    return database.collection<FoodEntity>().where().findAll();
  }

  @override
  Future<FoodEntity?> getFoodById(int id) {
    return database.foodEntitys.get(id);
  }

  @override
  Future<List<FoodEntity>> searchFoodByName(String name) {
    return database.foodEntitys //
        .filter()
        .nameContains(name)
        .findAll();
  }

  @override
  Future<FoodEntity?> saveFood(FoodEntity food) async {
    return await database.writeTxn(() async {
      final savedId = await database.foodEntitys.put(food);
      return database.foodEntitys.get(savedId);
    });
  }

  @override
  Future<bool> deleteFood(int id) async {
    return await database.writeTxn(() async {
      return database.foodEntitys.delete(id);
    });
  }
}
