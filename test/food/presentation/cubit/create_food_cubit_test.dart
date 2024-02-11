import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/food/presentation/cubit/create_food_cubit.dart';

void main() {
  late CreateFoodCubit createFoodCubit;

  const testState = CreateFoodState(
    fields: {
      CreateFoodTextFieldKey.name: "Apple",
      CreateFoodTextFieldKey.carbs: "1",
      CreateFoodTextFieldKey.proteins: "2",
      CreateFoodTextFieldKey.fats: "3",
      CreateFoodTextFieldKey.amount: "1",
    },
    unit: FoodUnit.unit,
    formValid: true,
  );

  setUp(() {
    createFoodCubit = CreateFoodCubit();
  });

  tearDown(() {
    createFoodCubit.close();
  });

  void createFoodCubitHelper({
    required String description,
    required Map<CreateFoodTextFieldKey, String> inputs,
    required FoodUnit foodUnit,
    required CreateFoodState expectedState,
    int skip = 0,
  }) {
    blocTest<CreateFoodCubit, CreateFoodState>(
      description,
      build: () => CreateFoodCubit(),
      act: (cubit) {
        inputs.forEach((key, value) {
          cubit.setText(key, value);
        });
        cubit.setUnit(foodUnit);
        cubit.submit();
      },
      skip: skip,
      expect: () => [expectedState],
    );
  }

  group('Create food cubit', () {
    blocTest<CreateFoodCubit, CreateFoodState>("Test initial state",
        build: () => createFoodCubit,
        verify: (cubit) {
          const expected = CreateFoodState(
            fields: {},
            unit: FoodUnit.gram,
            formValid: null,
          );
          expect(cubit.state, equals(expected));
        });

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

    createFoodCubitHelper(
      description: "submit with valid inputs should true",
      inputs: testState.fields,
      foodUnit: FoodUnit.unit,
      skip: 6,
      expectedState: testState.copyWith(
        fields: testState.fields,
        unit: FoodUnit.unit,
        formValid: true,
      ),
    );

    createFoodCubitHelper(
      description: "submit negative amount should formValid false",
      inputs: Map.from(testState.fields)..[CreateFoodTextFieldKey.carbs] = "-1",
      foodUnit: FoodUnit.unit,
      skip: 6,
      expectedState: testState.copyWith(
        fields: Map.from(testState.fields)
          ..[CreateFoodTextFieldKey.carbs] = "-1",
        unit: FoodUnit.unit,
        formValid: false,
      ),
    );

    createFoodCubitHelper(
      description: "submit without carb values should formValid false",
      inputs: Map.from(testState.fields)..remove(CreateFoodTextFieldKey.carbs),
      foodUnit: FoodUnit.unit,
      skip: 5,
      expectedState: testState.copyWith(
        fields: Map.from(testState.fields)
          ..remove(CreateFoodTextFieldKey.carbs),
        unit: FoodUnit.unit,
        formValid: false,
      ),
    );

    createFoodCubitHelper(
      description: "submit empty name should formValid false",
      inputs: Map.from(testState.fields)..[CreateFoodTextFieldKey.name] = "",
      foodUnit: FoodUnit.unit,
      skip: 6,
      expectedState: testState.copyWith(
        fields: Map.from(testState.fields)..[CreateFoodTextFieldKey.name] = "",
        unit: FoodUnit.unit,
        formValid: false,
      ),
    );
  });
}
