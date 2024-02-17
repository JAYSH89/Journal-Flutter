import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/journal/data/local/journal_entry_entity.dart';

class InMemoryJournalDataSource implements JournalDataSource {
  List<JournalEntryEntity> entries = List.empty(growable: true);
  final _entryStream = StreamController<List<JournalEntryEntity>>.broadcast();

  InMemoryJournalDataSource() {
    _entryStream.add(entries);
  }

  @override
  Future<List<JournalEntryEntity>> getAll() async => entries;

  @override
  Stream<List<JournalEntryEntity>> watchAll() => _entryStream.stream;

  @override
  Future<JournalEntryEntity?> getById(int id) async {
    final result = entries.filter((entity) => entity.id == id);
    if (result.isEmpty) return null;

    return result.first;
  }

  @override
  Future<List<JournalEntryEntity>> getBetween(
    DateTime lower,
    DateTime upper,
  ) async {
    _validateDates(lower: lower, upper: upper);

    return entries.filter((entry) {
      final isAfter = entry.date.isAfter(lower);
      final isBefore = entry.date.isBefore(upper);

      return isAfter && isBefore;
    }).toList();
  }

  @override
  Stream<List<JournalEntryEntity>> watchBetween(
    DateTime lower,
    DateTime upper,
  ) {
    _validateDates(lower: lower, upper: upper);
    return _entryStream.stream.map((event) => event.where((element) {
          final isAfter = element.date.isAfter(lower);
          final isBefore = element.date.isBefore(upper);

          return isAfter && isBefore;
        }).toList());
  }

  @override
  Future<JournalEntryEntity?> save(JournalEntryEntity journalEntry) async {
    final exists = entries //
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

    entries.add(newJournalEntry);
    _entryStream.add(List<JournalEntryEntity>.from(entries));
    return newJournalEntry;
  }

  @override
  Future<bool> delete(int id) async {
    final toDelete = entries.where((entry) => entry.id == id).toList();
    if (toDelete.isNotEmpty) {
      entries = List.from(entries)..remove(toDelete.first);
      _entryStream.add(List<JournalEntryEntity>.from(entries));
      return true;
    }

    return false;
  }

  JournalEntryEntity _updateEntry({
    required JournalEntryEntity currentEntry,
    required JournalEntryEntity newEntry,
  }) {
    entries = List.from(entries)..remove(currentEntry);

    final updatedJournalEntry = JournalEntryEntity()
      ..id = currentEntry.id
      ..food.value = newEntry.food.value
      ..date = newEntry.date
      ..amount = newEntry.amount;

    entries.add(updatedJournalEntry);
    _entryStream.add(List<JournalEntryEntity>.from(entries));
    return updatedJournalEntry;
  }

  int _generateId() {
    if (entries.isEmpty) return 1;
    final ids = entries.map((e) => e.id).toList();
    final maxId = ids.reduce((left, right) => left! > right! ? left : right);
    return maxId! + 1;
  }

  _validateDates({required DateTime lower, required DateTime upper}) {
    if (lower.isAfter(upper)) {
      final message = "($lower) cannot be greater than: ($upper)";
      throw ArgumentError(message);
    }
  }
}
