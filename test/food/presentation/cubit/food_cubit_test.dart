import 'package:bloc_test/bloc_test.dart';
import 'package:journal/food/data/datasource/food_data_source.dart';
import 'package:journal/food/data/datasource/in_memory_food_data_source.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/food/data/repository/food_repository_impl.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/food/domain/repository/food_repository.dart';
import 'package:journal/food/presentation/cubit/food_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FoodDataSource dataSource;
  late FoodRepository repository;
  late List<Food> mockFoods;
  late FoodEntity entity;
  late FoodCubit foodCubit;

  setUp(() async {
    dataSource = InMemoryFoodDataSource();
    entity = FoodEntity(
      id: 1,
      name: "Apple",
      carbs: 1,
      proteins: 2,
      fats: 3,
      amount: 1,
      foodUnit: FoodUnit.portion,
    );
    await dataSource.saveFood(entity);

    repository = FoodRepositoryImpl(dataSource: dataSource);
    foodCubit = FoodCubit(repository);

    mockFoods = [entity.toFood()];
  });

  group("Food cubit test", () {
    blocTest<FoodCubit, FoodState>(
      "emits FoodState on start",
      build: () => FoodCubit(repository),
      expect: () => [
        FoodState(foods: mockFoods, errorMessage: null),
      ],
    );

    blocTest<FoodCubit, FoodState>(
      "deleteFood should delete and update list",
      build: () => foodCubit,
      act: (_) async {
        foodCubit.deleteFood(id: 1);
      },
      expect: () => [
        const FoodState(foods: [], errorMessage: null),
      ],
    );
  });
}
