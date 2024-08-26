import 'package:flutter/material.dart';
import 'package:pixelbek/ember_quest.dart';

import 'joystick.dart';

enum Direction { left, right, none }

class GameControls extends StatelessWidget {
  final EmberQuestGame game;

  const GameControls({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 50),
            // Joystick for movement
            Joystick(
              onDirectionChanged: (direction) {
                switch (direction) {
                  case Direction.left:
                    game.ember.movePlayer(Direction.left);
                    break;
                  case Direction.right:
                    game.ember.movePlayer(Direction.right);
                    break;
                  case Direction.none:
                    game.ember.stopPlayer();
                    break;
                }
              },
            ),
            const Spacer(),
            // Weapon
            ElevatedButton(
              onPressed: () {
                if (game.isGameStarted) {
                  game.ember.fireWeapon();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(30),
                backgroundColor: Colors.red,
              ),
              child: const Icon(Icons.fireplace, color: Colors.white),
            ),
            const SizedBox(width: 20),
            // Jump button
            ElevatedButton(
              onPressed: () {
                if (game.isGameStarted) {
                  game.ember.jumpPlayer();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(30),
              ),
              child: const Icon(Icons.arrow_upward),
            ),
            const SizedBox(width: 50),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
