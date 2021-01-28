import 'package:flame/anchor.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

// Displays the 'High' label above the high score
class HighScoreLabel extends TextComponent with HasGameRef<TechInvadersGame> {
  TextConfig regular = TextConfig(
      fontFamily: 'PressStart2P',
      fontSize: 18.0,
      color: Colors.white70,
      textAlign: TextAlign.left);

  HighScoreLabel(Size size) : super('') {
    this.anchor = Anchor.topRight;
    this.x = size.width - 40;
    this.y = 40;
    this.config = regular;
    this.text = 'High';
  }
}
