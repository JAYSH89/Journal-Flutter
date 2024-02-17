import 'package:injectable/injectable.dart';
import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/journal/data/local/journal_entry_entity.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';
import 'package:journal/journal/domain/repository/journal_repository.dart';

@Injectable(as: JournalRepository)
class JournalRepositoryImpl implements JournalRepository {
  final JournalDataSource dataSource;

  JournalRepositoryImpl({required this.dataSource});

  @override
  Future<List<JournalEntry>> getAll() {
    return dataSource //
        .getAll()
        .then((entities) => entities.map((entry) {
              return entry.toJournalEntry();
            }).toList());
  }

  @override
  Future<JournalEntry?> getById(int id) {
    return dataSource //
        .getById(id)
        .then((value) => value?.toJournalEntry());
  }

  @override
  Future<List<JournalEntry>> getBetween(
    DateTime lower,
    DateTime upper,
  ) {
    return dataSource
        .getBetween(lower, upper)
        .then((entities) => entities.map((entry) {
              return entry.toJournalEntry();
            }).toList());
  }

  @override
  Future<JournalEntry?> save(JournalEntry entry) {
    final entity = JournalEntryEntity.fromJournalEntry(entry: entry);
    return dataSource.save(entity).then((e) => e?.toJournalEntry());
  }

  @override
  Future<bool> delete(int id) {
    return dataSource.delete(id);
  }
}
