import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tech_invaders/screens/game_over_screen.dart';
import 'package:tech_invaders/screens/title_screen.dart';
import 'package:tech_invaders/tech_invaders_game.dart';
import 'package:tech_invaders/widgets/gamepad.dart';
import 'package:multiple_screens/multiple_screens.dart';

class MainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainWidgetState();
  }
}

class _MainWidgetState extends State<MainWidget> with WidgetsBindingObserver {
  var _game;
  var _size;
  //bool _isMultipleDevice;
  bool _isAppSpannedStream;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  void initGame() async {
    _size = await Flame.util.initialDimensions();
    _game = TechInvadersGame(_size);
//    _isMultipleDevice = await MultipleScreensMethods.isMultipleScreensDevice;
    MultipleScreensMethods.isAppSpannedStream().listen((data) => 
      setState(() => _isAppSpannedStream = data));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/splash_screen': (ctx) => FlameSplashScreen(
              theme: FlameSplashTheme.dark,
              showBefore: (BuildContext context) {
                return Image.asset('assets/images/logo.png', width: 300);
              },
              onFinish: (BuildContext context) {
                Navigator.popAndPushNamed(context, "/title");
              },
            ),
        '/title': (ctx) => TitleScreen(),
        '/game_over': (ctx) => GameOverScreen(),
        '/game': (ctx) {
          _game.context = ctx;
          _game.startGame();
          if (_isAppSpannedStream == null || !_isAppSpannedStream) {
            Flame.util.setPortrait();
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Stack(
                children: [
                  _game.widget,
                  Column(
                    children: [
                      Spacer(),
                      Gamepad(game: _game),
                      SizedBox(height: 64),
                    ],
                  ),
                ],
              ),
            );
          } else {
            Flame.util.setPortrait();
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: _game.widget,
                ),
                SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black,
                    child: Gamepad(game: _game),
                  ),
                ),
              ],
            );
          }
        },
      },
      initialRoute: '/splash_screen',
    );
  }
}
