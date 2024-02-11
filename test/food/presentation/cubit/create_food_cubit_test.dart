import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/food/presentation/cubit/create_food_cubit.dart';

void main() {
  late CreateFoodCubit createFoodCubit;

  setUp(() {
    createFoodCubit = CreateFoodCubit();
  });

  tearDown(() {
    createFoodCubit.close();
  });

  group('Create food cubit', () {
    blocTest<CreateFoodCubit, CreateFoodState>(
      "setText updates the state with the correct text for a given key",
      build: () => createFoodCubit,
      act: (cubit) => cubit.setText(CreateFoodTextFieldKey.name, "Apple"),
      expect: () => [
        const CreateFoodState(
          fields: {CreateFoodTextFieldKey.name: "Apple"},
          unit: FoodUnit.gram,
        ),
      ],
    );

    blocTest<CreateFoodCubit, CreateFoodState>(
      "setUnit updates the state with the correct Unit",
      build: () => createFoodCubit,
      act: (cubit) => cubit.setUnit(FoodUnit.unit),
      expect: () => [
        const CreateFoodState(fields: {}, unit: FoodUnit.unit),
      ],
    );
  });
}
