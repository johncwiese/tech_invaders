import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function() onPressed;
  final void Function() onReleased;

  final IconData icon;
  const Button({
    Key key,
    @required this.onPressed,
    @required this.onReleased,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = (MediaQuery.of(context).size.width - 80) / 4;
    return SizedBox(
      height: size,
      width: size,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.grey,
        ),
        child: GestureDetector(
          child: Icon(icon, size: size * .8, color: Colors.white),
          onPanDown: (DragDownDetails d) {
            onPressed();
          },
          onPanEnd: (DragEndDetails d) {
            onReleased();
          },
        ),
      ),
    );
  }
}
