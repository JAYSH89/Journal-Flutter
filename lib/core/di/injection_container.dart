import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void _configureDependencies() => getIt.init();

Future<Isar> _openIsar() async {
  Directory dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [FoodEntitySchema],
    directory: dir.path,
  );
}

void setupInjection() async {
  _configureDependencies();

  getIt.registerSingletonAsync<Isar>(
    () async => await _openIsar(),
    dispose: (isar) => isar.close(),
  );

  getIt.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
}

// // other
// getIt.registerLazySingletonAsync<SharedPreferences>(() async {
//   return await SharedPreferences.getInstance();
// });
//
// getIt.registerLazySingletonAsync<Isar>(() async {
//   final dir = await getApplicationDocumentsDirectory();
//   return await Isar.open(
//     [FoodEntitySchema],
//     directory: dir.path,
//   );
// });
//
// // data source
// getIt.registerSingletonAsync<FoodDataSource>(() async {
//   // return InMemoryFoodDataSource();
//   return FoodDataSourceImpl(database: getIt<Isar>());
// });
//
// getIt.registerSingletonAsync<JournalDataSource>(() async {
//   return InMemoryJournalDataSource();
// });
//
// getIt.registerSingletonAsync<UserDetailsDataSource>(() async {
//   return UserDetailDataSourceImpl(
//     sharedPreferences: getIt<SharedPreferences>(),
//   );
// });
//
// getIt.registerSingletonAsync<WeightMeasurementDataSource>(() async {
//   return InMemoryWeightMeasurementDataSource();
// });
//
// // repository
// getIt.registerSingletonAsync<FoodRepository>(() async {
//   return FoodRepositoryImpl(dataSource: getIt<FoodDataSource>());
// });
//
// getIt.registerSingletonAsync<ProfileRepository>(() async {
//   return ProfileRepositoryImpl(
//     weightMeasurementDataSource: getIt<WeightMeasurementDataSource>(),
//     userDetailsDataSource: getIt<UserDetailsDataSource>(),
//   );
// });
//
// getIt.registerSingletonAsync<JournalRepository>(() async {
//   return JournalRepositoryImpl(dataSource: getIt<JournalDataSource>());
// });
//
// // bloc
// getIt.registerFactory<FoodCubit>(() {
//   return FoodCubit(getIt<FoodRepository>());
// });
//
// getIt.registerFactory<CreateFoodCubit>(() {
//   return CreateFoodCubit(getIt<FoodRepository>());
// });
//
// await getIt.allReady();
// }
