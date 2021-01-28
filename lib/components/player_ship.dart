import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

enum ShipMovement { left, right, stopped }

class PlayerShip extends SpriteComponent with Resizable, HasGameRef<TechInvadersGame> {
  ShipMovement moving = ShipMovement.stopped;
  bool alive = true;
  Size size;

  PlayerShip(double tileSize, Size size, {double specifiedX = -1})
      : super.rectangle(tileSize * 1.5, tileSize, 'green_ship.png') {
    this.anchor = Anchor.center;
    double spacer = (size.width - (tileSize * 8)) / 5;
    this.x = spacer + (tileSize);
    this.y = 110 +
        (tileSize * 9) +
        (tileSize * 2); // original starting point of the invaders + room to drop 9 rows, + base height
    this.size = size;
  }

  void update(double t) {
    if (moving == ShipMovement.left) {
      if (this.x > gameRef.edgeSpacingPerRow + (gameRef.tileSize * 2)) {
        this.x -= 2;
      }
    }

    if (moving == ShipMovement.right) {
      if (this.x < size.width - gameRef.edgeSpacingPerRow - (gameRef.tileSize * 2)) {
        this.x += 2;
      }
    }
    super.update(t);
  }

  @override
  void resize(Size size) {
    this.size = size;
    super.resize(size);
  }

  @override
  bool destroy() {
    if (!alive) return true;
    return super.destroy();
  }
}
