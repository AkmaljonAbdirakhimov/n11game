import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/services.dart';
import 'package:n11game/overlays/overlays.dart';
import '../ember_quest.dart';
import '../objects/objects.dart';
import 'actors.dart';

class EmberPlayer extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks, HasGameReference<EmberQuestGame> {
  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(32), anchor: Anchor.center);

  int horizontalDirection = 0;
  final Vector2 velocity = Vector2.zero();
  final double moveSpeed = 200;
  final Vector2 fromAbove = Vector2(0, -1);
  bool isOnGround = false;
  Direction direction = Direction.right;
  final double gravity = 30;
  final double jumpSpeed = 600;
  final double terminalVelocity = 150;

  bool hasJumped = false;
  bool hitByEnemy = false;

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
    add(CircleHitbox());
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyA) ||
            keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    horizontalDirection += (keysPressed.contains(LogicalKeyboardKey.keyD) ||
            keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);

    if (keysPressed.contains(LogicalKeyboardKey.keyE)) {
      game.fireWeapon();
    }

    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is GroundBlock || other is PlatformBlock) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;

        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        if (fromAbove.dot(collisionNormal) > 0.9) {
          isOnGround = true;
        }

        position += collisionNormal.scaled(separationDistance);
      }
    }

    if (other is Star) {
      other.removeFromParent();
      game.starsCollected++;
    }

    if (other is WaterEnemy || other is WaterBigEnemy) {
      hit();
    }

    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    if (!hitByEnemy) {
      game.health--;
      hitByEnemy = true;
    }
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 6,
        ),
      )..onComplete = () {
          hitByEnemy = false;
        },
    );
  }

  @override
  void update(double dt) {
    velocity.x = horizontalDirection * moveSpeed;

    if (horizontalDirection < 0 && scale.x > 0) {
      direction = Direction.left;
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      direction = Direction.right;
      flipHorizontally();
    }

    velocity.y += gravity;

    if (hasJumped) {
      FlameAudio.play('jump.mp3');
      if (isOnGround) {
        velocity.y = -jumpSpeed;
        isOnGround = false;
      }
      hasJumped = false;
    }

    velocity.y = velocity.y.clamp(-jumpSpeed, terminalVelocity);

    game.objectSpeed = 0;

    // Camera movement logic
    if (position.x > game.size.x / 3 && horizontalDirection > 0) {
      // If ember is beyond the deadzone and moving right,
      // scroll the world instead of moving the ember
      game.objectSpeed = -moveSpeed;
      velocity.x = 0;
    } else if (position.x < size.x / 2 && horizontalDirection < 0) {
      // Prevent ember from going too far left
      velocity.x = 0;
    }

    position += velocity * dt;

    if (position.y > game.size.y + size.y) {
      game.health = 0;
    }

    if (game.health <= 0) {
      removeFromParent();
    }

    super.update(dt);
  }
}
