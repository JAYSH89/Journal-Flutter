import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal/food/domain/models/food_unit.dart';

part 'create_food_event.dart';

part 'create_food_state.dart';

part 'create_food_bloc.freezed.dart';

class CreateFoodBloc extends Bloc<CreateFoodEvent, CreateFoodState> {
  CreateFoodBloc() : super(const CreateFoodState.initial()) {
    on<CreateFoodEvent>((event, emit) {
      event.when(
        submit: (
          String name,
          String carbs,
          String proteins,
          String fats,
          String amount,
          FoodUnit unit,
        ) {
          final validName = _validateTextInput(name);
          final validCarbs = _validateNumericInput(carbs);
          final validProteins = _validateNumericInput(proteins);
          final validFats = _validateNumericInput(fats);
          final validAmount = _validateNumericInput(amount);

          final validForm = validName &&
              validCarbs &&
              validProteins &&
              validFats &&
              validAmount;

          if (validForm) {
            emit(const CreateFoodState.validated());
            return;
          }

          emit(
            CreateFoodState.validationError(
              validName: validName,
              validCarbs: validCarbs,
              validProteins: validProteins,
              validFats: validFats,
              validAmount: validAmount,
            ),
          );
        },
      );
    });
  }

  bool _validateTextInput(String input) => input.isNotEmpty;

  bool _validateNumericInput(String input) {
    if (input.isEmpty) return false;

    final parsedInput = double.tryParse(input);
    if (parsedInput == null || parsedInput.isNegative) return false;

    return true;
  }
}
