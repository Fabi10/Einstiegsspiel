
import 'dart:math';

import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/components/particle_component.dart';
import 'package:flame/particle.dart';
import 'package:flame/particles/accelerated_particle.dart';
import 'package:flame/particles/circle_particle.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tutorial_game/game/game.dart';
import 'package:tutorial_game/game/spot_manager.dart';

class SpotData {
  final double textureWidth;
  final double textureHeight;
  final int speed; // Jeder gegner andere Geschwindigkeit
  final bool isNegative;

  const SpotData({
    @required this.textureWidth,
    @required this.textureHeight,
    @required this.speed,
    @required this.isNegative,
  });
}

class Spot extends SpriteComponent with Tapable, HasGameRef<SpotGame>{
  static final Map<Sprite, SpotData> spotDetails = {
    Sprite('flecken_positive/g1.png'): SpotData(
      textureWidth: 327,
      textureHeight: 311,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g2.png'): SpotData(
      textureWidth: 221,
      textureHeight: 215,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g3.png'): SpotData(
      textureWidth: 276,
      textureHeight: 308,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_negative/f1.png'): SpotData(
      textureWidth: 311,
      textureHeight: 361,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f2.png'): SpotData(
      textureWidth: 276,
      textureHeight: 433,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f3.png'): SpotData(
      textureWidth: 414,
      textureHeight: 367,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f6.png'): SpotData(
      textureWidth: 366,
      textureHeight: 270,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f7.png'): SpotData(
      textureWidth: 307,
      textureHeight: 263,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f8.png'): SpotData(
      textureWidth: 385,
      textureHeight: 272,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_positive/g4.png'): SpotData(
      textureWidth: 201,
      textureHeight: 210,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g5.png'): SpotData(
      textureWidth: 275,
      textureHeight: 271,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g7.png'): SpotData(
      textureWidth: 112,
      textureHeight: 105,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g8.png'): SpotData(
      textureWidth: 311,
      textureHeight: 327,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g9.png'): SpotData(
      textureWidth: 193,
      textureHeight: 191,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g10.png'): SpotData(
      textureWidth: 231,
      textureHeight: 205,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g11.png'): SpotData(
      textureWidth: 228,
      textureHeight: 219,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g12.png'): SpotData(
      textureWidth: 169,
      textureHeight: 138,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g13.png'): SpotData(
      textureWidth: 199,
      textureHeight: 192,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g14.png'): SpotData(
      textureWidth: 201,
      textureHeight: 205,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g15.png'): SpotData(
      textureWidth: 139,
      textureHeight: 149,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g16.png'): SpotData(
      textureWidth: 222,
      textureHeight: 232,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g17.png'): SpotData(
      textureWidth: 242,
      textureHeight: 206,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g18.png'): SpotData(
      textureWidth: 223,
      textureHeight: 205,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g19.png'): SpotData(
      textureWidth: 156,
      textureHeight: 156,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g20.png'): SpotData(
      textureWidth: 213,
      textureHeight: 201,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g21.png'): SpotData(
      textureWidth: 219,
      textureHeight: 228,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g22.png'): SpotData(
      textureWidth: 276,
      textureHeight: 290,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g23.png'): SpotData(
      textureWidth: 201,
      textureHeight: 213,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g24.png'): SpotData(
      textureWidth: 228,
      textureHeight: 212,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g25.png'): SpotData(
      textureWidth: 237,
      textureHeight: 220,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g26.png'): SpotData(
      textureWidth: 235,
      textureHeight: 234,
      speed: 200,
      isNegative: false,
    ),
    // mehr gefährliche
    Sprite('flecken_negative/f16.png'): SpotData(
      textureWidth: 217,
      textureHeight: 251,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f17.png'): SpotData(
      textureWidth: 161,
      textureHeight: 139,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f14.png'): SpotData(
      textureWidth: 169,
      textureHeight: 138,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f11.png'): SpotData(
      textureWidth: 175,
      textureHeight: 163,
      speed: 200,
      isNegative: true,
    ),
  };

  // ATTRIBUTE
  static Random _random;
  static SpotData spotData;
  static int previous = 0;
  static int index = 0;

  Manager manager = Manager();
  bool info;
  Timer _timer;
  Timer _feedbackTimer;

  double posX, posY;
  Random random;
  // ==============================

  Spot({
    Sprite sprite,
    double width,
    double height,
    bool isNegative,
  }) : super.fromSprite(width, height, sprite) {
    isNegative = false;
    _timer = Timer(2, callback: () {
      gameRef.removeWidgetOverlay('fault2');
    });

    _feedbackTimer = Timer(2, callback: () {
      gameRef.removeWidgetOverlay('posFeedback');
    });

  }

  static Sprite getSprite() {
    _random = Random();
    int dice = _random.nextInt(100);
    Sprite sp;
    int index = _random.nextInt(spotDetails.length);

    if (index != previous) {
      sp = spotDetails.keys.elementAt(index);

      // Wahrscheinlichkeitsverteilung
      if (spotDetails[sp].isNegative && dice > 40) {
        return getSprite();
      } else {
        previous = index;
        return sp;
      }
    } else {
      return getSprite();
    }
  }


  void setInfo(bool data) {
    this.info = data;
  }

  bool getInfo() {
    return info;
  }

  static bool isBad(Sprite s) {
    spotData = spotDetails[s];
    return spotData.isNegative;
  }


  @override
  void update(double t) {
    super.update(t);
    this.x -= 130 * t;

    //Spiel wird ab Restzeit 40 Sekunden schneller
    if (gameRef.time <= 40) {
      this.x -= 160 * t;
      gameRef.parallaxComponent.baseSpeed = Offset(290, 0);
    }
    _timer.update(t);
    _feedbackTimer.update(t);

    if (this.x < 0 - this.width && this.info == true) {
      gameRef.markToRemove(this);
      gameRef.lifePoints.value -= 1;
      //gameRef.time -=10;
    }

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.x = size.width + _random.nextInt(300) + _random.nextInt(50);
    this.y = 100 + _random.nextInt(size.height.toInt() - 200).toDouble();

    // Verhinderung von Flecken-Überlappung
    gameRef.components.whereType<Spot>().forEach((spot) {
      if (spot.distance(spot) < this.width + 40) {
        this.x = size.width + _random.nextInt(300) + _random.nextInt(50);
        this.y = 100 + _random.nextInt(size.height.toInt() - 200).toDouble();
      }
    });
  }

  double getRandom() {
    return (_random.nextDouble() - _random.nextDouble());
  }

  // Tippen auf Flecken
  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    posX = details.globalPosition.dx;
    posY = details.globalPosition.dy;

    if (this.info == true) {

      gameRef.markToRemove(this);
      gameRef.score += 1;

      final particleComponent = ParticleComponent(
          particle: Particle.generate(
              count: 20,
              lifespan: 0.14,
              generator: (i) => AcceleratedParticle(
                  acceleration: Offset(getRandom(), getRandom()) * 550,
                  speed: Offset(getRandom(), getRandom()) * 500,
                  position: Offset(posX, posY),
                  child: CircleParticle(
                    radius: 1.6,
                    paint: Paint()..color = Color(0XFF5b3a29),
                  ))));

      gameRef.add(particleComponent);

    } else if (this.info == false) {
      _timer.start();
      gameRef.addWidgetOverlay('fault2', _fault()); //_fault()
    }
  }

  Widget _fault() {
    return Positioned(
        top: posY,
        left: posX - 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.black.withOpacity(0.5),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Text(
              'Dieser Fleck ist harmlos!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
              ),
            ),
          ),
        ));
  }


  Widget _posFeedback() {
    return Positioned(
        top: posY,
        left: posX - 200,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          color: Colors.black.withOpacity(0.5),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Text(
              'Super! Damit haben Sie das\nHautkrebs-Risiko verringert',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
              ),
            ),
          ),
        ));
  }

}

