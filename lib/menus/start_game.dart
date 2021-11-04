

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/game/game.dart';


class MainGame extends StatelessWidget {
  final SpotGame _mainGame = SpotGame();
  MainGame({Key key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainGame.widget,
    );
  }

}

