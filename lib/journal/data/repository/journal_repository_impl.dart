import 'package:journal/journal/domain/models/journal_entry.dart';
import 'package:journal/journal/domain/repository/journal_repository.dart';

class JournalRepositoryImpl implements JournalRepository {
  @override
  List<JournalEntry> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  JournalEntry? getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  List<JournalEntry> getBetween(DateTime start, DateTime end) {
    // TODO: implement getBetween
    throw UnimplementedError();
  }

  @override
  JournalEntry update(String id, JournalEntry entry) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  JournalEntry save(JournalEntry entry) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
