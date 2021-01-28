import 'package:flame/anchor.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/components/animation_component.dart';
import 'package:tech_invaders/tech_invaders_game.dart';

// This is played when the player is killed
class PlayerShipExplosion extends AnimationComponent
    with Resizable, HasGameRef<TechInvadersGame> {
  PlayerShipExplosion(double startingX, double startingY, double tileSize)
      : super.sequenced(tileSize, tileSize, 'ship_destroyed.png', 4,
            textureHeight: 120, textureWidth: 120, destroyOnFinish: true) {
    this.anchor = Anchor.center;
    this.x = startingX;
    this.y = startingY;
  }
}
