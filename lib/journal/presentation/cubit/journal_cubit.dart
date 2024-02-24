import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';
import 'package:journal/journal/domain/repository/journal_repository.dart';

part 'journal_cubit.freezed.dart';

enum JournalSelectorDirection { forward, previous }

@Injectable()
class JournalCubit extends Cubit<JournalState> {
  JournalCubit(this._repository) : super(const JournalState());

  final JournalRepository _repository;

  void getJournalEntries() async {
    final journalEntries = await _repository.getAll();
    emit(state.copyWith(entries: journalEntries));
  }

  void changeDate(JournalSelectorDirection direction) {
    final selectedDate = state.selectedDateTime ?? DateTime.now();

    if (direction == JournalSelectorDirection.forward) {
      final newDate = selectedDate.add(const Duration(days: 1));
      emit(state.copyWith(selectedDateTime: newDate));
      return;
    }

    final newDate = selectedDate.add(const Duration(days: -1));
    emit(state.copyWith(selectedDateTime: newDate));
  }
}

@freezed
class JournalState with _$JournalState {
  const factory JournalState({
    DateTime? selectedDateTime,
    @Default([]) List<JournalEntry> entries,
  }) = _JournalState;
}
