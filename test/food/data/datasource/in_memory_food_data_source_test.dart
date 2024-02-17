import 'package:journal/food/data/datasource/in_memory_food_data_source.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InMemoryFoodDataSource dataSource;

  setUp(() {
    dataSource = InMemoryFoodDataSource();
  });

  final potatoEntity = FoodEntity(
    name: "Potato",
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    foodUnit: FoodUnit.portion,
  );

  // TODO [watchAll()] TESTS:
  // group("watchAll()", () {
  // test("should emit when save FoodEntity", () async {
  //   final List<FoodEntity> expectedList = [potatoEntity];
  //   expectLater(dataSource.watchAll(), emits(expectedList));
  //
  //   await dataSource.saveFood(potatoEntity);
  // });
  //
  // test("should emit when update FoodEntity", () async {
  //   // arrange
  //   await dataSource.saveFood(potatoEntity);
  //
  //   final updatedEntity = FoodEntity(
  //     id: 1,
  //     name: "Updated",
  //     carbs: 23.2,
  //     proteins: 3.1,
  //     fats: 0.1,
  //     amount: 1,
  //     foodUnit: FoodUnit.portion,
  //   );
  //   final List<FoodEntity> expectedList = [updatedEntity];
  //
  //   // act + assert
  //   expectLater(dataSource.watchAll(), emits(expectedList));
  //   await dataSource.saveFood(updatedEntity);
  // });
  //
  // test("should emit when delete FoodEntity", () async {
  //   // arrange
  //   await dataSource.saveFood(potatoEntity);
  //
  //   final List<FoodEntity> expectedList = [];
  //
  //   // act + assert
  //   expectLater(dataSource.watchAll(), emits(expectedList));
  //   await dataSource.deleteFood(1);
  // });
  // });

  group('getAll()', () {
    test('should return list of food successful', () async {
      // arrange
      await dataSource.saveFood(potatoEntity);

      // act
      final result = await dataSource.getAll();

      // assert
      expect(result.length, equals(1));
    });

    test('should return empty list of no food', () async {
      final result = await dataSource.getAll();

      expect(result, equals(List<FoodEntity>.empty()));
    });
  });

  group('getFoodById()', () {
    test('should return FoodEntity when list contains id', () async {
      // arrange
      await dataSource.saveFood(potatoEntity);

      // act
      final result = await dataSource.getFoodById(1);

      // assert
      expect(result, isNotNull);
      expect(result, isA<FoodEntity>());
    });

    test('should return null if list not contains food id', () async {
      final result = await dataSource.getFoodById(-1);
      expect(result, isNull);
    });
  });

  group('searchFoodByName()', () {
    test('should return list of food if list contains query', () async {
      // arrange
      final savedFood = await dataSource.saveFood(potatoEntity);

      // act
      final result = await dataSource.searchFoodByName("Potato");

      // assert
      expect(result, equals([savedFood]));
    });

    test('should query successful ignoring capitalized characters query',
        () async {
      // arrange
      final savedFood = await dataSource.saveFood(potatoEntity);
      const capitalizedSavedFood = "POTATO";

      // act
      final result = await dataSource.searchFoodByName(capitalizedSavedFood);

      // assert
      expect(result, equals([savedFood]));
    });

    test('should return empty list if list does not contain query', () async {
      // arrange
      await dataSource.saveFood(potatoEntity);

      // act
      final result = await dataSource.searchFoodByName('non existent name');

      // assert
      expect(result.length, equals(0));
    });

    test('should return empty list if query is empty string', () async {
      // arrange
      await dataSource.saveFood(potatoEntity);

      // act
      final result = await dataSource.searchFoodByName("");

      // assert
      expect(result.length, equals(0));
    });
  });

  group('saveFood()', () {
    test('saving FoodEntity should generate ID', () async {
      // arrange + act
      final result = await dataSource.saveFood(potatoEntity);

      // assert
      expect(result?.id, isNotNull);
    });

    test('saving same ID updates FoodEntity', () async {
      // arrange
      final savedFood = await dataSource.saveFood(potatoEntity);

      final foodToUpdate = FoodEntity(
        id: savedFood!.id,
        name: "UPDATED NAME",
        carbs: savedFood.carbs,
        proteins: savedFood.proteins,
        fats: savedFood.fats,
        amount: savedFood.amount,
        foodUnit: savedFood.foodUnit,
      );

      // act
      final result = await dataSource.saveFood(foodToUpdate);

      // assert
      expect(result!.id, equals(savedFood.id));
      expect(result.name, equals("UPDATED NAME"));
    });
  });

  group('deleteFood()', () {
    test('should delete food successful returns true', () async {
      // arrange
      await dataSource.saveFood(potatoEntity);

      // act
      final result = await dataSource.deleteFood(1);
      final getFood = await dataSource.getFoodById(1);

      // assert
      expect(result, true);
      expect(getFood, isNull);
    });

    test('should return false if id not in list', () async {
      //act
      final result = await dataSource.deleteFood(1);

      // assert
      expect(result, false);
    });
  });
}
