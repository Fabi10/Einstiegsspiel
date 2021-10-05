import 'dart:ui';
import 'package:flame/anchor.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/components/component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';
import 'constants.dart';

import 'package:flutter/foundation.dart';



class Dino extends AnimationComponent {

  Animation _runAnimation;
  Animation _hitAnimation;
  Timer _timer;
  bool _isHit;


  // Vertikaler Speed = 0 vor dem Sprung = Dino am Boden
  double speedY = 0.0;
  // Bildschirmhöhe - Bodenhöhe
  double yMax = 0.0;

  ValueNotifier<int> life;

  Dino() : super.empty() {

    // 0-3 = idle
    // 4-10 = run
    // 11-13 = kick
    // 14-16 = hit
    // 17-23 = Sprint




    final spriteSheet = SpriteSheet(
        imageName: 'DinoSprites - tard.png',
        textureWidth: 24,
        textureHeight: 24,
        columns: 24,
        rows: 1
    );

    _runAnimation = spriteSheet.createAnimation(0, from: 4, to: 10, stepTime: 0.1);
    _hitAnimation = spriteSheet.createAnimation(0, from: 14, to: 16, stepTime: 0.1);

    this.animation = _runAnimation;


    _timer = Timer(1, callback: () {
      run();
    });

    _isHit = false;

    this.anchor = Anchor.center;

    // Lebenspunkte Notifier - Start mit 5
    life = ValueNotifier(5);
  }

  @override
  void resize(Size size) {
    super.resize(size);
    this.height = this.width = size.width / numberOfTilesAlongWidth;

    // x und y Position vom Dino

    this.x = 0;
    //this.x = this.width * 2;
    this.y = size.height - groundHeight - (this.height / 2) + dinoTopBottomSpacing;

    // dieselbe Position wie Dino
    this.yMax = this.y;
  }

  // Aufruf für jeden Frame des Game Loops
  @override
  void update(double t) { // t = Zeit, seit dem letzten Update-Zyklus
    super.update(t);
    // final speed = initial speed + gravity * time
    this.speedY += GRAVITY * t;

    // distance = speed * time
    this.y += this.speedY * t;

    if(isOnGround()){
      this.y = this.yMax;
      this.speedY = 0.0;
    }

    _timer.update(t);
  }


  // True, wenn Dino den Boden wieder berührt oder durchfällt
  bool isOnGround(){
    return (this.y >= this.yMax);
  }

  void run(){
    _isHit = false;
    this.animation = _runAnimation;
  }

  void hit(){
    if(!_isHit){
      _isHit = true;
      this.animation = _hitAnimation;
      life.value -= 1;

      // Timer wird gestartet - Nach 1 Sekunde zurück in Run Modus
      _timer.start();

    }
  }

  void jump() {
    if(isOnGround()){
      this.speedY = -500;
    }




  }

}