import 'package:tech_invaders/components/invader.dart';

class AndroidInvader extends Invader {
  AndroidInvader(double startingX, double startingY, double size)
      : super(startingX, startingY, size, 'android.png') {
    this.invaderScore = 20;
  }
}
