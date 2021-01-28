import 'dart:math';

import 'package:flame/anchor.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flutter/material.dart';
import 'package:tech_invaders/helpers.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

class Invader extends AnimationComponent with Resizable, HasGameRef<TechInvadersGame> {
  double _screenHeight = 0.0;
  MovingDirection _previousDirection;
  bool _alive = true;
  double _moveSpeed = 15.0;
  int _prevNumberOfInvadersKilled = 0;
  var _random = new Random();

  int invaderScore;

  Invader(double startingX, double startingY, double size, String imagePath)
      : super.sequenced(size * .8, size * .8, imagePath, 2, textureHeight: 120, textureWidth: 120) {
    this.anchor = Anchor.center;
    this.x = startingX;
    this.y = startingY;
  }

  @override
  void resize(Size size) {
    _screenHeight = size.height;
    super.resize(size);
  }

  @override
  void update(double t) {
    if (_previousDirection == null) _previousDirection = gameRef.currentDirection;
    if (_alive) {
      int topChange = 0;
      if (gameRef.currentDirection != _previousDirection) {
        topChange = 10;
      }

      this.x += (t * ((_previousDirection == MovingDirection.right) ? _moveSpeed : -_moveSpeed));
      this.y += topChange;

      // Have we reached the ship?  If so game is over!
      if (gameRef.ship != null && this.y >= gameRef.ship.y) {
        gameRef.gameOver = true;
      }

      _previousDirection = gameRef.currentDirection;

      // As invaders are killed the invaders should speed up
      if (gameRef.invadersKilled > 0 && gameRef.invadersKilled % 12 == 0) {
        // Make sure we haven't already increased the speed for the same # killed
        // because of the game loop this could run across a lot of invaders
        // before you kill another one and exponentially increase the speed :)
        if (gameRef.invadersKilled != _prevNumberOfInvadersKilled) {
          _prevNumberOfInvadersKilled = gameRef.invadersKilled;
          _moveSpeed += 4; // may need to play with the speed
          print('Invader Speed Increased!');
        }
      }
    } else {}

    if (_alive && gameRef.bullet != null) {
      _alive = !(this.toRect().contains(gameRef.bullet.toRect().topCenter) ||
          this.toRect().contains(gameRef.bullet.toRect().topLeft) ||
          this.toRect().contains(gameRef.bullet.toRect().topRight));
      if (!_alive) {
        gameRef.invadersKilled++;
        gameRef.score += this.invaderScore;
        gameRef.bullet = null;

        gameRef.createInvaderExplosion(this.x, this.y);
      }
    }

    if (gameRef.currentDirection == MovingDirection.right) {
      if (this.x + gameRef.tileSize > gameRef.screenSize.width - 30) gameRef.currentDirection = MovingDirection.left;
    } else {
      if (this.x < 30) gameRef.currentDirection = MovingDirection.right;
    }

    if (gameRef.invaderBulletCount < 3) {
      if (_random.nextInt(30) == 3) {
        switch (this.runtimeType.toString().toLowerCase()) {
          case 'androidinvader':
            gameRef.addInvaderBullet(this, 'android');
            break;
          case 'appleinvader':
            gameRef.addInvaderBullet(this, 'apple');
            break;
          case 'windowsinvader':
            gameRef.addInvaderBullet(this, 'windows');
            break;
        }
      }
    }

    super.update(t);
  }

  @override
  bool destroy() {
    //print('Current Y : ${this.y}');
    if ((!_alive) || ((this.y > (_screenHeight - 100)) && _screenHeight != 0.0)) {
      return true;
    } else {
      return false;
    }
  }
}
