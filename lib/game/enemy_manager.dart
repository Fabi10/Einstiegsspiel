import 'dart:math';
import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorial_game/game/enemy.dart';
import 'package:tutorial_game/game/game.dart';

class EnemyManager extends Component with HasGameRef<Game> {
  Random _random;
  Timer _timer;
  int _spawnLevel;

  EnemyManager(){
    _random = Random();
    _spawnLevel = 0;
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });
  }

  // Zufälligen Gegner erscheinen lassen - aus der Enum Liste
  void spawnRandomEnemy(){

  final randomNumber = _random.nextInt(EnemyType.values.length);
  final randomEnemyType = EnemyType.values.elementAt(randomNumber);
  final newEnemy = Enemy(randomEnemyType);
  // Gegner erscheinen auf Bildschirm
  //gameRef.addLater(newEnemy);
  }

  // Timer wird erst gestartet, wenn EnemyManager zur Komponentenliste des Spiels hinzugefügt wird
  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }


  @override
  void render(Canvas c) {
  }

  @override
  void update(double t) {
    _timer.update(t);

    // Neues Spawnlevel berechnen, anhand der Punkte des Spielers: Je mehr Punkte, desto schneller erscheinen Enemies
    var newSpawnLevel = (gameRef.score ~/ 500); //Level wird erhöht alle 500 Punkte. ~ = toInt()
    if(_spawnLevel < newSpawnLevel){
      _spawnLevel = newSpawnLevel;

      // Formel, damit mit fortschreitender Zeit, immer mehr Gegner kommen
      var newWaitTime = (4 / (1 + (0.1 * _spawnLevel)));
      //debugPrint(newWaitTime.toString());

      _timer.stop();
      _timer = Timer(newWaitTime, repeat: true, callback: () {
        spawnRandomEnemy();
      });
      _timer.start();
   }

  }

  void reset() {
    _spawnLevel = 0;
    spawnRandomEnemy();
    _timer = Timer(4, repeat: true, callback: () {
      spawnRandomEnemy();
    });

  }

}