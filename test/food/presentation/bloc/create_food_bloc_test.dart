import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/food/presentation/bloc/create_food_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CreateFoodBloc createFoodBloc;

  setUp(() {
    createFoodBloc = CreateFoodBloc();
  });

  blocTest<CreateFoodBloc, CreateFoodState>(
    "should emit [Validated] when input valid",
    build: () => createFoodBloc,
    act: (bloc) {
      bloc.add(const CreateFoodEvent.submit(
        name: "Potato",
        carbs: "23.2",
        proteins: "3.1",
        fats: "0.1",
        amount: "1",
        unit: FoodUnit.unit,
      ));
    },
    expect: () => <CreateFoodState>[
      const CreateFoodState.validated(),
    ],
  );

  blocTest<CreateFoodBloc, CreateFoodState>(
    "should emit [ValidationError] when name is empty",
    build: () => createFoodBloc,
    act: (bloc) {
      bloc.add(const CreateFoodEvent.submit(
        name: "",
        carbs: "23.2",
        proteins: "3.1",
        fats: "0.1",
        amount: "1",
        unit: FoodUnit.unit,
      ));
    },
    expect: () => <CreateFoodState>[
      const CreateFoodState.validationError(
        validName: false,
        validCarbs: true,
        validProteins: true,
        validFats: true,
        validAmount: true,
      ),
    ],
  );

  blocTest<CreateFoodBloc, CreateFoodState>(
    "should emit [ValidationError] when macro input invalid string",
    build: () => createFoodBloc,
    act: (bloc) {
      bloc.add(const CreateFoodEvent.submit(
        name: "Potato",
        carbs: "invalid macro input",
        proteins: "3.1",
        fats: "0.1",
        amount: "1",
        unit: FoodUnit.unit,
      ));
    },
    expect: () {
      return <CreateFoodState>[
        const CreateFoodState.validationError(
          validName: true,
          validCarbs: false,
          validProteins: true,
          validFats: true,
          validAmount: true,
        ),
      ];
    },
  );

  blocTest<CreateFoodBloc, CreateFoodState>(
    "should emit [ValidationError] when macro input negative number",
    build: () => createFoodBloc,
    act: (bloc) {
      bloc.add(const CreateFoodEvent.submit(
        name: "Potato",
        carbs: "-20.0",
        proteins: "3.1",
        fats: "0.1",
        amount: "1",
        unit: FoodUnit.unit,
      ));
    },
    expect: () {
      return <CreateFoodState>[
        const CreateFoodState.validationError(
          validName: true,
          validCarbs: false,
          validProteins: true,
          validFats: true,
          validAmount: true,
        ),
      ];
    },
  );

  blocTest<CreateFoodBloc, CreateFoodState>(
    "should emit [ValidationError] when amount input invalid",
    build: () => createFoodBloc,
    act: (bloc) {
      bloc.add(const CreateFoodEvent.submit(
        name: "Potato",
        carbs: "23.2",
        proteins: "3.1",
        fats: "0.1",
        amount: "invalid input",
        unit: FoodUnit.unit,
      ));
    },
    expect: () {
      return <CreateFoodState>[
        const CreateFoodState.validationError(
          validName: true,
          validCarbs: true,
          validProteins: true,
          validFats: true,
          validAmount: false,
        ),
      ];
    },
  );

  blocTest<CreateFoodBloc, CreateFoodState>(
    "should emit [ValidationError] when element is empty",
    build: () => createFoodBloc,
    act: (bloc) {
      bloc.add(const CreateFoodEvent.submit(
        name: "Potato",
        carbs: "23.2",
        proteins: "3.1",
        fats: "",
        amount: "1",
        unit: FoodUnit.unit,
      ));
    },
    expect: () {
      return <CreateFoodState>[
        const CreateFoodState.validationError(
          validName: true,
          validCarbs: true,
          validProteins: true,
          validFats: false,
          validAmount: true,
        ),
      ];
    },
  );

  blocTest<CreateFoodBloc, CreateFoodState>(
    "should emit [ValidationError] when empty submit",
    build: () => createFoodBloc,
    act: (bloc) {
      bloc.add(const CreateFoodEvent.submit(
        name: "",
        carbs: "",
        proteins: "",
        fats: "",
        amount: "",
        unit: FoodUnit.gram,
      ));
    },
    expect: () {
      return <CreateFoodState>[
        const CreateFoodState.validationError(
          validName: false,
          validCarbs: false,
          validProteins: false,
          validFats: false,
          validAmount: false,
        ),
      ];
    },
  );
}
