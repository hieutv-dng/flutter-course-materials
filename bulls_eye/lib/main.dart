import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game/game_page.dart';

void main() {
  runApp(
    const BullsEyeApp(),
  );
}

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'Bullseye',
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
          )),
      home: const GamePage(),
    );
  }
}
