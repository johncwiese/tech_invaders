import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flame/components/component.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

// This shows the number of lives remaining
class LivesDisplay extends SpriteComponent with HasGameRef<TechInvadersGame> {
  int lifeNumber;

  LivesDisplay(double tileSize, int lifeNumber, Size size)
      : super.rectangle(tileSize * 2, tileSize, 'green_ship.png') {
    this.anchor = Anchor.topLeft;
    this.lifeNumber = lifeNumber;

    this.x = lifeNumber == 1
        ? (size.width / 2) - (tileSize * 2) - 5
        : (size.width / 2) + 5;
    this.y = 40;
  }

  @override
  bool destroy() {
    if (gameRef.livesRemaining == lifeNumber) return true;
    return false;
  }
}
