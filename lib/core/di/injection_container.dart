import 'package:get_it/get_it.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/data/datasource/in_memory_food_data_source.dart';
import 'package:journal/food/data/repository/food_repository_impl.dart';
import 'package:journal/food/domain/repository/food_repository.dart';
import 'package:journal/profile/data/datasource/in_memory_weight_measurement_data_source.dart';
import 'package:journal/profile/data/datasource/user_detail_data_source_impl.dart';
import 'package:journal/profile/data/datasource/user_details_data_source.dart';
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:journal/profile/data/repository/profile_repository_impl.dart';
import 'package:journal/profile/domain/repository/weight_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // repository
  getIt.registerLazySingleton<FoodRepository>(() {
    return FoodRepositoryImpl(dataSource: getIt());
  });

  getIt.registerLazySingleton<ProfileRepository>(() {
    return ProfileRepositoryImpl(weightMeasurementDataSource: getIt());
  });

  // data source
  getIt.registerLazySingleton<FoodDataSource>(() {
    return InMemoryFoodDataSource();
  });

  getIt.registerLazySingleton<UserDetailsDataSource>(() {
    return UserDetailDataSourceImpl(sharedPreferences: getIt());
  });

  getIt.registerLazySingleton<WeightMeasurementDataSource>(() {
    return InMemoryWeightMeasurementDataSource();
  });

  // other
  getIt.registerLazySingleton(() async {
    return await SharedPreferences.getInstance();
  });
}
