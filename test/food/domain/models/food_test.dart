import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final food = Food(
    name: 'Potato',
    carbs: 23.2,
    proteins: 3.1,
    fats: 0.1,
    amount: 1,
    unit: FoodUnit.gram,
  );

  test('get calories from Food() class', () {
    expect(food.calories(), equals(106.1));
  });

  test('get percentages on total calories', () {
    final fatsPercentage = food.percentageFats;
    final carbsPercentage = food.percentageCarbs;
    final proteinsPercentage = food.percentageProteins;

    expect(fatsPercentage, equals(0.008482563619227146));
    expect(carbsPercentage, equals(0.8746465598491989));
    expect(proteinsPercentage, equals(0.11687087653157399));
    expect(fatsPercentage + carbsPercentage + proteinsPercentage, equals(1));
  });
}
