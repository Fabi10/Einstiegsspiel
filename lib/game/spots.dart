import 'dart:html';
import 'dart:math';

import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/components/mixins/tapable.dart';
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
  final bool isBad;

  const SpotData({
    @required this.textureWidth,
    @required this.textureHeight,
    @required this.speed,
    @required this.isBad,
  });

}


class Spot extends SpriteComponent with Tapable, HasGameRef<Game> {



  static final Map<Sprite, SpotData> spotDetails = {
    Sprite('flecken_gut/g1.png'): SpotData(
      textureWidth: 327,
      textureHeight: 311,
      speed: 200,
      isBad: false,

    ),
    Sprite('flecken_gut/g2.png'): SpotData(
      textureWidth: 221,
      textureHeight: 215,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g3.png'): SpotData(
      textureWidth: 276,
      textureHeight: 308,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_böse/f1.png'): SpotData(
      textureWidth: 311,
      textureHeight: 361,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_böse/f2.png'): SpotData(
      textureWidth: 276,
      textureHeight: 433,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_böse/f3.png'): SpotData(
      textureWidth: 414,
      textureHeight: 367,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_böse/f6.png'): SpotData(
      textureWidth: 366,
      textureHeight: 270,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_böse/f7.png'): SpotData(
      textureWidth: 307,
      textureHeight: 263,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_böse/f8.png'): SpotData(
      textureWidth: 385,
      textureHeight: 272,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_gut/g4.png'): SpotData(
      textureWidth: 201,
      textureHeight: 210,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g5.png'): SpotData(
      textureWidth: 275,
      textureHeight: 271,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g7.png'): SpotData(
      textureWidth: 112,
      textureHeight: 105,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g8.png'): SpotData(
      textureWidth: 311,
      textureHeight: 327,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g9.png'): SpotData(
      textureWidth: 193,
      textureHeight: 191,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g10.png'): SpotData(
      textureWidth: 231,
      textureHeight: 205,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g11.png'): SpotData(
      textureWidth: 228,
      textureHeight: 219,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g12.png'): SpotData(
      textureWidth: 169,
      textureHeight: 138,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g13.png'): SpotData(
      textureWidth: 199,
      textureHeight: 192,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g14.png'): SpotData(
      textureWidth: 201,
      textureHeight: 205,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g15.png'): SpotData(
      textureWidth: 139,
      textureHeight: 149,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g16.png'): SpotData(
      textureWidth: 222,
      textureHeight: 232,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g17.png'): SpotData(
      textureWidth: 242,
      textureHeight: 206,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g18.png'): SpotData(
      textureWidth: 223,
      textureHeight: 205,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g19.png'): SpotData(
      textureWidth: 156,
      textureHeight: 156,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g20.png'): SpotData(
      textureWidth: 213,
      textureHeight: 201,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g21.png'): SpotData(
      textureWidth: 219,
      textureHeight: 228,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g22.png'): SpotData(
      textureWidth: 276,
      textureHeight: 290,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g23.png'): SpotData(
      textureWidth: 201,
      textureHeight: 213,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g24.png'): SpotData(
      textureWidth: 228,
      textureHeight: 212,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g25.png'): SpotData(
      textureWidth: 237,
      textureHeight: 220,
      speed: 200,
      isBad: false,
    ),
    Sprite('flecken_gut/g26.png'): SpotData(
      textureWidth: 235,
      textureHeight: 234,
      speed: 200,
      isBad: false,
    ),
    // mehr gefährliche
    Sprite('flecken_böse/f16.png'): SpotData(
      textureWidth: 217,
      textureHeight: 251,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_böse/f17.png'): SpotData(
      textureWidth: 161,
      textureHeight: 139,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_böse/f14.png'): SpotData(
      textureWidth: 169,
      textureHeight: 138,
      speed: 200,
      isBad: true,
    ),
    Sprite('flecken_böse/f11.png'): SpotData(
      textureWidth: 175,
      textureHeight: 163,
      speed: 200,
      isBad: true,
    ),

  };

  // ATTRIBUTE
  static Random _random;
  static SpotData spotData;
  Manager manager = Manager();
  bool info;
  Timer _timer;

  double posX, posY;

  // ==============================

  Spot({
    Sprite sprite,
    double width,
    double height,
    bool isBad,
    }) : super.fromSprite(width, height, sprite) {

    isBad = false;
    _timer = Timer(1, callback: () {
      gameRef.removeWidgetOverlay('fault2');
    });
  }


  static Sprite getSprite(){
    _random = Random();
    int dice = _random.nextInt(100);
    Sprite sp;
    sp = spotDetails.keys.elementAt(_random.nextInt(spotDetails.length));
    // Wahrscheinlichkeitsverteilung
    if(spotDetails[sp].isBad && dice > 40){
      return getSprite();
    } else {
      return sp;
    }
}

  static Sprite getSp(){
    Sprite s;
    for(int i = 0; i < spotDetails.length; i++){
      s = spotDetails.keys.elementAt(i);
      return s;
    }
    return s;
  }

void setInfo(bool data){
    this.info = data;
}

bool getInfo(){
    return info;
}

void setSprite(Sprite s){
    //previous = s;
}


static bool isBad(Sprite s){
    spotData = spotDetails[s];
  return spotData.isBad;

}


  @override
  void update(double t) {
    super.update(t);
    this.x -= 130 * t;


    // Spiel wird ab 40 Sekunden schneller
    //if(gameRef.time < 40){
    //  this.x -= 160 * t;
    //}
    _timer.update(t);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.x = size.width + _random.nextInt(300) + 50;
    this.y = 100 + _random.nextInt(size.height.toInt()-200).toDouble();


  }

  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);
    posX = details.globalPosition.dx;
    posY = details.globalPosition.dy;

    if(this.info == true){
      print(this.info);
      gameRef.markToRemove(this);
      gameRef.score += 1;
    } else if(this.info == false){
      //gameRef.addWidgetOverlay('fault', _buildWarning());
      _timer.start();
      gameRef.addWidgetOverlay('fault2',
      Positioned(
          top: posY,
          left: posX -200,
          child: Card(
            color: Colors.black.withOpacity(0.5),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
              ),
                child: Text('Dieser Fleck ist harmlos!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),),
          ),
      ))
      );

    }

  }



}

Widget _buildWarning() {
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
              'Dieser Fleck ist harmlos!',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );

}



