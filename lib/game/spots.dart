
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
import 'package:tutorial_game/menus/feedbackOverlay.dart';

// Klasse zur Speicherung von Detail-Informationen der Hautflecke
class SpotData {
  final double customWidth;
  final double customHeight;
  final int speed; //
  final bool isNegative;

  const SpotData({
    @required this.customWidth,
    @required this.customHeight,
    @required this.speed,
    @required this.isNegative,
  });
}

class Spot extends SpriteComponent with Tapable, HasGameRef<SpotGame> {
  // Map zur Speicherung der Sprites und zugehörigen Details
  static final Map<Sprite, SpotData> spotDetails = {
    Sprite('flecken_positive/g1.png'): SpotData(
      customWidth: 327,
      customHeight: 311,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g2.png'): SpotData(
      customWidth: 221,
      customHeight: 215,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g3.png'): SpotData(
      customWidth: 276,
      customHeight: 308,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_negative/f1.png'): SpotData(
      customWidth: 311,
      customHeight: 361,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f2.png'): SpotData(
      customWidth: 276,
      customHeight: 433,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f3.png'): SpotData(
      customWidth: 414,
      customHeight: 367,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f6.png'): SpotData(
      customWidth: 366,
      customHeight: 270,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f7.png'): SpotData(
      customWidth: 307,
      customHeight: 263,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f8.png'): SpotData(
      customWidth: 385,
      customHeight: 272,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_positive/g4.png'): SpotData(
      customWidth: 201,
      customHeight: 210,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g5.png'): SpotData(
      customWidth: 275,
      customHeight: 271,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g7.png'): SpotData(
      customWidth: 112,
      customHeight: 105,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g8.png'): SpotData(
      customWidth: 311,
      customHeight: 327,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g9.png'): SpotData(
      customWidth: 193,
      customHeight: 191,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g10.png'): SpotData(
      customWidth: 231,
      customHeight: 205,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g11.png'): SpotData(
      customWidth: 228,
      customHeight: 219,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g12.png'): SpotData(
      customWidth: 169,
      customHeight: 138,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g13.png'): SpotData(
      customWidth: 199,
      customHeight: 192,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g14.png'): SpotData(
      customWidth: 201,
      customHeight: 205,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g15.png'): SpotData(
      customWidth: 139,
      customHeight: 149,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g16.png'): SpotData(
      customWidth: 222,
      customHeight: 232,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g17.png'): SpotData(
      customWidth: 242,
      customHeight: 206,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g18.png'): SpotData(
      customWidth: 223,
      customHeight: 205,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g19.png'): SpotData(
      customWidth: 156,
      customHeight: 156,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g20.png'): SpotData(
      customWidth: 213,
      customHeight: 201,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g21.png'): SpotData(
      customWidth: 219,
      customHeight: 228,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g22.png'): SpotData(
      customWidth: 276,
      customHeight: 290,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g23.png'): SpotData(
      customWidth: 201,
      customHeight: 213,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g24.png'): SpotData(
      customWidth: 228,
      customHeight: 212,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g25.png'): SpotData(
      customWidth: 237,
      customHeight: 220,
      speed: 200,
      isNegative: false,
    ),
    Sprite('flecken_positive/g26.png'): SpotData(
      customWidth: 235,
      customHeight: 234,
      speed: 200,
      isNegative: false,
    ),
    // mehr gefährliche
    Sprite('flecken_negative/f16.png'): SpotData(
      customWidth: 217,
      customHeight: 251,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f17.png'): SpotData(
      customWidth: 161,
      customHeight: 139,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f14.png'): SpotData(
      customWidth: 169,
      customHeight: 138,
      speed: 200,
      isNegative: true,
    ),
    Sprite('flecken_negative/f11.png'): SpotData(
      customWidth: 175,
      customHeight: 163,
      speed: 200,
      isNegative: true,
    ),
  };

  // ATTRIBUTE
  static Random _random;
  static SpotData spotData;
  static int previous = 0;
  static int index = 0;

  bool info;
  Timer _timer;

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
    //Flame Timer für Feedback-Overlay bei unauffälligen flecken
    _timer = Timer(2, callback: () {
      gameRef.removeWidgetOverlay('feedback');
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

  // Setter zum Speichern der Info, ob Fleck pos./neg.
  void setInfo(bool data) {
    this.info = data;
  }

  // Getter der Info
  static bool isBad(Sprite s) {
    spotData = spotDetails[s];
    return spotData.isNegative;
  }

  // Aktualisierungen pro Frame
  @override
  void update(double t) {
    super.update(t);
    this.x -= 130 * t;

    //Spiel wird ab Restzeit 40 Sekunden schneller
    if (gameRef.time <= 40) {
      this.x -= 160 * t;
      gameRef.parallaxBackground.baseSpeed = Offset(290, 0);
    }
    _timer.update(t);

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
    this.x = size.width + _random.nextInt(250) + _random.nextInt(50) + _random.nextInt(50);
    this.y = 100 + _random.nextInt(size.height.toInt() - 200).toDouble();

    // Verhinderung von Flecken-Überlappung
    gameRef.components.whereType<Spot>().forEach((spot) {
      if (spot.distance(spot) < this.width + 40) {
        this.x = size.width + _random.nextInt(300) + _random.nextInt(50);
        this.y = 100 + _random.nextInt(size.height.toInt() - 200).toDouble();
      }
    });
  }

  // Random-Werte für den Particle Effekt
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
      gameRef.addWidgetOverlay('feedback', FeedbackOverlay(
          x: posX,
          y: posY)
      );
    }
  }

}

