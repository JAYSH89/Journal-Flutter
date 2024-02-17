import 'package:journal/journal/domain/models/journal_entry.dart';

abstract class JournalRepository {
  Future<List<JournalEntry>> getAll();

  Future<JournalEntry?> getById(int id);

  Future<List<JournalEntry>> getBetween(DateTime lower, DateTime upper);

  Future<JournalEntry?> save(JournalEntry entry);

  Future<bool> delete(int id);
}
