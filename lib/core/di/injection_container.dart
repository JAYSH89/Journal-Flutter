import 'package:get_it/get_it.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/data/datasource/in_memory_food_data_source.dart';
import 'package:journal/food/data/repository/food_repository_impl.dart';
import 'package:journal/food/domain/repository/food_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // repository
  getIt.registerLazySingleton<FoodRepository>(() {
    return FoodRepositoryImpl(dataSource: getIt());
  });

  // data source
  getIt.registerLazySingleton<FoodDataSource>(() {
    return InMemoryFoodDataSource();
  });
}
