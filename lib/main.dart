import 'package:journal/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/navigation/go_router.dart';

void main() {
  setupLocator();
  runApp(const JournalApp());
}

class JournalApp extends StatelessWidget {
  const JournalApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: router,
      );
}
