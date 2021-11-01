
import 'dart:ui';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/sprite.dart';
import 'package:flame/time.dart';
import 'package:tutorial_game/game/game.dart';
import 'package:tutorial_game/game/spots.dart';

class Manager extends Component with HasGameRef<SpotGame> {
  Sprite s;
  Timer _timer;
  SpotData data;

  Manager() : super() {
    // {this.sprite}
    _timer = Timer(1.0, repeat: true, callback: () {
      spawnRandomSpots();
    });
  }

  void spawnRandomSpots() {
    s = Spot.getSprite();
    data = Spot.spotData = Spot.spotDetails[s];
    Spot res = Spot(
      sprite: s, // sprite
      width: data.textureWidth / 3,
      height: data.textureHeight / 3,
      isNegative: Spot.isBad(s),
    );
    res.setInfo(Spot.isBad(s));
    gameRef.addLater(res);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void render(Canvas c) {}

  @override
  void update(double t) {
    _timer.update(t);


  }


}
