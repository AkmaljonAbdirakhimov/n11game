import 'package:flutter/material.dart';
import 'package:n11game/ember_quest.dart';

enum Direction { left, right }

class GameControls extends StatelessWidget {
  final EmberQuestGame game;

  const GameControls({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 50,
          left: 20,
          right: 20,
          child: Row(
            children: [
              GestureDetector(
                onTapDown: (_) => game.movePlayer(Direction.left),
                onTapUp: (_) => game.stopPlayer(),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(Icons.arrow_left),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTapDown: (_) => game.movePlayer(Direction.right),
                onTapUp: (_) => game.stopPlayer(),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(Icons.arrow_right),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          right: 20,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => game.jumpPlayer(),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(Icons.circle),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
