import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:journal/journal/data/datasource/journal_data_source.dart';
import 'package:journal/journal/data/local/journal_entry_entity.dart';

@Injectable(as: JournalDataSource)
class JournalDataSourceImpl implements JournalDataSource {
  JournalDataSourceImpl({required this.database});

  final Isar database;

  @override
  Future<List<JournalEntryEntity>> getAll() async => database //
      .collection<JournalEntryEntity>()
      .where()
      .findAll();

  @override
  Future<JournalEntryEntity?> getById(int id) => database //
      .journalEntryEntitys
      .get(id);

  @override
  Future<List<JournalEntryEntity>> getBetween(DateTime lower, DateTime upper) {
    if (lower.isAfter(upper)) {
      final message = "($lower) cannot be greater than: ($upper)";
      throw ArgumentError(message);
    }

    return database.journalEntryEntitys
        .filter()
        .dateBetween(lower, upper)
        .findAll();
  }

  @override
  Future<JournalEntryEntity?> save(JournalEntryEntity journalEntry) async {
    return await database.writeTxn(() async {
      final savedId = await database.journalEntryEntitys.put(journalEntry);
      return database.journalEntryEntitys.get(savedId);
    });
  }

  @override
  Future<bool> delete(int id) async {
    return await database.writeTxn(() async {
      return database.journalEntryEntitys.delete(id);
    });
  }
}