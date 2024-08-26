import 'package:flutter/material.dart';
import '../ember_quest.dart';

class LevelDetailsOverlay extends StatelessWidget {
  final EmberQuestGame game;

  const LevelDetailsOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'LEVEL ${game.currentLevel}',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'TIME: ${game.remainingTime} seconds\n'
              'STARS: ${game.requiredStars} stars',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.startNextLevel();
                game.overlays.remove('LevelDetails');
              },
              child: const Text(
                'START',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
