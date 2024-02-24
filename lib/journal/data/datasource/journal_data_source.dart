import 'package:journal/journal/data/local/journal_entry_entity.dart';

abstract class JournalDataSource {
  Future<List<JournalEntryEntity>> getAll();

  Stream<List<JournalEntryEntity>> watchAll();

  Future<JournalEntryEntity?> getById(int id);

  Future<List<JournalEntryEntity>> getBetween(DateTime start, DateTime end);

  Stream<List<JournalEntryEntity>> watchBetween(DateTime lower, DateTime upper);

  Future<JournalEntryEntity?> save(JournalEntryEntity journalEntry);

  Future<bool> delete(int id);
}
