import 'package:journal/core/errors/exceptions.dart';
import 'package:journal/food/data/datasource/in_memory_food_data_source.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InMemoryFoodDataSource dataSource;

  setUp(() {
    dataSource = InMemoryFoodDataSource();
  });

  const testFood = Food(
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    unit: FoodUnit.unit,
  );

  group('getAll()', () {
    test('should return list of food successful', () {
      // arrange
      final expected = dataSource.saveFood(testFood);

      // act
      final result = dataSource.getAll();

      // assert
      expect(result, isA<List<Food>>());
      expect(result, equals([expected]));
    });

    test('should return empty list of no food', () {
      final result = dataSource.getAll();

      expect(result, equals(List<Food>.empty()));
      expect(result, isA<List<Food>>());
    });
  });

  group('getFoodById()', () {
    test('should return Food when list contains food with id', () {
      // arrange
      final expected = dataSource.saveFood(testFood);

      // act
      final result = dataSource.getFoodById(expected.id!);

      // assert
      expect(result, equals(expected));
      expect(result, isA<Food>());
    });

    test('should return null if list not contains food id', () {
      final result = dataSource.getFoodById("non existing id");
      expect(result, isNull);
    });
  });

  group('searchFoodByName()', () {
    test('should return list of food if list contains query', () {
      // arrange
      final savedFood = dataSource.saveFood(testFood);

      // act
      final result = dataSource.searchFoodByName(savedFood.name);

      // assert
      expect(result, equals([savedFood]));
    });

    test('should query successful ignoring capitalized characters query', () {
      // arrange
      final savedFood = dataSource.saveFood(testFood);
      final capitalizedSavedFood = savedFood.name.toUpperCase();

      // act
      final result = dataSource.searchFoodByName(capitalizedSavedFood);

      // assert
      expect(result, equals([savedFood]));
    });

    test('should return empty list if list does not contain query', () {
      // arrange
      dataSource.saveFood(testFood);

      // act
      final result = dataSource.searchFoodByName('non existent name');

      // assert
      expect(result, equals([]));
    });

    test('should return empty list if query is empty string', () {
      // arrange
      dataSource.saveFood(testFood);

      // act
      final result = dataSource.searchFoodByName('');

      // assert
      expect(result, equals([]));
    });
  });

  group('updateFood()', () {
    test('should update food successful with id unchanged', () {
      // arrange
      final savedFood = dataSource.saveFood(testFood);
      const updatedFoodName = "update name";

      final foodToUpdate = Food(
        id: "this id should not be updated",
        name: updatedFoodName,
        carbs: savedFood.carbs,
        proteins: savedFood.proteins,
        fats: savedFood.fats,
        amount: savedFood.amount,
        unit: savedFood.unit,
      );

      // act
      final result = dataSource.updateFood(savedFood.id!, foodToUpdate);

      // assert
      expect(result.id, equals(savedFood.id));
      expect(result.name, equals(updatedFoodName));
    });

    test('should throw InMemoryNotFoundException if id not in list', () {
      expect(
        () => dataSource.updateFood("non existent id", testFood),
        throwsA(isA<InMemoryNotFoundException>()),
      );
    });
  });

  group('saveFood()', () {
    test('save food should generate uuid for id field', () {
      // arrange + act
      final result = dataSource.saveFood(testFood);

      // assert
      expect(result.id, isNotNull);
    });
  });

  group('deleteFood()', () {
    test('should delete food successful', () {
      // arrange
      final newFood = dataSource.saveFood(testFood);

      // act
      dataSource.deleteFood(newFood.id!);
      final result = dataSource.getFoodById(newFood.id!);

      // assert
      expect(result, isNull);
    });

    test('should throw InMemoryNotFoundException if id not in list', () {
      expect(
        () => dataSource.deleteFood("non existent id"),
        throwsA(isA<InMemoryNotFoundException>()),
      );
    });
  });
}
