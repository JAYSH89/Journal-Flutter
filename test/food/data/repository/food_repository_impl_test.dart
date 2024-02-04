import 'package:journal/food/data/repository/food_repository_impl.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFoodDataSource dataSource;
  late FoodRepositoryImpl repository;

  setUp(() {
    dataSource = MockFoodDataSource();
    repository = FoodRepositoryImpl(dataSource: dataSource);
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
    when(dataSource.getAll()).thenAnswer((_) => [potato]);

    // act
    final result = repository.getAll();

    // assert
    expect(result, equals([potato]));
    verify(dataSource.getAll());
    verifyNoMoreInteractions(dataSource);
  });

  test('get food by id', () {
    // arrange
    when(dataSource.getFoodById(any)).thenAnswer((_) => potato);

    // act
    final result = repository.getFoodById(potato.id!);

    // assert
    expect(result, equals(potato));
    verify(dataSource.getFoodById(potato.id!));
    verifyNoMoreInteractions(dataSource);
  });

  test('search food by name', () {
    // arrange
    when(dataSource.searchFoodByName(any)).thenAnswer((_) => [potato]);

    // act
    final result = repository.searchFoodByName("potato");

    // assert
    expect(result, equals([potato]));
    verify(dataSource.searchFoodByName(any));
    verifyNoMoreInteractions(dataSource);
  });

  test('update food', () {
    // arrange
    when(dataSource.updateFood(any, any)).thenAnswer((_) => potato);

    // act
    final result = repository.updateFood(potato.id!, potato);

    // assert
    expect(result, equals(potato));
    verify(dataSource.updateFood(potato.id!, potato));
    verifyNoMoreInteractions(dataSource);
  });

  test('save food', () {
    // arrange
    when(dataSource.saveFood(potato)).thenAnswer((_) => potato);

    // act
    final result = repository.saveFood(potato);

    // assert
    expect(result, equals(potato));
    verify(dataSource.saveFood(potato));
    verifyNoMoreInteractions(dataSource);
  });

  test('delete food', () {
    // arrange
    when(dataSource.deleteFood(any)).thenAnswer((_) {});

    // act
    repository.deleteFood(potato.id!);

    // assert
    verify(dataSource.deleteFood(potato.id!));
    verifyNoMoreInteractions(dataSource);
  });
}
