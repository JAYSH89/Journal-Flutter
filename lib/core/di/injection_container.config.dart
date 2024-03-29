// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i5;
import 'package:journal/food/data/datasource/food_data_source.dart' as _i3;
import 'package:journal/food/data/datasource/food_data_source_impl.dart' as _i4;
import 'package:journal/food/data/repository/food_repository_impl.dart' as _i7;
import 'package:journal/food/domain/repository/food_repository.dart' as _i6;
import 'package:journal/food/presentation/cubit/create_food_cubit.dart' as _i16;
import 'package:journal/food/presentation/cubit/food_cubit.dart' as _i17;
import 'package:journal/journal/data/datasource/in_memory_journal_data_source.dart'
    as _i9;
import 'package:journal/journal/data/datasource/journal_data_source.dart'
    as _i8;
import 'package:journal/journal/data/repository/journal_repository_impl.dart'
    as _i11;
import 'package:journal/journal/domain/repository/journal_repository.dart'
    as _i10;
import 'package:journal/profile/data/datasource/in_memory_user_detail_data_source.dart'
    as _i13;
import 'package:journal/profile/data/datasource/in_memory_weight_measurement_data_source.dart'
    as _i15;
import 'package:journal/profile/data/datasource/user_details_data_source.dart'
    as _i12;
import 'package:journal/profile/data/datasource/weight_measurement_data_source.dart'
    as _i14;
import 'package:journal/profile/data/repository/profile_repository_impl.dart'
    as _i19;
import 'package:journal/profile/domain/repository/profile_repository.dart'
    as _i18;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.FoodDataSource>(
        () => _i4.FoodDataSourceImpl(database: gh<_i5.Isar>()));
    gh.factory<_i6.FoodRepository>(
        () => _i7.FoodRepositoryImpl(dataSource: gh<_i3.FoodDataSource>()));
    gh.factory<_i8.JournalDataSource>(() => _i9.InMemoryJournalDataSource());
    gh.factory<_i10.JournalRepository>(() =>
        _i11.JournalRepositoryImpl(dataSource: gh<_i8.JournalDataSource>()));
    gh.factory<_i12.UserDetailsDataSource>(
        () => _i13.InMemoryUserDetailDataSource());
    gh.factory<_i14.WeightMeasurementDataSource>(
        () => _i15.InMemoryWeightMeasurementDataSource());
    gh.factory<_i16.CreateFoodCubit>(
        () => _i16.CreateFoodCubit(gh<_i6.FoodRepository>()));
    gh.factory<_i17.FoodCubit>(() => _i17.FoodCubit(gh<_i6.FoodRepository>()));
    gh.factory<_i18.ProfileRepository>(() => _i19.ProfileRepositoryImpl(
          weightMeasurementDataSource: gh<_i14.WeightMeasurementDataSource>(),
          userDetailsDataSource: gh<_i12.UserDetailsDataSource>(),
        ));
    return this;
  }
}
