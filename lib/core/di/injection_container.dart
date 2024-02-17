import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/journal/data/local/journal_entry_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void _configureDependencies() => getIt.init();

Future<Isar> _openIsar() async {
  Directory dir = await getApplicationDocumentsDirectory();
  return Isar.open(
    [FoodEntitySchema, JournalEntryEntitySchema],
    directory: dir.path,
  );
}

void setupInjection() async {
  _configureDependencies();

  getIt.registerSingletonAsync<Isar>(
    () async => await _openIsar(),
    dispose: (isar) => isar.close(),
  );

  getIt.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });
}
