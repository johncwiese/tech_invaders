import 'package:flutter/material.dart';
import 'package:tech_invaders/widgets/button.dart';

class Gamepad extends StatelessWidget {
  const Gamepad({
    Key key,
    @required game,
  })  : _game = game,
        super(key: key);

  final _game;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 48),
        Button(
          icon: Icons.arrow_left,
          onPressed: () {
            _game.moveShipLeft();
          },
          onReleased: () {
            _game.moveShipStop();
          },
        ),
        SizedBox(width: 24),
        Button(
          icon: Icons.arrow_right,
          onPressed: () {
            _game.moveShipRight();
          },
          onReleased: () {
            _game.moveShipStop();
          },
        ),
        Spacer(),
        Button(
          icon: Icons.gps_fixed,
          onPressed: () {
            _game.shoot();
          },
          onReleased: () {},
        ),
        SizedBox(width: 48),
      ],
    );
  }
}
