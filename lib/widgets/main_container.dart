import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  final Widget child;

  MainContainer({this.child});

  @override
  Widget build(ctx) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/night_sky.jpg"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: child,
      ),
    );
  }
}
