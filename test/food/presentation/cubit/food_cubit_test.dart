import 'package:bloc_test/bloc_test.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/food/presentation/cubit/food_cubit.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFoodRepository foodRepository;
  late FoodCubit foodCubit;

  setUp(() {
    foodRepository = MockFoodRepository();
    foodCubit = FoodCubit(foodRepository);
  });

  tearDown(() {
    foodCubit.close();
  });

  final testFood = Food(
    id: "example id",
    name: "Apple",
    carbs: 1,
    proteins: 2,
    fats: 3,
    amount: 1,
    unit: FoodUnit.portion,
  );

  group("Food cubit test", () {
    blocTest<FoodCubit, FoodState>(
      "getAllFood should update state with food",
      build: () {
        when(foodRepository.getAll()).thenReturn([testFood]);
        return foodCubit;
      },
      act: (_) {
        foodCubit.getAllFood();
      },
      expect: () => [
        FoodState(foods: [testFood]),
      ],
    );

    blocTest<FoodCubit, FoodState>(
      "deleteFood should delete and retrieve all food again",
      build: () {
        when(foodRepository.deleteFood(any)).thenAnswer((_) {});
        when(foodRepository.getAll()).thenReturn([testFood]);
        return foodCubit;
      },
      act: (_) {
        foodCubit.deleteFood(testFood.id!);
      },
      verify: (_) {
        verify(foodRepository.deleteFood(any)).called(1);
        verify(foodRepository.getAll()).called(1);
        verifyNoMoreInteractions(foodRepository);
      },
    );
  });
}
