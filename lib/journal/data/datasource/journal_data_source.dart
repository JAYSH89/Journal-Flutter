import 'package:journal/journal/data/local/journal_entry_entity.dart';

abstract class JournalDataSource {
  Future<List<JournalEntryEntity>> getAll();

  Future<JournalEntryEntity?> getById(int id);

  Future<List<JournalEntryEntity>> getBetween(DateTime start, DateTime end);

  Future<JournalEntryEntity?> save(JournalEntryEntity journalEntry);

  Future<bool> delete(int id);
}
