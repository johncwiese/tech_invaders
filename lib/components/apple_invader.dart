import 'package:tech_invaders/components/invader.dart';

class AppleInvader extends Invader {
  AppleInvader(double startingX, double startingY, double size)
      : super(startingX, startingY, size, 'apple.png') {
    this.invaderScore = 30;
  }
}
