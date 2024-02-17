import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/food/data/repository/food_repository_impl.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFoodDataSource dataSource;
  late FoodRepositoryImpl repository;

  setUp(() {
    dataSource = MockFoodDataSource();
    repository = FoodRepositoryImpl(dataSource: dataSource);
  });

  final foodEntity = FoodEntity(
    id: 1,
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    foodUnit: FoodUnit.gram,
  );

  final potato = Food(
    id: 1,
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    foodUnit: FoodUnit.gram,
  );

  test('get all successful', () async {
    // arrange
    when(dataSource.getAll()).thenAnswer((_) async => [foodEntity]);

    // act
    final result = await repository.getAll();

    // assert
    expect(result, equals([potato]));
    verify(dataSource.getAll());
    verifyNoMoreInteractions(dataSource);
  });

  test('get food by id', () async {
    // arrange
    when(dataSource.getFoodById(any)).thenAnswer((_) async => foodEntity);

    // act
    final result = await repository.getFoodById(id: 1);

    // assert
    expect(result, equals(potato));
    verify(dataSource.getFoodById(potato.id!));
    verifyNoMoreInteractions(dataSource);
  });

  test('search food by name', () async {
    // arrange
    when(dataSource.searchFoodByName(any)).thenAnswer((_) async {
      return [foodEntity];
    });

    // act
    final result = await repository.searchFoodByName(name: "Potato");

    // assert
    expect(result, equals([potato]));
    verify(dataSource.searchFoodByName(any));
    verifyNoMoreInteractions(dataSource);
  });

  test('save food', () async {
    // arrange
    when(dataSource.saveFood(any)).thenAnswer((_) async => foodEntity);

    // act
    final result = await repository.saveFood(potato);

    // assert
    expect(result, equals(potato));
    verify(dataSource.saveFood(any));
    verifyNoMoreInteractions(dataSource);
  });

  test('delete food', () async {
    // arrange
    when(dataSource.deleteFood(any)).thenAnswer((_) async => true);

    // act
    await repository.deleteFood(id: 1);

    // assert
    verify(dataSource.deleteFood(any));
    verifyNoMoreInteractions(dataSource);
  });
}
