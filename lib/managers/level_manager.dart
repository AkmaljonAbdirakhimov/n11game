import 'dart:math';

import 'package:flame/game.dart';

import '../actors/actors.dart';
import '../objects/objects.dart';
import 'segment_manager.dart';

class LevelGenerator {
  final int segmentWidth = 10;
  final int segmentHeight = 10;
  final Random random = Random();

  List<ObjectBlock> generateSegment() {
    List<ObjectBlock> segment = [];
    Set<Vector2> occupiedPositions = {};

    // Always add ground blocks at the bottom
    for (int x = 0; x < segmentWidth; x++) {
      Vector2 position = Vector2(x.toDouble(), 0);
      segment.add(ObjectBlock(gridPosition: position, blockType: GroundBlock));
      occupiedPositions.add(position);
    }

    // Add platforms
    int platformCount = random.nextInt(5) + 3; // 3 to 7 platforms
    for (int i = 0; i < platformCount; i++) {
      int x = random.nextInt(segmentWidth);
      int y =
          random.nextInt(segmentHeight - 1) + 1; // Avoid y = 0 (ground level)
      int length = random.nextInt(3) + 1; // Platform length 1 to 3 blocks

      for (int j = 0; j < length; j++) {
        if (x + j < segmentWidth) {
          Vector2 position = Vector2((x + j).toDouble(), y.toDouble());
          if (!occupiedPositions.contains(position)) {
            segment.add(
                ObjectBlock(gridPosition: position, blockType: PlatformBlock));
            occupiedPositions.add(position);
          }
        }
      }
    }

    // Add enemies
    int enemyCount = random.nextInt(2) + 1; // 1 to 2 enemies
    for (int i = 0; i < enemyCount; i++) {
      int x = random.nextInt(5) + 5; // Enemies only in the last 5 grids
      int y = random.nextBool()
          ? 0
          : random.nextInt(segmentHeight - 1) + 1; // Can be on ground or above
      Vector2 position = Vector2(x.toDouble(), y.toDouble());

      if (!occupiedPositions.contains(position)) {
        segment.add(ObjectBlock(gridPosition: position, blockType: WaterEnemy));
        occupiedPositions.add(position);

        // Mark the enemy's walking range
        for (int j = 1; j <= 3; j++) {
          if (x + j < segmentWidth) {
            occupiedPositions.add(Vector2((x + j).toDouble(), y.toDouble()));
          }
          if (x - j >= 5) {
            occupiedPositions.add(Vector2((x - j).toDouble(), y.toDouble()));
          }
        }
      }
    }

    // Add a star (collectible)
    while (true) {
      int starX = random.nextInt(5) + 5; // Star only in the last 5 grids
      int starY =
          random.nextInt(segmentHeight - 1) + 1; // Avoid y = 0 (ground level)
      Vector2 position = Vector2(starX.toDouble(), starY.toDouble());

      if (!occupiedPositions.contains(position)) {
        segment.add(ObjectBlock(gridPosition: position, blockType: Star));
        break;
      }
    }

    return segment;
  }

  List<List<ObjectBlock>> generateLevel(int segmentCount) {
    List<List<ObjectBlock>> level = [];
    for (int i = 0; i < segmentCount; i++) {
      level.add(generateSegment());
    }
    return level;
  }
}
