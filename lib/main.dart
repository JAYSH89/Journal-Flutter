import 'package:flutter/cupertino.dart';
import 'package:journal/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:journal/core/navigation/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  runApp(const JournalApp());
}

class JournalApp extends StatelessWidget {
  const JournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;

    return _startApp(platform);
  }

  Widget _startApp(platform) {
    if (platform == TargetPlatform.iOS) {
      return CupertinoApp.router(routerConfig: router);
    }
    return MaterialApp.router(routerConfig: router);
  }
}
