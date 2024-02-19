import 'dart:io' show Directory, Platform;
import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:journal/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/navigation/go_router.dart';
import 'package:journal/food/data/local/food_entity.dart';
import 'package:journal/journal/data/local/journal_entry_entity.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();

  Directory dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [FoodEntitySchema, JournalEntryEntitySchema],
    directory: dir.path,
  );
  getIt.registerSingleton<Isar>(isar);

  runApp(const JournalApp());
}

class JournalApp extends StatelessWidget {
  const JournalApp({super.key});

  @override
  Widget build(BuildContext context) => _startApp();

  Widget _startApp() {
    if (Platform.isIOS) return CupertinoApp.router(routerConfig: router);
    return MaterialApp.router(routerConfig: router);
  }
}
