import 'package:journal/journal/domain/models/journal_entry.dart';

abstract class JournalDataSource {
  List<JournalEntry> getAll();

  JournalEntry? getById();

  List<JournalEntry> getBetween(DateTime start, DateTime end);

  JournalEntry update(String id, JournalEntry entry);

  JournalEntry save(JournalEntry entry);

  delete(String id);
}
