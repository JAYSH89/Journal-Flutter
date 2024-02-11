import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/food/presentation/cubit/create_food_cubit.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late CreateFoodCubit createFoodCubit;
  late MockFoodRepository foodRepository;

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

  final testFood = Food(
    id: "example id",
    name: "Apple",
    carbs: 1,
    proteins: 2,
    fats: 3,
    amount: 1,
    unit: FoodUnit.unit,
  );

  setUp(() {
    foodRepository = MockFoodRepository();
    createFoodCubit = CreateFoodCubit(foodRepository);
  });

  tearDown(() {
    createFoodCubit.close();
  });

  void createFoodCubitHelper({
    required String description,
    required Map<CreateFoodTextFieldKey, String> inputs,
    required FoodUnit foodUnit,
    required CreateFoodState expectedState,
    Function(Cubit)? verify,
    int skip = 0,
  }) {
    blocTest<CreateFoodCubit, CreateFoodState>(
      description,
      build: () {
        when(foodRepository.saveFood(any)).thenReturn(testFood);
        return createFoodCubit;
      },
      act: (cubit) {
        inputs.forEach((key, value) {
          cubit.setText(key, value);
        });
        cubit.setUnit(foodUnit);
        cubit.submit();
      },
      skip: skip,
      expect: () => [expectedState],
      verify: verify,
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
      verify: (_) {
        verify(foodRepository.saveFood(any)).called(1);
        verifyNoMoreInteractions(foodRepository);
      },
    );

    createFoodCubitHelper(
      description: "submit negative amount should formValid false",
      inputs: Map.from(testState.fields)..[CreateFoodTextFieldKey.carbs] = "-1",
      foodUnit: FoodUnit.unit,
      skip: 6,
      expectedState: testState.copyWith(
        fields: Map.from(testState.fields)
          ..[CreateFoodTextFieldKey.carbs] = "-1",
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
        formValid: false,
      ),
    );

    blocTest(
      "get all food successful should update list food",
      build: () {
        when(foodRepository.getAll()).thenReturn([testFood]);
        return createFoodCubit;
      },
      act: (cubit) {
        cubit.getAllFood();
      },
      expect: () => [
        CreateFoodState(food: [testFood])
      ],
    );

    blocTest(
      "reset should revert state back to initial state",
      build: () => createFoodCubit,
      act: (cubit) {
        cubit.reset();
      },
      expect: () => [const CreateFoodState()],
    );
  });
}
