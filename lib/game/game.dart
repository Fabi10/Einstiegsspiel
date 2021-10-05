
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/game/enemy.dart';
import 'package:tutorial_game/game/spot_manager.dart';
import 'package:tutorial_game/game/spots.dart';
import 'dino.dart';



// DINO-KLASSE
class Game extends BaseGame with HasTapableComponents, HasWidgetsOverlay {
  Dino _dino;

  SpriteComponent detector;


  // Fortlaufender 3D Effekt Hintergrund
  ParallaxComponent _parallaxComponent;

  // Timer-Anzeige
  TextComponent _timeDisplay;
  Timer _timer;
  int time = 90;

  // Punkte-Anzeige
  TextComponent _scoreText;
  int score;

  Random _random;
  Manager m;

  // Leben
  ValueNotifier<int> lifePoints;

  // ==================================================

  // = =======================================


  Game() {
    lifePoints = ValueNotifier(4);

    // Hauthintergund - evt mit mehreren Ebenen
    _parallaxComponent = ParallaxComponent([
      ParallaxImage('background.png'),
      ParallaxImage('layer.png'),
    ],
        // 100 = x-Richtung; 0 = y-Richtung
        baseSpeed: Offset(130, 0));
        //layerDelta: Offset(20, 0));

    add(_parallaxComponent);

    _dino = Dino();
    //add(_dino);

    //_enemyManager = EnemyManager();
    //add(_enemyManager);



    score = 0;
    _scoreText = TextComponent(score.toString(),
        config: TextConfig(
          fontFamily: 'Audiowide',
          color: Colors.black,
          fontSize: 35.0,
        ));

    _timeDisplay = TextComponent(time.toString(),
        config: TextConfig(
          fontFamily: 'Audiowide',
          color: Colors.black,
          fontSize: 50.0,
        ));

    add(_timeDisplay);
    add(_scoreText);

    // Weiteres Widget anzeigen lassen
    addWidgetOverlay('headerDisplay', _buildHeader());

    startTimer(time);


    detector = SpriteComponent.rectangle(24, 899, 'balken.png');
    detector.x = 0;
    detector.y = 50;



    // ==== TEST SPAWNING ===============================
   //_spotTimer = Timer.periodic(Duration(seconds: 3), (timer) {
   //  spawnRandom();
   //});

    _random = Random();

    // ==================================================

    Manager _manager = Manager();
    add(_manager);
    add(detector);

  }

  // Tapdetector - wenn auf gesamten Bildschirm getippt wird
  //@override
  //void onTapDown(TapDownDetails details) {
  //  super.onTapDown(details);
  //  _dino.jump();
//
  //}



  @override
  void resize(Size size) {
    super.resize(size);
    _timeDisplay.setByPosition(
        Position(((size.width / 2) - (_timeDisplay.width / 2)), 0));

    // NEU
    _scoreText.setByPosition(
        Position(((size.width / 2) + 150), 0));

    detector.setByPosition(Position(0, 50));
    detector.height = size.height;
  }

  @override
  void update(double t) {
    super.update(t);
    //score += (60 * t).toInt();
    _timeDisplay.text = time.toString();
    _scoreText.text = score.toString();

    // Liste aller Komponenten des Spiels -> Spezifiziert auf Enemy
    components.whereType<Enemy>().forEach((enemy) {
      if (_dino.distance(enemy) < 30) {
        _dino.hit();
      }
    });

    components.whereType<Spot>().forEach((spot) {
      if (detector.distance(spot) == 0) {
        print('detect');
        if(spot.getInfo() == true){
          this.lifePoints.value -= 1;
          print("Spot Hit");
        }
      }
    });


    if (_dino.life.value <= 0) {
      gameOver();
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
    return Row(
        // Alle Elemente haben so viel Platz möglich zueinander
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              // Aufruf Pause Bildschirm
              pauseGame();
            },
            icon: Icon(
              Icons.pause,
              color: Colors.black,
              size: 50.0,
            ),
          ),

          //Lebenspunkte
          ValueListenableBuilder(
            valueListenable: this.lifePoints,
            builder: (BuildContext context, value, Widget child) {
              List<Widget> list = <Widget>[];
              for (int i = 0; i < 4; ++i) {
                list.add(
                  Icon(
                    (i < value) ? Icons.favorite : Icons.favorite_border,
                    color: Color(0xFF2D8064),//Colors.red,
                  ),
                );
              }

              return Row(
                children: list,
              );
            },
          )
        ]);
  }

  void pauseGame() {
    pauseEngine();
    if(_timer.isActive){
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
        color: Colors.black.withOpacity(0.5),
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
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  resumeGame();
                },
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 30.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void resumeGame() {
    removeWidgetOverlay('PauseMenu');
    resumeEngine();
    if(!_timer.isActive){
      startTimer(time);
      //_spotTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      //  spawnRandom();
      //});


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
          color: Colors.black.withOpacity(0.5),
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
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                Text(
                  'Du hast $score Flecken richtig erkannt. Gar nicht so schlecht!',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                IconButton(
                    onPressed: () {
                      reset();
                      removeWidgetOverlay('GameoverMenu');
                      resumeEngine();
                    },
                    icon: Icon(
                      Icons.replay,
                      color: Colors.white,
                      size: 30.0,
                    )),
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

    //SPOTTIMER
    //_spotTimer.cancel();
    //_spotTimer = Timer.periodic(Duration(seconds: 3), (timer) {
    //  spawnRandom();
    //});
    // ==========

    this.lifePoints.value = 4;
    //_dino.life.value = 5;
    //_dino.run();
    //_enemyManager.reset();

    // Alle Enemy-Komponenten werden gelöscht vor dem Restart
    components.whereType<Enemy>().forEach((enemy) {
      this.markToRemove(enemy);
    });

    // Flecken löschen
    components.whereType<Spot>().forEach((spot) {
      this.markToRemove(spot);
    });
  }


}
