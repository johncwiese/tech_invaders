import 'package:tech_invaders/components/invader.dart';

class WindowsInvader extends Invader {
  WindowsInvader(double startingX, double startingY, double size)
      : super(startingX, startingY, size, 'windows.png') {
    this.invaderScore = 10;
  }
}
