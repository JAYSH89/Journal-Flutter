import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  ) : super(const CreateJournalEntryState());

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
    print("$date");
    emit(state.copyWith(selectedDateTime: date));
  }

  @override
  Future<void> close() {
    _foodSubscription?.cancel();
    return super.close();
  }
}

@freezed
class CreateJournalEntryState with _$CreateJournalEntryState {
  const factory CreateJournalEntryState({
    @Default([]) List<Food> foods,
    DateTime? selectedDateTime,
    @Default(null) String? errorMessage,
  }) = _CreateJournalEntryState;
}
