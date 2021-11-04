import 'dart:async';
import 'dart:ui';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/game/spot_manager.dart';
import 'package:tutorial_game/game/spots.dart';
import 'package:tutorial_game/menus/gameover.dart';


import 'package:url_launcher/url_launcher.dart';


class SpotGame extends BaseGame with HasTapableComponents, HasWidgetsOverlay {

  // Fortlaufender 3D Effekt Hintergrund
  ParallaxComponent parallaxBackground;

  // Timer-Anzeige
  TextComponent _timeDisplay;
  Timer _timer;
  int time = 90;

  // Punkte-Anzeige
  TextComponent _scoreDisplay;
  int score;

  Manager m;

  // Lebenspunkte
  ValueNotifier<int> lifePoints;

  bool _isActive;
  bool timeZero;

  // ==================================================


  SpotGame() {
    lifePoints = ValueNotifier(3);

    // Hauthintergund - 2 Bilder übereinander
    parallaxBackground = ParallaxComponent([
      ParallaxImage('background.png'),
      ParallaxImage('layer.png'),
    ],
        // Geschwindigkeit in x- und y-Richtung
        baseSpeed: Offset(130, 0)
    );

    add(parallaxBackground);

    score = 0;
    _scoreDisplay = TextComponent("Punkte: $score ", //+ score.toString()
        config: TextConfig(
          fontFamily: 'VT323',
          color: Colors.black,
          fontSize: 55.0,
        ));

    _timeDisplay = TextComponent("$time", //.toString()
        config: TextConfig(
          fontFamily: 'VT323',
          color: Colors.black,
          fontSize: 75.0,
        ));

    add(_timeDisplay);
    add(_scoreDisplay);

    // Header-Anzeige als WidgetOverlay
    addWidgetOverlay('headerDisplay', _buildHeader());

    startTimer(time);

    // ==================================================

    Manager _manager = Manager();
    add(_manager);

    _isActive = true;
    timeZero = false;

  }

  get https => null;

  @override
  void onTapDown(int pointerId, TapDownDetails details) {
    super.onTapDown(pointerId, details);

  }

  @override
  void resize(Size size) {
    super.resize(size);
    _timeDisplay.setByPosition(
        Position(((size.width / 2) - (_timeDisplay.width * 4)), 15));

    // NEU
    _scoreDisplay.setByPosition(Position(((size.width / 2)), 22));
  }

  // Aktualisierungen pro Frame
  @override
  void update(double t) {
    super.update(t);
    _timeDisplay.text = '$time';
    _scoreDisplay.text = "Punkte: $score";

    // Gameover bei Lebenspunkte = 0
    if (lifePoints.value == 0) {
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
        timeZero = true;
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
        this.pausing();
        break;
      case AppLifecycleState.paused:
        this.pausing();
        break;
      case AppLifecycleState.detached:
        this.pausing();
        break;
    }
  }

  // Header
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
                       //Aufruf Pause Bildschirm
                      if(_isActive == true){
                        pausing();
                      } else if(_isActive == false) {
                        null;
                      }
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
                    valueListenable: this.lifePoints, //ValueNotifier
                    // builder baut das Widget -> Liste von Herz-Icons
                    builder: (BuildContext context, value, Widget child) {
                      List<Widget> list = <Widget>[];
                      for (int i = 0; i < 3; ++i) {
                        list.add(
                          Icon(
                            (i < value) ? Icons.favorite : Icons.favorite_border,
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

  // Spiel pausieren
  void pausing() {
    pauseEngine();
    if (_timer.isActive) {
      _timer.cancel();
    }
    removeWidgetOverlay('fault2');
    addWidgetOverlay('PauseMenu', _pauseMenuBuilder());
  }

  // Pausenmenü Widget
  Widget _pauseMenuBuilder() {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Color(0xFF2D8064).withOpacity(0.8),
        //Color(0xFF2D8064).withOpacity(0.5),q
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
                      resuming();
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
                    onPressed: _launchURL,
                    iconSize: 50.0,
                    icon: Icon(
                      Icons.info_outline,
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

  void resuming() {
    removeWidgetOverlay('PauseMenu');
    resumeEngine();
    if (!_timer.isActive) {
      startTimer(time);

    }
  }

  // Aufruf Game Over Menü
 void gameOver() {
    pauseEngine();
    _isActive = false;
    _timer.cancel();
    addWidgetOverlay('GameoverMenu', GameOver(
        score: score,
        timeZero: timeZero)
    );

  }

  // Hyperlink zur Info-App
  void _launchURL() async {
    await canLaunch('https://lab.ise.uni-luebeck.de/tabiri/#/home')
        ? await launch('https://lab.ise.uni-luebeck.de/tabiri/#/home')
        : throw 'Could not launch $https://lab.ise.uni-luebeck.de/tabiri/#/home';
  }


  // Spieldaten zurücksetzen für direkten Neustart vom Game-Over-Menü aus
  // Wird in der aktutellen Version jedoch nicht gebraucht, da man immer wieder zum Hauptmenü
  // zurück navigiert und durch "Start" alle Spieldaten im Konstruktor der SpotGame-Klasse neu initialisiert werden
  // Evt. für Erweiterungen
  void resetGame() {
    this.score = 0;

    // Neustart Zeit-Timer
    _timer.cancel();
    this.time = 90;
    startTimer(time);

    this.lifePoints.value = 3;
    timeZero = false;

    // Restliche Flecken auf dem Bildschirm löschen
    components.whereType<Spot>().forEach((spot) {
      this.markToRemove(spot);
    });

    // Geschwindigkeit zurücksetzen
    parallaxBackground.baseSpeed = Offset(130, 0);

    // Overlays entfernen
    removeWidgetOverlay('fault2');
    removeWidgetOverlay('GameoverMenu');

    resumeEngine();
    _isActive = true;

  }
}
