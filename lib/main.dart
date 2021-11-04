
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/menus/main_menu.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  await Flame.util.setLandscape();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Einstiegsspiel',
      theme: ThemeData(
        fontFamily: 'VT323',
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(), // MyHomePage(title: 'Spot Run'),
    );
  }
}

