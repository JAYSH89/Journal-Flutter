import 'package:journal/food/data/repository/food_repository_impl.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFoodDataSource datasource;
  late FoodRepositoryImpl repository;

  setUp(() {
    datasource = MockFoodDataSource();
    repository = FoodRepositoryImpl(dataSource: datasource);
  });

  final potato = Food(
    id: const Uuid().v8(),
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    unit: FoodUnit.gram,
  );

  test('get all successful', () {
    // arrange
    when(datasource.getAll()).thenAnswer((_) => [potato]);

    // act
    final result = repository.getAll();

    // assert
    expect(result, equals([potato]));
    verify(datasource.getAll());
    verifyNoMoreInteractions(datasource);
  });

  test('get food by id', () {
    // arrange
    when(datasource.getFoodById(any)).thenAnswer((_) => potato);

    // act
    final result = repository.getFoodById(potato.id!);

    // assert
    expect(result, equals(potato));
    verify(datasource.getFoodById(potato.id!));
    verifyNoMoreInteractions(datasource);
  });

  test('search food by name', () {
    // arrange
    when(datasource.searchFoodByName(any)).thenAnswer((_) => [potato]);

    // act
    final result = repository.searchFoodByName("potato");

    // assert
    expect(result, equals([potato]));
    verify(datasource.searchFoodByName(any));
    verifyNoMoreInteractions(datasource);
  });

  test('update food', () {
    // arrange
    when(datasource.updateFood(any, any)).thenAnswer((_) => potato);

    // act
    final result = repository.updateFood(potato.id!, potato);

    // assert
    expect(result, equals(potato));
    verify(datasource.updateFood(potato.id!, potato));
    verifyNoMoreInteractions(datasource);
  });

  test('save food', () {
    // arrange
    when(datasource.saveFood(potato)).thenAnswer((_) => potato);

    // act
    final result = repository.saveFood(potato);

    // assert
    expect(result, equals(potato));
    verify(datasource.saveFood(potato));
    verifyNoMoreInteractions(datasource);
  });

  test('delete food', () {
    // arrange
    when(datasource.deleteFood(any)).thenAnswer((_) {});

    // act
    repository.deleteFood(potato.id!);

    // assert
    verify(datasource.deleteFood(potato.id!));
    verifyNoMoreInteractions(datasource);
  });
}
