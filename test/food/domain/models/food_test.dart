import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get calories from Food() class', () {
    // arrange
    final food = Food(
      name: 'Potato',
      carbs: 23.2,
      proteins: 3.1,
      fats: 0.1,
      amount: 1,
      unit: FoodUnit.gram,
    );

    // act + assert
    expect(food.calories(), equals(106.1));
  });
}
