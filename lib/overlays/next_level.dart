import 'package:flutter/material.dart';
import '../ember_quest.dart';

class NextLevelOverlay extends StatelessWidget {
  final EmberQuestGame game;

  const NextLevelOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Congratulations!',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'You cleared the level!',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.startNextLevel();
                game.overlays.remove('NextLevel');
              },
              child: const Text('Start Next Level'),
            ),
          ],
        ),
      ),
    );
  }
}
