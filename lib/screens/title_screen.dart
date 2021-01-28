import 'package:flutter/material.dart';
import 'package:tech_invaders/widgets/main_container.dart';

class TitleScreen extends StatelessWidget {
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
              child: Image(
                width: MediaQuery.of(context).size.width * .75,
                image: AssetImage('assets/images/logo.png'),
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
                    height: 50,
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
