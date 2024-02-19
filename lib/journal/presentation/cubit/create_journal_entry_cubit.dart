import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:journal/food/domain/models/food.dart';
import 'package:journal/food/domain/repository/food_repository.dart';
import 'package:journal/journal/domain/repository/journal_repository.dart';

part 'create_journal_entry_cubit.freezed.dart';

@Injectable()
class CreateJournalEntryCubit extends Cubit<CreateJournalEntryState> {
  CreateJournalEntryCubit(
    this._journalRepository,
    this._foodRepository,
  ) : super(const CreateJournalEntryState()) {
    _getAllFood();
  }

  final JournalRepository _journalRepository;
  final FoodRepository _foodRepository;

  StreamSubscription<List<Food>>? _foodSubscription;

  void _getAllFood() async {
    final initialFoods = await _foodRepository.getAll();
    emit(state.copyWith(foods: initialFoods));

    _foodSubscription = _foodRepository.watchAll().listen(
          (foods) => emit(state.copyWith(foods: foods)),
          onError: (error) => emit(state.copyWith(errorMessage: "$error")),
        );
  }

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDateTime: date));
  }

  void setSearchText(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(searchQuery: query, searchFoods: []));
      return;
    }

    final filteredFood = state.foods //
        .filter((e) => e.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(state.copyWith(searchQuery: query, searchFoods: filteredFood));
  }

  void submit() {}

  @override
  Future<void> close() {
    _foodSubscription?.cancel();
    return super.close();
  }
}

@freezed
class CreateJournalEntryState with _$CreateJournalEntryState {
  const factory CreateJournalEntryState({
    @Default("") String searchQuery,
    @Default([]) List<Food> searchFoods,
    @Default([]) List<Food> foods,
    DateTime? selectedDateTime,
    @Default(null) String? errorMessage,
  }) = _CreateJournalEntryState;
}
