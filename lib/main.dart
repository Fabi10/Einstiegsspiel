
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/game/game.dart';

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
      home: MyHomePage(title: 'Spot Run'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 Game game;

 @override
  void initState() {
    super.initState();
    game = Game();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: game.widget,
    );
  }
}
