import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/collisions.dart';
import 'package:n11game/objects/objects.dart';
import '../ember_quest.dart';

class FireWeapon extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameReference<EmberQuestGame> {
  final Vector2 initialPosition;
  final Vector2 direction;
  final int fireDistance = 100;
  double speed;

  FireWeapon({
    required this.initialPosition,
    required this.direction,
    this.speed = 1000.0, // Harakat tezligini sozlash
  }) : super(size: Vector2.all(16), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Sprite animatsiyasini sozlash
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('fire.png'),
      SpriteAnimationData.sequenced(
        amount: 4, // Bir nechta ramka bo‘lishi mumkin
        textureSize: Vector2.all(16),
        stepTime: 0.1, // Ramkalar orasidagi vaqt
      ),
    );

    // Pozitsiyani belgilash
    position = initialPosition;

    // To‘qnashuvni aniqlash
    add(RectangleHitbox(collisionType: CollisionType.passive));
    add(CircleHitbox());
    // Harakat effekti qo‘shish
    add(
      MoveEffect.by(
        direction * speed * 4,
        EffectController(
          duration: 3, // Harakat davomiyligi
          alternate: false, // Effektda almashtirish bo‘lmasligi
        ),
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PlatformBlock) {
      // Handle collision with FireWeapon
      removeFromParent(); // Remove the FireWeapon
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.x > (initialPosition.x + fireDistance) ||
        position.x > game.size.x) {
      removeFromParent();
    } else if (position.x < (initialPosition.x - fireDistance) ||
        position.x < 0) {
      removeFromParent();
    }
  }
}
