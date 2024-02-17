import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/repository/food_repository.dart';

part 'food_cubit.freezed.dart';

@Injectable()
class FoodCubit extends Cubit<FoodState> {
  FoodCubit(this._repository) : super(const FoodState()) {
    _getAllFood();
  }

  final FoodRepository _repository;
  StreamSubscription<List<Food>>? _foodSubscription;

  void _getAllFood() async {
    final initialFoods = await _repository.getAll();
    emit(state.copyWith(foods: initialFoods));

    _foodSubscription = _repository.watchAll().listen(
          (foods) => emit(state.copyWith(foods: foods)),
          onError: (error) => emit(state.copyWith(errorMessage: "$error")),
        );
  }

  void deleteFood({required int id}) async {
    final success = await _repository.deleteFood(id: id);

    if (!success) {
      var message = "Error deleting $id";
      emit(state.copyWith(errorMessage: message));
    }
  }

  @override
  Future<void> close() {
    _foodSubscription?.cancel();
    return super.close();
  }
}

@freezed
class FoodState with _$FoodState {
  const factory FoodState({
    @Default([]) List<Food> foods,
    @Default(null) String? errorMessage,
  }) = _FoodState;
}
