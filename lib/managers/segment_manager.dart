import 'dart:math';

import 'package:flame/components.dart';

import '../actors/actors.dart';
import '../objects/objects.dart';

List<List<ObjectBlock>> generateRandomSegments(int count) {
  List<List<ObjectBlock>> randomSegments = [];
  Random random = Random();

  for (int i = 0; i < count; i++) {
    List<ObjectBlock> segment = [];
    List<List<bool>> occupied = List.generate(10, (_) => List.filled(6, false));

    // Add ground blocks with rare gaps, but ensure the first 3 blocks are always ground
    for (int x = 0; x < 10; x++) {
      if (x < 3 || random.nextDouble() > 0.05) {
        // Always add ground for first 3 blocks, then 5% chance to create a gap
        segment.add(ObjectBlock(
            blockType: GroundBlock, gridPosition: Vector2(x.toDouble(), 0)));
        occupied[x][0] = true;
      }
    }

    // Randomly add grouped platform blocks
    for (int x = 0; x < 10; x++) {
      if (random.nextDouble() < 0.2) {
        // 20% chance to start a platform group
        int platformLength = random.nextInt(3) + 2; // Group of 2 to 4 blocks
        int y = random.nextInt(3) + 2; // Platform height between 2 and 4
        for (int j = 0; j < platformLength; j++) {
          if (x + j < 10 && !occupied[x + j][y]) {
            segment.add(ObjectBlock(
                blockType: PlatformBlock,
                gridPosition: Vector2((x + j).toDouble(), y.toDouble())));
            occupied[x + j][y] = true;
          }
        }
        x += platformLength - 1; // Skip to the end of the platform group
      }
    }

    // Randomly add stars
    for (int x = 0; x < 10; x++) {
      if (random.nextDouble() < 0.3) {
        // 30% chance to add a star
        int y = random.nextInt(4) + 1; // Star height between 1 and 4
        if (!occupied[x][y] && (occupied[x][y - 1] || y == 1)) {
          segment.add(ObjectBlock(
              blockType: Star,
              gridPosition: Vector2(x.toDouble(), y.toDouble())));
          occupied[x][y] = true;
        }
      }
    }

    // Add fewer water enemies on ground or platforms, starting from the middle of the segment
    int waterEnemiesCount = 0;
    while (waterEnemiesCount < 1) {
      // Ensure only 1 water enemy per segment
      int x = random.nextInt(5) +
          5; // Place water enemies in the second half of the segment
      for (int y = 1; y <= 4; y++) {
        // Search for a ground or platform to place the water enemy
        if (occupied[x][y - 1] && !occupied[x][y]) {
          // Place water enemy on a ground or platform
          segment.add(ObjectBlock(
              blockType: WaterEnemy,
              gridPosition: Vector2(x.toDouble(), y.toDouble())));
          occupied[x][y] = true;
          waterEnemiesCount++;
          break;
        }
      }
    }

    // Add fewer water enemies on ground or platforms, starting from the middle of the segment
    int waterBigEnemiesCount = 0;
    while (waterBigEnemiesCount < 1) {
      // Ensure only 1 water enemy per segment
      int x = random.nextInt(5) +
          5; // Place water enemies in the second half of the segment
      for (int y = 1; y <= 4; y++) {
        // Search for a ground or platform to place the water enemy
        if (occupied[x][y - 1] && !occupied[x][y]) {
          // Place water enemy on a ground or platform
          segment.add(ObjectBlock(
            blockType: WaterBigEnemy,
            gridPosition: Vector2(x.toDouble(), y.toDouble()),
          ));
          occupied[x][y] = true;
          waterBigEnemiesCount++;
          break;
        }
      }
    }

    randomSegments.add(segment);
  }

  return randomSegments;
}

class ObjectBlock {
  // gridPosition position is always segment based X,Y.
  // 0,0 is the bottom left corner.
  // 10,10 is the upper right corner.
  final Vector2 gridPosition;
  final Type blockType;
  ObjectBlock({
    required this.gridPosition,
    required this.blockType,
  });
}

final segments = [
  segment0,
  segment1,
  segment2,
  segment3,
  segment4,
];

final segment0 = [
  ObjectBlock(gridPosition: Vector2(0, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(1, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(2, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(3, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(4, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(5, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(5, 1), blockType: WaterEnemy),
  ObjectBlock(gridPosition: Vector2(5, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(6, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(6, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(7, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(7, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(8, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(8, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(9, 0), blockType: GroundBlock),
];

final segment1 = [
  ObjectBlock(gridPosition: Vector2(0, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(1, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(1, 1), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(1, 2), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(1, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(2, 6), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(3, 6), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(6, 5), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(7, 5), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(7, 7), blockType: Star),
  ObjectBlock(gridPosition: Vector2(8, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(8, 1), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(8, 5), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(8, 6), blockType: WaterEnemy),
  ObjectBlock(gridPosition: Vector2(9, 0), blockType: GroundBlock),
];

final segment2 = [
  ObjectBlock(gridPosition: Vector2(0, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(1, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(2, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(3, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(3, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(4, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(4, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(5, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(5, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(5, 4), blockType: WaterEnemy),
  ObjectBlock(gridPosition: Vector2(6, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(6, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(6, 4), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(6, 5), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(6, 7), blockType: Star),
  ObjectBlock(gridPosition: Vector2(7, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(8, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(9, 0), blockType: GroundBlock),
];

final segment3 = [
  ObjectBlock(gridPosition: Vector2(0, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(1, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(1, 1), blockType: WaterEnemy),
  ObjectBlock(gridPosition: Vector2(2, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(2, 1), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(2, 2), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(4, 4), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(6, 6), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(7, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(7, 1), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(8, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(8, 8), blockType: Star),
  ObjectBlock(gridPosition: Vector2(9, 0), blockType: GroundBlock),
];

final segment4 = [
  ObjectBlock(gridPosition: Vector2(0, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(1, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(2, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(2, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(3, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(3, 1), blockType: WaterEnemy),
  ObjectBlock(gridPosition: Vector2(3, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(4, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(5, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(5, 5), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(6, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(6, 5), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(6, 7), blockType: Star),
  ObjectBlock(gridPosition: Vector2(7, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(8, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(8, 3), blockType: PlatformBlock),
  ObjectBlock(gridPosition: Vector2(9, 0), blockType: GroundBlock),
  ObjectBlock(gridPosition: Vector2(9, 1), blockType: WaterEnemy),
  ObjectBlock(gridPosition: Vector2(9, 3), blockType: PlatformBlock),
];
