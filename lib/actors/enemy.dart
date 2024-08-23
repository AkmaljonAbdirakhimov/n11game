import 'package:flame/components.dart';

abstract class Enemy extends SpriteAnimationComponent {
  Enemy({
    super.size,
    super.anchor,
  });

  int get health;
  int get maxHealth;
}
