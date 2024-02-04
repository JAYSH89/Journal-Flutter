import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';
import 'package:journal/journal/domain/repository/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  final JournalDataSource dataSource;

  JournalRepositoryImpl({required this.dataSource});

  @override
  List<JournalEntry> getAll() => dataSource.getAll();

  @override
  JournalEntry? getById(String id) => dataSource.getById(id);

  @override
  List<JournalEntry> getBetween(DateTime start, DateTime end) {
    return dataSource.getBetween(start, end);
  }

  @override
  JournalEntry update(String id, JournalEntry entry) {
    return dataSource.update(id, entry);
  }

  @override
  JournalEntry save(JournalEntry entry) {
    return dataSource.save(entry);
  }

  @override
  delete(String id) {
    dataSource.delete(id);
  }
}
