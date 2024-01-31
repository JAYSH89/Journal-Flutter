import 'package:journal/core/errors/exceptions.dart';
import 'package:journal/food/data/datasource/in_memory_food_data_source.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InMemoryFoodDataSource datasource;

  setUp(() {
    datasource = InMemoryFoodDataSource();
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
      final expected = datasource.saveFood(testFood);

      // act
      final result = datasource.getAll();

      // assert
      expect(result, isA<List<Food>>());
      expect(result, equals([expected]));
    });

    test('should return empty list of no food', () {
      final result = datasource.getAll();

      expect(result, equals(List<Food>.empty()));
      expect(result, isA<List<Food>>());
    });
  });

  group('getFoodById()', () {
    test('should return Food when list contains food with id', () {
      // arrange
      final expected = datasource.saveFood(testFood);

      // act
      final result = datasource.getFoodById(expected.id!);

      // assert
      expect(result, equals(expected));
      expect(result, isA<Food>());
    });

    test('should return null if list not contains food id', () {
      final result = datasource.getFoodById("non existing id");
      expect(result, isNull);
    });
  });

  group('searchFoodByName()', () {
    test('should return list of food if list contains query', () {
      // arrange
      final savedFood = datasource.saveFood(testFood);

      // act
      final result = datasource.searchFoodByName(savedFood.name);

      // assert
      expect(result, equals([savedFood]));
    });

    test('should query successful ignoring capitalized characters query', () {
      // arrange
      final savedFood = datasource.saveFood(testFood);
      final capitalizedSavedFood = savedFood.name.toUpperCase();

      // act
      final result = datasource.searchFoodByName(capitalizedSavedFood);

      // assert
      expect(result, equals([savedFood]));
    });

    test('should return empty list if list does not contain query', () {
      // arrange
      datasource.saveFood(testFood);

      // act
      final result = datasource.searchFoodByName('non existent name');

      // assert
      expect(result, equals([]));
    });

    test('should return empty list if query is empty string', () {
      // arrange
      datasource.saveFood(testFood);

      // act
      final result = datasource.searchFoodByName('');

      // assert
      expect(result, equals([]));
    });
  });

  group('updateFood()', () {
    test('should update food successful with id unchanged', () {
      // arrange
      final savedFood = datasource.saveFood(testFood);
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
      final result = datasource.updateFood(savedFood.id!, foodToUpdate);

      // assert
      expect(result.id, equals(savedFood.id));
      expect(result.name, equals(updatedFoodName));
    });

    test('should throw InMemoryNotFoundException if id not in list', () {
      expect(
        () => datasource.updateFood("non existent id", testFood),
        throwsA(isA<InMemoryNotFoundException>()),
      );
    });
  });

  group('saveFood()', () {
    test('save food should generate uuid', () {
      // arrange + act
      final result = datasource.saveFood(testFood);

      // assert
      expect(result.id, isNotNull);
    });
  });

  group('deleteFood()', () {
    test('should delete food successful', () {
      // arrange
      final newFood = datasource.saveFood(testFood);

      // act
      datasource.deleteFood(newFood.id!);
      final result = datasource.getFoodById(newFood.id!);

      // assert
      expect(result, isNull);
    });

    test('should throw InMemoryNotFoundException if id not in list', () {
      expect(
        () => datasource.deleteFood("non existent id"),
        throwsA(isA<InMemoryNotFoundException>()),
      );
    });
  });
}
