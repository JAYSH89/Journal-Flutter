import 'package:fpdart/fpdart.dart';
import 'package:journal/core/errors/exceptions.dart';
import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';
import 'package:uuid/uuid.dart';

class InMemoryJournalDataSource implements JournalDataSource {
  List<JournalEntry> entries = List.empty(growable: true);

  @override
  List<JournalEntry> getAll() => entries;

  @override
  JournalEntry? getById(String id) {
    final result = entries.filter((entry) => entry.id == id);
    if (result.isEmpty) return null;

    return result.first;
  }

  @override
  List<JournalEntry> getBetween(DateTime start, DateTime end) {
    if (start.isAfter(end)) {
      final errorMessage =
          "start DateTime ($start) cannot be greater than end DateTime ($end)";
      throw ArgumentError(errorMessage);
    }

    return entries.filter((journalEntry) {
      final isBefore = journalEntry.date.isAfter(start);
      final isAfter = journalEntry.date.isBefore(end);

      return isBefore && isAfter;
    }).toList();
  }

  @override
  JournalEntry update(String id, JournalEntry entry) {
    final toUpdate = entries.where((e) => e.id == id).toList().firstOrNull;

    if (toUpdate == null) {
      throw InMemoryNotFoundException("update JournalEntry: $id not found");
    }

    entries.remove(toUpdate);
    final updatedJournalEntry = JournalEntry(
      id: toUpdate.id,
      food: entry.food,
      date: entry.date,
      amount: entry.amount,
    );
    entries.add(updatedJournalEntry);
    return updatedJournalEntry;
  }

  @override
  JournalEntry save(JournalEntry entry) {
    final id = const Uuid().v8();
    final newJournalEntry = JournalEntry(
      id: id,
      food: entry.food,
      date: entry.date,
      amount: entry.amount,
    );
    entries.add(newJournalEntry);
    return newJournalEntry;
  }

  @override
  delete(String id) {
    final toDelete = entries.where((entry) => entry.id == id).toList();
    if (toDelete.isNotEmpty) {
      entries.remove(toDelete.first);
      return;
    }

    throw InMemoryNotFoundException("delete JournalEntry: $id not found");
  }
}
