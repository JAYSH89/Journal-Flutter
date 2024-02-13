import 'package:get_it/get_it.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/data/datasource/in_memory_food_data_source.dart';
import 'package:journal/food/data/repository/food_repository_impl.dart';
import 'package:journal/food/domain/repository/food_repository.dart';
import 'package:journal/food/presentation/cubit/create_food_cubit.dart';
import 'package:journal/food/presentation/cubit/food_cubit.dart';
import 'package:journal/journal/data/datasource/in_memory_journal_data_source.dart';
import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/journal/data/repository/journal_repository_impl.dart';
import 'package:journal/journal/domain/repository/journal_repository.dart';
import 'package:journal/profile/data/datasource/in_memory_weight_measurement_data_source.dart';
import 'package:journal/profile/data/datasource/user_detail_data_source_impl.dart';
import 'package:journal/profile/data/datasource/user_details_data_source.dart';
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart';
import 'package:journal/profile/data/repository/profile_repository_impl.dart';
import 'package:journal/profile/domain/repository/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // bloc
  getIt.registerFactory(() => FoodCubit(getIt()));
  getIt.registerFactory(() => CreateFoodCubit(getIt()));

  // repository
  getIt.registerLazySingleton<FoodRepository>(() => FoodRepositoryImpl(
        dataSource: getIt(),
      ));

  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
        weightMeasurementDataSource: getIt(),
        userDetailsDataSource: getIt(),
      ));

  getIt.registerLazySingleton<JournalRepository>(() {
    return JournalRepositoryImpl(dataSource: getIt());
  });

  // data source
  getIt.registerLazySingleton<FoodDataSource>(() => InMemoryFoodDataSource());

  getIt.registerLazySingleton<JournalDataSource>(() {
    return InMemoryJournalDataSource();
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
