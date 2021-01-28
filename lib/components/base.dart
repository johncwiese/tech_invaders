import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

class Base extends SpriteComponent with Resizable, HasGameRef<TechInvadersGame> {
  int _whichBase;
  double _spacer;

  int basePhase;
  bool shouldDestroy = false;

  Base(double baseWidth, int basePhase, int whichBase, Size size)
      : super.rectangle(baseWidth, baseWidth * 0.5, 'base$basePhase.png') {
    this.anchor = Anchor.centerLeft;
    this.basePhase = basePhase;
    this._whichBase = whichBase;
    _spacer = (size.width - (baseWidth * 4)) / 5;

    this.x = _spacer + (_spacer * (whichBase - 1)) + ((whichBase - 1) * baseWidth);
    this.y = 110 + ((baseWidth / 2) * 9); // original top row starting point + room for 11 rows
  }

  @override
  void update(double dt) {
    if (gameRef.bullet != null && !shouldDestroy && !gameRef.bullet.hasHitBase) {
      if (this.toRect().contains(gameRef.bullet.toRect().topCenter) ||
          this.toRect().contains(gameRef.bullet.toRect().topLeft) ||
          this.toRect().contains(gameRef.bullet.toRect().topRight)) {
        shouldDestroy = true;
        gameRef.bullet.hasHitBase = true;
        gameRef.updateBase(_whichBase, ++basePhase);
      }
    }

    super.update(dt);
  }

  @override
  bool destroy() {
    super.destroy();
    if (shouldDestroy) return true;
    return false;
  }
}
