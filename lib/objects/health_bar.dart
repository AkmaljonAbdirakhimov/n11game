import 'dart:ui';

import 'package:flame/components.dart';
import 'package:pixelbek/actors/enemy.dart';

class HealthBar extends PositionComponent {
  final Enemy enemy;
  final double maxWidth;
  late RectangleComponent _bar;

  HealthBar({required this.enemy, required this.maxWidth})
      : super(size: Vector2(64, 8));

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _bar = RectangleComponent(
      size: Vector2(maxWidth, size.y),
      paint: Paint()..color = const Color(0xFFFF0000),
      anchor: Anchor.topLeft,
    );
    add(_bar);

    // Set initial position
    position = enemy.position - Vector2(0, 0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update the width of the health bar based on the enemy's current health
    _bar.size.x =
        ((enemy.health / enemy.maxHealth) * maxWidth).ceil().toDouble();
    if (_bar.size.x <= 0) {
      removeFromParent();
    }
    // Position the health bar above the enemy
    position = enemy.position - Vector2(0, enemy.size.y + 10);
  }
}
