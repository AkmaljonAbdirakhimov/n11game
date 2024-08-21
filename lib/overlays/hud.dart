import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../ember_quest.dart';
import 'heart.dart';

class Hud extends PositionComponent with HasGameReference<EmberQuestGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  });

  late TextComponent _scoreTextComponent;
  late TextComponent _timerTextComponent;
  late TextComponent _levelTextComponent;

  @override
  Future<void> onLoad() async {
    _scoreTextComponent = TextComponent(
      text: '${game.starsCollected}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(10, 10, 10, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x - 60, 20),
    );
    add(_scoreTextComponent);

    _timerTextComponent = TextComponent(
      text: 'Time: ${game.remainingTime}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(10, 10, 10, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x / 1.5, 20),
    );
    add(_timerTextComponent);

    _levelTextComponent = TextComponent(
      text: 'Level: ${game.currentLevel}',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromRGBO(10, 10, 10, 1),
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(game.size.x / 3, 20),
    );
    add(_levelTextComponent);

    final starSprite = await game.loadSprite('star.png');
    add(
      SpriteComponent(
        sprite: starSprite,
        position: Vector2(game.size.x - 80, 20),
        size: Vector2.all(16),
        anchor: Anchor.center,
      ),
    );

    for (var i = 1; i <= game.health; i++) {
      final positionX = 20 * i;
      await add(
        HeartHealthComponent(
          heartNumber: i,
          position: Vector2(positionX.toDouble(), 20),
          size: Vector2.all(16),
        ),
      );
    }
  }

  @override
  void update(double dt) {
    _scoreTextComponent.text = '${game.starsCollected}';
    _timerTextComponent.text = 'Time: ${game.remainingTime}';
    _levelTextComponent.text = 'Level: ${game.currentLevel}';
  }
}
