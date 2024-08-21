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
        // Jump button
        Positioned(
          bottom: 50,
          right: 20,
          child: GestureDetector(
            onTap: () => game.jumpPlayer(),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(30),
              ),
              child: const Icon(Icons.arrow_upward),
            ),
          ),
        ),
      ],
    );
  }
}
