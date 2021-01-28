import 'package:flame/components/animation_component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/anchor.dart';
import 'package:flutter/material.dart';
import 'package:tech_invaders/components/invader.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

class InvaderBullet extends AnimationComponent with HasGameRef<TechInvadersGame> {
  bool _shouldDestroy = false;

  InvaderBullet(Invader invader, int bulletNumber, String invaderType)
      : super.sequenced(7, 15, '${invaderType}_bullet.png', 2, textureHeight: 60, textureWidth: 28) {
    this.anchor = Anchor.center;
    this.x = invader.x;
    this.y = invader.y;
  }

  @override
  void update(double t) {
    super.update(t);
    this.y += 1;
    if (gameRef.base1 != null) {
      if (gameRef.base1.toRect().contains(this.toRect().bottomCenter) ||
          gameRef.base1.toRect().contains(this.toRect().bottomLeft) ||
          gameRef.base1.toRect().contains(this.toRect().bottomRight)) {
        _shouldDestroy = true;
        gameRef.base1.shouldDestroy = true;
        gameRef.updateBase(1, ++gameRef.base1.basePhase);
      }
    }

    if (gameRef.base2 != null) {
      if (gameRef.base2.toRect().contains(this.toRect().bottomCenter) ||
          gameRef.base2.toRect().contains(this.toRect().bottomLeft) ||
          gameRef.base2.toRect().contains(this.toRect().bottomRight)) {
        _shouldDestroy = true;
        gameRef.base2.shouldDestroy = true;
        gameRef.updateBase(2, ++gameRef.base2.basePhase);
      }
    }
    if (gameRef.base3 != null) {
      if (gameRef.base3.toRect().contains(this.toRect().bottomCenter) ||
          gameRef.base3.toRect().contains(this.toRect().bottomLeft) ||
          gameRef.base3.toRect().contains(this.toRect().bottomRight)) {
        _shouldDestroy = true;
        gameRef.base3.shouldDestroy = true;
        gameRef.updateBase(3, ++gameRef.base3.basePhase);
      }
    }
    if (gameRef.base4 != null) {
      if (gameRef.base4.toRect().contains(this.toRect().bottomCenter) ||
          gameRef.base4.toRect().contains(this.toRect().bottomLeft) ||
          gameRef.base4.toRect().contains(this.toRect().bottomRight)) {
        _shouldDestroy = true;
        gameRef.base4.shouldDestroy = true;
        gameRef.updateBase(4, ++gameRef.base4.basePhase);
      }
    }

    if (gameRef.bullet != null) {
      if (gameRef.bullet.toRect().contains(this.toRect().bottomCenter) ||
          gameRef.bullet.toRect().contains(this.toRect().bottomLeft) ||
          gameRef.bullet.toRect().contains(this.toRect().bottomRight)) {
        // not ideal, but this will get the result we want of the bullet being taken out
        // this shouldn't cause an issue as the bullet will be removed so no base will be
        // affected by using this
        gameRef.bullet.hasHitBase = true;
      }
    }

    Rect ship = gameRef.ship.toRect();
    if (ship.contains(this.toRect().bottomCenter) ||
        ship.contains(this.toRect().bottomLeft) ||
        ship.contains(this.toRect().bottomRight)) {
      gameRef.playerShipDetroyed();
      _shouldDestroy = true;
    }
  }

  @override
  bool destroy() {
    if (this.y > gameRef.ship.y || _shouldDestroy) {
      gameRef.invaderBulletCount--;
      return true;
    } else {
      return false;
    }
  }
}
