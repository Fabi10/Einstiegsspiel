import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/game/enemy.dart';
import 'package:tutorial_game/game/enemy_manager.dart';
import 'package:tutorial_game/game/spot_manager.dart';
import 'package:tutorial_game/game/spots.dart';
import 'dino.dart';

// DINO-KLASSE
class Game extends BaseGame with HasTapableComponents, HasWidgetsOverlay {
  Dino _dino;

  SpriteComponent detector;

  // Fortlaufender 3D Effekt Hintergrund
  ParallaxComponent parallaxComponent;

  // Timer-Anzeige
  TextComponent _timeDisplay;
  Timer _timer;
  int time = 90;

  // Punkte-Anzeige
  TextComponent name;
  TextComponent _scoreText;
  int score;

  Random _random;
  Manager m;

  // Leben
  ValueNotifier<int> lifePoints;

  // ==================================================

  // = =======================================

  Game() {
    lifePoints = ValueNotifier(3);

    // Hauthintergund - evt mit mehreren Ebenen
    parallaxComponent = ParallaxComponent([
      ParallaxImage('background.png'),
      ParallaxImage('layer.png'),
    ],
        // 100 = x-Richtung; 0 = y-Richtung
        baseSpeed: Offset(130, 0));
    //layerDelta: Offset(20, 0));

    add(parallaxComponent);

    _dino = Dino();
    //add(_dino);

    score = 0;
    _scoreText = TextComponent("Punkte: $score ", //+ score.toString()
        config: TextConfig(
          fontFamily: 'VT323',
          color: Colors.black,
          fontSize: 55.0,
        ));

    _timeDisplay = TextComponent(time.toString(),
        config: TextConfig(
          fontFamily: 'VT323',
          color: Colors.black,
          fontSize: 75.0,
        ));

    add(_timeDisplay);
    add(_scoreText);

    // Weiteres Widget anzeigen lassen
    addWidgetOverlay('headerDisplay', _buildHeader());

    startTimer(time);


    _random = Random();

    // ==================================================

    Manager _manager = Manager();
    add(_manager);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    _timeDisplay.setByPosition(
        Position(((size.width / 2) - (_timeDisplay.width * 4)), 5));

    // NEU
    _scoreText.setByPosition(Position(((size.width / 2)), 10));
  }

  @override
  void update(double t) {
    super.update(t);
    //score += (60 * t).toInt();
    _timeDisplay.text = time.toString();
    //_scoreText.text = score.toString();
    _scoreText.text = "Punkte: $score";

    // Gameover bei Lebenspunkte = 0
    if (lifePoints.value == 0) {
      gameOver();
    }

    if(time <= 40){
      parallaxComponent.baseSpeed = Offset(160, 0);

    }
  }

  // Timer startet von 90 Sekunden
  void startTimer(int value) {
    time = value;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time > 0) {
        time -= 1;
      } else {
        _timer.cancel();
        gameOver();
      }
    });
  }

  // Spiel pausiert, wenn man App schließt
  @override
  lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        this.pauseGame();
        break;
      case AppLifecycleState.paused:
        this.pauseGame();
        break;
      case AppLifecycleState.detached:
        this.pauseGame();
        break;
    }
  }

  Widget _buildHeader() {
    return Card(
      //shape: RoundedRectangleBorder(
      //  borderRadius: BorderRadius.circular(20.0),
      //),
      color: Colors.white.withOpacity(0.1),
      child:
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 50.0,
          vertical: 15.0,
        ),
            child:
            Row(
              // Alle Elemente haben so viel Platz wie möglich zueinander
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      // Aufruf Pause Bildschirm
                      pauseGame();
                    },
                    icon: Icon(
                      Icons.pause_circle_outline,
                      color: Colors.black,
                      size: 60.0,
                    ),
                    iconSize: 50.0 ,
                  ),

                  //Lebenspunkte
                  ValueListenableBuilder(
                    valueListenable: this.lifePoints,
                    builder: (BuildContext context, value, Widget child) {
                      List<Widget> list = <Widget>[];
                      for (int i = 0; i < 3; ++i) {
                        list.add(
                          Icon(
                            (i < value) ? Icons.favorite_outlined : Icons.favorite_border,
                            color: Color(0xFF2D8064),
                            size: 40.0,
                          ),
                        );
                      }
                      return Row(
                        children: list,
                      );
                    },
                  )
                ])
          ,
      ),

    );

  }

  void pauseGame() {
    pauseEngine();
    if (_timer.isActive) {
      _timer.cancel();
      //_spotTimer.cancel();
    }
    // Pause-Bildschirm Widget
    addWidgetOverlay('PauseMenu', _buildPauseMenu());
  }

  Widget _buildPauseMenu() {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Color(0xFF2D8064).withOpacity(0.8),
        //Color(0xFF2D8064).withOpacity(0.5),
        // Colors.black.withOpacity(0.5),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 100.0,
            vertical: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pause',
                style: TextStyle(
                  fontSize: 60.0,
                  color: Colors.white,
                ),
              ),
              Text(
                "  ",
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Weiter ",
                      style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      resumeGame();
                    },
                    iconSize: 50.0,
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                  Text(
                    "  ",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                      "Zur Info-App ",
                      style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Zur App
                    },
                    iconSize: 50.0,
                    icon: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resumeGame() {
    removeWidgetOverlay('PauseMenu');
    resumeEngine();
    if (!_timer.isActive) {
      startTimer(time);

    }
  }

  void gameOver() {
    pauseEngine();
    addWidgetOverlay('GameoverMenu', _gameoverMenu());
  }

  Widget _gameoverMenu() {
    return Center(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Color(0xFF2D8064).withOpacity(0.8),//Color(0xFF83AA74),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 100.0,
              vertical: 50.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Gameover',
                  style: TextStyle(fontSize: 70.0, color: Colors.white),
                ),
                Text("   ",
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                Text(
                  'Du hast $score verdächtige Flecken richtig erkannt. Gar nicht so schlecht!',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                Text("   ",
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 250,
                      height: 150,
                      child:
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.white.withOpacity(0.8),

                        child:
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 20.0,
                          ),
                          child:
                          Column(
                            children: [
                              Text(
                                'Neustart',
                                style: TextStyle(fontSize: 30.0, color: Colors.black),
                              ),
                              IconButton(
                                  onPressed: () {
                                    reset();
                                    removeWidgetOverlay('GameoverMenu');
                                    resumeEngine();
                                  },
                                  iconSize: 50,
                                  icon: Icon(
                                    Icons.replay,
                                    color: Colors.black,
                                    size: 50.0,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 150,
                      child:
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.white.withOpacity(0.8),
                        child:
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 20.0,
                          ),
                          child:
                          Column(
                            children: [
                              Text(
                                'Zur Info-App',
                                style: TextStyle(fontSize: 30.0, color: Colors.black),
                              ),
                              IconButton(
                                  onPressed: () {
                                    // Zur App
                                  },
                                  iconSize: 50,
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.black,
                                    size: 50.0,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  // NEUSTART
  void reset() {
    this.score = 0;

    // Neustart Zeit-Timer
    _timer.cancel();
    this.time = 90;
    startTimer(time);

    this.lifePoints.value = 3;

    //_enemyManager.reset();

    // Alle Enemy-Komponenten werden gelöscht vor dem Restart
    components.whereType<Enemy>().forEach((enemy) {
      this.markToRemove(enemy);
    });

    // Flecken löschen
    components.whereType<Spot>().forEach((spot) {
      this.markToRemove(spot);
    });

    parallaxComponent.baseSpeed = Offset(130, 0);
  }
}
