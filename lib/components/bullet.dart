import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/anchor.dart';
import 'package:flutter/material.dart';
import 'package:tech_invaders/components/explosion.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

// This is the players bullet
class Bullet extends SpriteComponent with HasGameRef<TechInvadersGame> {
  bool hasHitBase = false;

  Bullet(Offset location) : super.fromSprite(4, 7, Sprite('bullet.png')) {
    this.anchor = Anchor.center;
    this.x = location.dx;
    this.y = location.dy;
    this.width = 4;
    this.height = 7;
  }

  @override
  void update(double t) {
    super.update(t);
    this.y -= 4;
  }

  @override
  bool destroy() {
    if (this.y < 100 || hasHitBase) {
      // if we don't limit to this check then we get the effect/sound
      // when the bullet hits the top of the screen and is removed too.
      if (hasHitBase) {
        Flame.audio.play('shortexplosion.wav');
        gameRef.addLater((Explosion(this.x, this.y, gameRef.tileSize)));
      }
      gameRef.bullet = null;
    }
    return gameRef.bullet == null;
  }
}
