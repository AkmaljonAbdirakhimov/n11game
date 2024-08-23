import 'package:flame/components.dart';

import '../actors/actors.dart';
import '../objects/objects.dart';

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
