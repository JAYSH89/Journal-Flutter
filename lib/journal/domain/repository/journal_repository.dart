import 'package:journal/journal/domain/models/journal_entry.dart';

abstract class JournalRepository {
  List<JournalEntry> getAll();

  JournalEntry? getById(String id);

  List<JournalEntry> getBetween(DateTime start, DateTime end);

  JournalEntry update(String id, JournalEntry entry);

  JournalEntry save(JournalEntry entry);

  delete(String id);
}
