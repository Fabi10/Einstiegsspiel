

import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/game/game.dart';


class GamePlay extends StatelessWidget{
  final SpotGame _game = SpotGame();

  GamePlay({Key key}) : super (key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _game.widget,
    );
  }

}

