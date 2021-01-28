import 'package:flame/anchor.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

// Displays the current high score
class HighScoreText extends TextComponent with HasGameRef<TechInvadersGame> {
  TextConfig regular = TextConfig(
      fontFamily: 'PressStart2P',
      fontSize: 18.0,
      color: Colors.white70,
      textAlign: TextAlign.left);

  HighScoreText(Size size) : super('') {
    this.anchor = Anchor.topRight;
    this.x = size.width - 40;
    this.y = 64;
    this.config = regular;
    _setHighScore();
  }

  void _setHighScore() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final highScore = prefs.getInt('highscore') ?? 0;

    this.text = '${highScore.toString().padLeft(4, '0')}';
  }
}
