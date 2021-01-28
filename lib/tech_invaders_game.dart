import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/flame.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_invaders/components/high_score_label.dart';
import 'package:tech_invaders/components/high_score_text.dart';
import 'package:tech_invaders/components/invader_bullet.dart';
import 'package:tech_invaders/components/android_invader.dart';
import 'package:tech_invaders/components/apple_invader.dart';
import 'package:tech_invaders/components/background.dart';
import 'package:tech_invaders/components/base.dart';
import 'package:tech_invaders/components/bullet.dart';
import 'package:tech_invaders/components/explosion.dart';
import 'package:tech_invaders/components/invader.dart';
import 'package:tech_invaders/components/lives_display.dart';
import 'package:tech_invaders/components/player_ship_explosion.dart';
import 'package:tech_invaders/components/score_label.dart';
import 'package:tech_invaders/components/score_text.dart';
import 'package:flame/game/base_game.dart';
import 'package:tech_invaders/components/ship_firing.dart';
import 'package:tech_invaders/components/player_ship.dart';
import 'package:tech_invaders/components/windows_invader.dart';
import 'package:tech_invaders/helpers.dart';

class TechInvadersGame extends BaseGame with Resizable, TapDetector {
  BuildContext context;

  double tileSize;
  MovingDirection currentDirection = MovingDirection.right;

  bool gameOver = false;
  bool shouldUpdate = false;
  bool gameInProgress = false;

  int _invadersPerRow = 11;
  int edgeSpacingPerRow = 6;
  int _defaultSpacing = 5;
  Size screenSize;
  double _initOffsetX;
  double _initOffsetY = 110;

  // Game Components
  Background background;
  PlayerShip ship;
  Bullet bullet;
  double base1Y;
  Base base1;
  Base base2;
  Base base3;
  Base base4;
  HighScoreLabel highScoreLabel;
  HighScoreText highScoreText;
  LivesDisplay livesDisplay1;
  LivesDisplay livesDisplay2;

  int _currentLevel = 1;
  int score;
  int livesRemaining;

  int invadersKilled;
  int invaderBulletCount;

  TechInvadersGame(Size size) {
    this.screenSize = size;
    tileSize = (size.width - ((_invadersPerRow + edgeSpacingPerRow - 1) * _defaultSpacing)) /
        (_invadersPerRow + edgeSpacingPerRow);
    _initOffsetX = (tileSize * (edgeSpacingPerRow / 2)) + (((edgeSpacingPerRow / 2) - 1) * _defaultSpacing);

    Flame.audio.loadAll(['explosion.wav', 'shortexplosion.wav', 'invaderkilled.wav', 'shoot.wav']);
  }

  void startGame() async {
    if (gameInProgress) {
      return;
    }
    gameInProgress = true;
    gameOver = false;
    shouldUpdate = true;

    addLater(background = Background(screenSize));

    addLater(ScoreLabel());
    addLater(ScoreText());
    score = 0;
    addLater(highScoreLabel = HighScoreLabel(screenSize));
    addLater(highScoreText = HighScoreText(screenSize));

    // Add Lives display
    addLater(livesDisplay1 = LivesDisplay(tileSize, 1, screenSize));
    addLater(livesDisplay2 = LivesDisplay(tileSize, 2, screenSize));
    livesRemaining = 3;

    addLater(ship = PlayerShip(tileSize, screenSize));

    startNewLevel();

    this.resumeEngine();
  }

  void startNewLevel() {
    _initialize();
    base1 == null ? addLater(base1 = Base(tileSize * 2, 1, 1, screenSize)) : updateBase(1, 1);
    base1Y = base1.y;
    base2 == null ? addLater(base2 = Base(tileSize * 2, 1, 2, screenSize)) : updateBase(2, 1);
    base3 == null ? addLater(base3 = Base(tileSize * 2, 1, 3, screenSize)) : updateBase(3, 1);
    base4 == null ? addLater(base4 = Base(tileSize * 2, 1, 4, screenSize)) : updateBase(4, 1);
    invadersKilled = 0;
    invaderBulletCount = 0;
  }

  void _initialize() async {
    resize(await Flame.util.initialDimensions());

    for (int r = 0; r < 5; r++) {
      for (int c = 0; c < 11; c++) {
        double x = _initOffsetX + (c * tileSize) + (c * _defaultSpacing);
        double y = _initOffsetY + (r * tileSize) + (r * _defaultSpacing);

        // need to start further down the screen for each level
        y += (_currentLevel - 1) * 5;

        if (r == 0) {
          addLater(AppleInvader(x, y, tileSize));
        } else if (r == 1 || r == 2) {
          addLater(AndroidInvader(x, y, tileSize));
        } else if (r == 3 || r == 4) {
          addLater(WindowsInvader(x, y, tileSize));
        }
      }
    }
  }

  void resetGame() async {
    shouldUpdate = false;
    gameOver = true; // Need this in case we ended because we lost all our lives
    bullet = null;
    gameInProgress = false;

    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final highScore = prefs.getInt('highscore') ?? 0;
    if (score > highScore) {
      // set value
      prefs.setInt('highscore', score);
    }

    //if (_invaderSoundPlayer != null) _invaderSoundPlayer.pause();
    components.clear();
    Navigator.of(context).popAndPushNamed('/game_over');
  }

  void moveShipLeft() {
    ship.moving = ShipMovement.left;
  }

  void moveShipRight() {
    ship.moving = ShipMovement.right;
  }

  void moveShipStop() {
    ship.moving = ShipMovement.stopped;
  }

  void playerShipDetroyed() {
    livesRemaining--;
    ship.alive = false;

    double locationX = ship.x;
    double locationY = ship.y;

    Flame.audio.play('explosion.wav');

    addLater(PlayerShipExplosion(locationX, locationY, tileSize));
    Future.delayed(const Duration(milliseconds: 500), () {
      addLater(PlayerShipExplosion(locationX, locationY, tileSize));
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      addLater(ship = PlayerShip(tileSize, screenSize));
    });
  }

  void shoot() {
    if (bullet == null) {
      Flame.audio.play('shoot.wav');
      addLater(ShipFiring(ship.x, ship.y, tileSize));
      addLater(bullet = Bullet(Offset(ship.x, ship.y)));
    }
  }

  void updateBase(int whichBase, int whatPhase) {
    switch (whichBase) {
      case (1):
        base1 = null;
        if (whatPhase < 20) addLater(base1 = Base(tileSize * 2, whatPhase, 1, screenSize));
        break;
      case (2):
        base2 = null;
        if (whatPhase < 20) addLater(base2 = Base(tileSize * 2, whatPhase, 2, screenSize));
        break;
      case (3):
        base3 = null;
        if (whatPhase < 20) addLater(base3 = Base(tileSize * 2, whatPhase, 3, screenSize));
        break;
      case (4):
        base4 = null;
        if (whatPhase < 20) addLater(base4 = Base(tileSize * 2, whatPhase, 4, screenSize));
        break;
      default:
        break;
    }
  }

  void createInvaderExplosion(double x, double y) {
    Flame.audio.play('invaderkilled.wav');
    addLater(Explosion(x, y, tileSize));
  }

  @override
  void resize(Size size) {
    this.screenSize = size;

    // Should probably have a "reposition()" in each component
    // that takes the new size (or uses the screenSize from gameRef)

    // replace the background so it is sized appropriately (this fixes when we go from single to dual-screen)
    background.bgRect = Rect.fromLTWH(0, 0, size.width, size.height);

    // need to reset the bases if the size changes
    double spacer = (size.width - ((tileSize * 2) * 4)) / 5;
    base1?.x = spacer;
    base1?.y = 110 + (((tileSize * 2) / 2) * 9);
    base2?.x = spacer + (spacer * (2 - 1)) + ((2 - 1) * (tileSize * 2));
    base2?.y = 110 + (((tileSize * 2) / 2) * 9);
    base3?.x = spacer + (spacer * (3 - 1)) + ((3 - 1) * (tileSize * 2));
    base3?.y = 110 + (((tileSize * 2) / 2) * 9);
    base4?.x = spacer + (spacer * (4 - 1)) + ((4 - 1) * (tileSize * 2));
    base4?.y = 110 + (((tileSize * 2) / 2) * 9);

    highScoreLabel.x = size.width - 40;
    highScoreText.x = size.width - 40;

    livesDisplay1.x = (size.width / 2) - (tileSize * 2) - 5;
    livesDisplay2.x = (size.width / 2) + 5;

    super.resize(size);
  }

  void addInvaderBullet(Invader invader, String invaderType) {
    //   if (invaderBullet1 == null)
    //   addLater(invaderBullet1 = InvaderBullet(invader, 1, invaderType));
    // else if (invaderBullet2 == null)
    //   addLater(invaderBullet2 = InvaderBullet(invader, 2, invaderType));
    // else if (invaderBullet3 == null)
    invaderBulletCount++;
    addLater(InvaderBullet(invader, 3, invaderType));
  }

  // Need this to be able to see backaground image
  @override
  Color backgroundColor() => const Color(0x00FFFFFF);

  @override
  void update(double t) {
    if (shouldUpdate) {
      if (gameOver || livesRemaining == 0) {
        pauseEngine();
        resetGame();
        return;
      }
    }

    if (invadersKilled == 55) {
      pauseEngine();
      _currentLevel++;
      // When we reach level 10 we reset back to the original height
      if (_currentLevel == 10) _currentLevel = 1;
      startNewLevel();
      bullet = null;
      resumeEngine();
    }
    super.update(t);
  }
}
