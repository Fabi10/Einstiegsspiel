
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/game/game.dart';
import 'package:tutorial_game/screens/main_menu.dart';

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
      title: 'Spot Run',
      theme: ThemeData(
        fontFamily: 'VT323',
        primarySwatch: Colors.blue,
      ),
      home: MainMenu(), // MyHomePage(title: 'Spot Run'),
    );
  }
}


// FÄLLT WEG
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 SpotGame game;

 @override
  void initState() {
    super.initState();
    game = SpotGame();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: game.widget,
    );
  }
}
