import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:journal/food/domain/models/food_unit.dart';

part 'create_food_cubit.freezed.dart';

enum CreateFoodTextFieldKey {
  name,
  carbs,
  proteins,
  fats,
  amount,
  unit,
}

class CreateFoodCubit extends Cubit<CreateFoodState> {
  CreateFoodCubit() : super(const CreateFoodState());

  void setText(CreateFoodTextFieldKey key, String text) {
    final currentFields = state.fields;
    final Map<CreateFoodTextFieldKey, String> fields = Map.from(currentFields)
      ..[key] = text;

    emit(state.copyWith(fields: fields));
  }

  void setUnit(FoodUnit unit) {
    emit(state.copyWith(unit: unit));
  }

  void submit() {
    final name = state.fields[CreateFoodTextFieldKey.name];
    final validatedName = _validateTextInput(name);

    final carbs = state.fields[CreateFoodTextFieldKey.carbs];
    final validatedCarbs = _validateNumericInput(carbs);

    final proteins = state.fields[CreateFoodTextFieldKey.proteins];
    final validatedProteins = _validateNumericInput(proteins);

    final fats = state.fields[CreateFoodTextFieldKey.fats];
    final validatedFats = _validateNumericInput(fats);

    final amount = state.fields[CreateFoodTextFieldKey.amount];
    final validatedAmount = _validateNumericInput(amount);

    final formValid = validatedName &&
        validatedCarbs &&
        validatedProteins &&
        validatedFats &&
        validatedAmount;

    emit(state.copyWith(formValid: formValid));

    // TODO: Convert to Food Object + Store
  }

  bool _validateTextInput(String? input) {
    if (input == null) return false;
    return input.isNotEmpty;
  }

  bool _validateNumericInput(String? input) {
    if (input == null) return false;
    if (input.isEmpty) return false;

    final parsedInput = double.tryParse(input);
    if (parsedInput == null || parsedInput.isNegative) return false;

    return true;
  }
}

@freezed
class CreateFoodState with _$CreateFoodState {
  const factory CreateFoodState({
    @Default({}) Map<CreateFoodTextFieldKey, String> fields,
    @Default(FoodUnit.gram) FoodUnit unit,
    @Default(null) bool? formValid,
  }) = _CreateFoodState;
}
