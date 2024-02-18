import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';
import 'package:journal/journal/domain/repository/journal_repository.dart';

part 'journal_cubit.freezed.dart';

@Injectable()
class JournalCubit extends Cubit<JournalState> {
  JournalCubit(this._repository) : super(const JournalState());

  final JournalRepository _repository;
}

@freezed
class JournalState with _$JournalState {
  const factory JournalState({
    DateTime? selectedDateTime,
    @Default([]) List<JournalEntry> entries,
  }) = _JournalState;
}
