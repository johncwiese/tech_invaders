import 'package:flutter/material.dart';
import 'package:tech_invaders/widgets/main_container.dart';

// TODO: Could convert the GameOverScreen and TitleScreen into one that takes a param to
// determine which graphic to show, or better takes a graphic to show, since they are the same.
class GameOverScreen extends StatelessWidget {
  @override
  Widget build(context) {
    return MainContainer(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Text(
                    'GAME OVER',
                    style: TextStyle(
                      fontFamily: 'PressStart2P',
                      fontSize: MediaQuery.of(context).size.height >
                              MediaQuery.of(context).size.width
                          ? 48
                          : 64,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  FlatButton(
                    color: Colors.white24,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Start',
                        style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 32.0,
                            color: Colors.white70),
                      ),
                    ),
                    onPressed: (() {
                      Navigator.of(context).popAndPushNamed('/game');
                    }),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
