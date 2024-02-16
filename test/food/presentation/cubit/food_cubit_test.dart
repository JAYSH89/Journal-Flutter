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
    id: 1,
    name: "Apple",
    carbs: 1,
    proteins: 2,
    fats: 3,
    amount: 1,
    foodUnit: FoodUnit.portion,
  );

  group("Food cubit test", () {
    blocTest<FoodCubit, FoodState>(
      "getAllFood should update state with food",
      build: () {
        when(foodRepository.getAll()).thenAnswer((_) async => [testFood]);
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
        when(foodRepository.deleteFood(id: testFood.id!))
            .thenAnswer((_) async => true);
        when(foodRepository.getAll()).thenAnswer((_) async => [testFood]);
        return foodCubit;
      },
      act: (_) {
        foodCubit.deleteFood(id: testFood.id!);
      },
      verify: (_) {
        verify(foodRepository.deleteFood(id: testFood.id!)).called(1);
        verify(foodRepository.getAll()).called(1);
        verifyNoMoreInteractions(foodRepository);
      },
    );
  });
}
