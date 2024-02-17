import 'package:fpdart/fpdart.dart';
import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/journal/data/local/journal_entry_entity.dart';
import 'package:journal/journal/domain/models/journal_entry.dart';

class InMemoryJournalDataSource implements JournalDataSource {
  List<JournalEntry> entries = List.empty(growable: true);
  List<JournalEntryEntity> entities = List.empty(growable: true);

  @override
  Future<List<JournalEntryEntity>> getAll() async => entities;

  @override
  Future<JournalEntryEntity?> getById(int id) async {
    final result = entities.filter((entity) => entity.id == id);
    if (result.isEmpty) return null;

    return result.first;
  }

  @override
  Future<List<JournalEntryEntity>> getBetween(
    DateTime lower,
    DateTime upper,
  ) async {
    if (lower.isAfter(upper)) {
      final message = "($lower) cannot be greater than: ($upper)";
      throw ArgumentError(message);
    }

    return entities.filter((entry) {
      final isBefore = entry.date.isAfter(lower);
      final isAfter = entry.date.isBefore(upper);

      return isBefore && isAfter;
    }).toList();
  }

  @override
  Future<JournalEntryEntity?> save(JournalEntryEntity journalEntry) async {
    final exists = entities //
        .where((savedEntry) => savedEntry.id == journalEntry.id)
        .toList()
        .firstOrNull;

    if (exists != null) {
      return _updateEntry(currentEntry: exists, newEntry: journalEntry);
    }

    final newJournalEntry = JournalEntryEntity()
      ..id = _generateId()
      ..food.value = journalEntry.food.value
      ..date = journalEntry.date
      ..amount = journalEntry.amount;

    entities.add(newJournalEntry);
    return newJournalEntry;
  }

  @override
  Future<bool> delete(int id) async {
    final toDelete = entities //
        .where((entry) => entry.id == id)
        .toList();

    if (toDelete.isNotEmpty) {
      entities.remove(toDelete.first);
      return true;
    }
    return false;
  }

  JournalEntryEntity _updateEntry({
    required JournalEntryEntity currentEntry,
    required JournalEntryEntity newEntry,
  }) {
    entities = List.from(entities)..remove(currentEntry);

    final updatedJournalEntry = JournalEntryEntity()
      ..id = currentEntry.id
      ..food.value = newEntry.food.value
      ..date = newEntry.date
      ..amount = newEntry.amount;

    entities.add(updatedJournalEntry);
    return updatedJournalEntry;
  }

  int _generateId() {
    if (entities.isEmpty) return 1;
    final ids = entities.map((e) => e.id).toList();
    final maxId = ids.reduce((left, right) => left! > right! ? left : right);
    return maxId! + 1;
  }
}
