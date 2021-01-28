import 'package:flame/anchor.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

// This is the label 'Score' shown above the players score
class ScoreLabel extends TextComponent with HasGameRef<TechInvadersGame> {
  TextConfig regular = TextConfig(
      fontFamily: 'PressStart2P',
      fontSize: 18.0,
      color: Colors.white70,
      textAlign: TextAlign.left);

  ScoreLabel() : super('') {
    this.anchor = Anchor.topLeft;
    this.x = 40;
    this.y = 40;
    this.config = regular;
    this.text = 'Score';
  }
}
