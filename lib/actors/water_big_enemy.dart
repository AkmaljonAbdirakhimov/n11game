import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../ember_quest.dart';
import '../objects/objects.dart';

class WaterBigEnemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;
  int health = 30;

  final Vector2 velocity = Vector2.zero();

  WaterBigEnemy({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2(64, 71), anchor: Anchor.bottomLeft);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_big_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        textureSize: Vector2(64, 71),
        stepTime: 0.70,
      ),
    );
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    add(RectangleHitbox(collisionType: CollisionType.passive));
    add(CircleHitbox());
    add(
      MoveEffect.by(
        Vector2(-2 * size.x, 0),
        EffectController(
          duration: 3,
          alternate: true,
          infinite: true,
        ),
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is FireWeapon) {
      health--;
      if (health <= 0) {
        removeFromParent();
      }
      other.removeFromParent(); // Remove the FireWeapon
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x || game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }
}
