import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:n11game/ember_quest.dart';

import 'joystick.dart';

enum Direction { left, right, none }

class GameControls extends StatefulWidget {
  final EmberQuestGame game;

  const GameControls({super.key, required this.game});

  @override
  State<GameControls> createState() => _GameControlsState();
}

class _GameControlsState extends State<GameControls> {
  final _audioPlayer = AudioPlayer();

  void playSound(String path) async {
    await _audioPlayer.play(AssetSource(path));
  }

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
                  widget.game.movePlayer(Direction.left);
                  break;
                case Direction.right:
                  widget.game.movePlayer(Direction.right);
                  break;
                case Direction.none:
                  widget.game.stopPlayer();
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
              widget.game
                  .fireWeapon(); // Call the fire function when the button is pressed
              playSound('sounds/gun.ogg');
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
            onPressed: () => widget.game.jumpPlayer(),
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
