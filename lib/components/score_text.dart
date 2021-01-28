import 'package:flame/anchor.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

// This will show the current score of the player
class ScoreText extends TextComponent with HasGameRef<TechInvadersGame> {
  TextConfig regular = TextConfig(
      fontFamily: 'PressStart2P',
      fontSize: 18.0,
      color: Colors.white70,
      textAlign: TextAlign.left);

  ScoreText() : super('') {
    this.anchor = Anchor.topLeft;
    this.x = 40;
    this.y = 64;
    this.config = regular;
  }

  @override
  void update(double dt) {
    this.text = '${gameRef.score.toString().padLeft(4, '0')}';
    super.update(dt);
  }
}
