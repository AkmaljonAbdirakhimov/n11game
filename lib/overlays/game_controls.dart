import 'package:flutter/material.dart';
import 'package:n11game/ember_quest.dart';

import 'joystick.dart';

enum Direction { left, right, none }

class GameControls extends StatelessWidget {
  final EmberQuestGame game;

  const GameControls({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Joystick for movement
        Positioned(
          bottom: 50,
          left: 20,
          child: Joystick(
            onDirectionChanged: (direction) {
              switch (direction) {
                case Direction.left:
                  game.movePlayer(Direction.left);
                  break;
                case Direction.right:
                  game.movePlayer(Direction.right);
                  break;
                case Direction.none:
                  game.stopPlayer();
                  break;
              }
            },
          ),
        ),
        // Weapon
        Positioned(
          bottom: 50,
          right: 100,
          child: ElevatedButton(
            onPressed: () {
              game.fireWeapon();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(30),
              backgroundColor: Colors.red,
            ),
            child: const Icon(Icons.fireplace, color: Colors.white),
          ),
        ),
        // Jump button
        Positioned(
          bottom: 50,
          right: 20,
          child: ElevatedButton(
            onPressed: () => game.jumpPlayer(),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(30),
            ),
            child: const Icon(Icons.arrow_upward),
          ),
        ),
      ],
    );
  }
}
