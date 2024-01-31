import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';

class InMemoryJournalDataSource implements JournalDataSource {
  @override
  delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  List<JournalEntry> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  List<JournalEntry> getBetween(DateTime start, DateTime end) {
    // TODO: implement getBetween
    throw UnimplementedError();
  }

  @override
  JournalEntry? getById() {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  JournalEntry save(JournalEntry entry) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  JournalEntry update(String id, JournalEntry entry) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
