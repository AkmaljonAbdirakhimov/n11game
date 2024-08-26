import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:pixelbek/managers/level_manager.dart';

import 'actors/actors.dart';
import 'managers/segment_manager.dart';
import 'objects/objects.dart';
import 'overlays/overlays.dart';

class EmberQuestGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;
  late EmberPlayer ember;
  bool isGameStarted = false;
  double objectSpeed = 0.0;
  int starsCollected = 0;
  int health = 3;

// Timer-related variables
  late TimerComponent gameTimer;
  int remainingTime = 60; // Start with 60 seconds for the first level
  int requiredStars = 5; // Start with 5 stars for the first level
  int currentLevel = 1;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'fire.png',
    ]);
    await FlameAudio.audioCache.loadAll([
      'gun.mp3',
      'jump.mp3',
    ]);

    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewport.add(Hud());
  }

  void initializeGame(bool loadHud) {
    final segmentsToLoad = (size.x / 320).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (320 * i).toDouble());
    }

    ember = EmberPlayer(
      position: Vector2(64, canvasSize.y - 128),
    );
    world.add(ember);

    if (loadHud) {
      add(Hud());
    }
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    final randomSegments = LevelGenerator().generateLevel(5);
    for (final block in randomSegments[segmentIndex]) {
      switch (block.blockType) {
        case const (GroundBlock):
          world.add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
        case const (PlatformBlock):
          world.add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
        case const (Star):
          world.add(
            Star(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
        case const (WaterEnemy):
          final enemy = WaterEnemy(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          );
          final healthBar = HealthBar(
            enemy: enemy,
            maxWidth: enemy.size.x,
          );
          world.add(enemy);
          world.add(healthBar);
      }
    }
  }

  void reset() {
    starsCollected = 0;
    health = 3;
    remainingTime = 60;
    requiredStars = 5;
    currentLevel = 1;
    ember.removeFromParent();

    // Generate new random segments
    initializeGame(false);
    startTimer();
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  void update(double dt) {
    if ((health <= 0 || remainingTime <= 0) &&
        starsCollected != requiredStars) {
      world.removeAll(world.children.query<PositionComponent>());
      overlays.add('GameOver');
      gameTimer.timer.stop();
    }
    super.update(dt);
  }

  void startTimer() {
    gameTimer = TimerComponent(
      period: 1,
      repeat: true,
      onTick: () {
        remainingTime--;
        if (remainingTime <= 0) {
          gameTimer.timer.stop();
        }
        checkGameEnd();
      },
    );
    add(gameTimer);
  }

  void checkGameEnd() {
    if (starsCollected >= requiredStars) {
      // Move to next level
      world.removeAll(world.children.query<PositionComponent>());
      overlays.add('NextLevel');
      increaseLevel();
      gameTimer.timer.stop();
    }
  }

  void startNextLevel() {
    initializeGame(true);
    startTimer();
  }

  void increaseLevel() {
    world.removeAll(world.children.query<PositionComponent>());
    currentLevel++;
    starsCollected = 0;
    health = 3;
    remainingTime = 60 * (currentLevel / 2).round();
    requiredStars = requiredStars * currentLevel;
    ember.removeFromParent();

    isGameStarted = true;
  }
}
