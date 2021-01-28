import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/resizable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

class Background extends Component with Resizable {
  Sprite bgSprite;
  Rect bgRect;
  Background(Size size) {
    bgSprite = Sprite('night_sky.jpg');
    bgRect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );
  }

  @override
  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  @override
  void resize(Size size) {
    super.resize(size);
  }

  @override
  void update(double t) {
    // Not Needed for this component
    // If we allow to run on differnt platforms
    // where the window size could change then we may need to use, or
    // use the resize() override
  }
}
