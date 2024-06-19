import 'package:flutter/material.dart';

import '../game/game_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Bullseye',
        ),
        backgroundColor: Colors.red.shade700,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('💐 Bullseye 💐'),
            ),
            const Text(
                'This is Bullseye, the game where you can win points and earn fame by dragging a slider.\n'),
            const Text('Enjoy!'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.popUntil(
                    context,
                    (route) {
                      return true;
                    },
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GamePage()),
                  );
                },
                child: const Text('Go back!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    (route) {
                      return route.isFirst;
                    },
                  );
                },
                child: const Text('Go back 2!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
