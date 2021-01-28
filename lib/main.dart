import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_invaders/screens/main_widget.dart';

void main() async {
  // Add the license for the fonts we are using from fonts.google.com
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();

  // We want to limit to Portrait, and we want the game to be fullscreen
  await Flame.util.setPortrait();
  await Flame.util.fullScreen();

  runApp(MainWidget());
}
