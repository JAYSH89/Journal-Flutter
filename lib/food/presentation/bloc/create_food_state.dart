part of 'create_food_bloc.dart';

@freezed
class CreateFoodState with _$CreateFoodState {
  const factory CreateFoodState.initial() = _Initial;

  const factory CreateFoodState.validated({
    bool? validName,
    bool? validCarbs,
    bool? validProteins,
    bool? validFats,
    bool? validAmount,
    bool? formValid,
  }) = _Validated;
}
