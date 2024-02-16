import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/models/food_unit.dart';
import 'package:journal/food/domain/repository/food_repository.dart';

part 'create_food_cubit.freezed.dart';

enum CreateFoodTextFieldKey {
  name,
  carbs,
  proteins,
  fats,
  amount,
  unit,
}

@Injectable()
class CreateFoodCubit extends Cubit<CreateFoodState> {
  CreateFoodCubit(this._repository) : super(const CreateFoodState());

  final FoodRepository _repository;

  void setText(CreateFoodTextFieldKey key, String text) {
    final currentFields = state.fields;
    final Map<CreateFoodTextFieldKey, String> fields = Map.from(currentFields)
      ..[key] = text;

    emit(state.copyWith(fields: fields));
  }

  void setUnit(FoodUnit unit) {
    emit(state.copyWith(unit: unit));
  }

  void reset() {
    emit(const CreateFoodState());
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

    if (formValid) {
      final result = Food(
        name: name ?? "",
        carbs: double.tryParse(carbs ?? "") ?? 0,
        proteins: double.tryParse(proteins ?? "") ?? 0,
        fats: double.tryParse(fats ?? "") ?? 0,
        amount: double.tryParse(amount ?? "") ?? 0,
        foodUnit: state.unit,
      );

      _repository.saveFood(result);
    }

    emit(state.copyWith(formSubmitted: formValid));
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
    @Default(null) bool? formSubmitted,
    @Default([]) List<Food> food,
  }) = _CreateFoodState;
}
