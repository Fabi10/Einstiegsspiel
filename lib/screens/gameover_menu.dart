
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/game/game.dart';

import 'main_menu.dart';

class GameOver extends StatelessWidget {

  final int score;
  final Function onRestartPressed;

  const GameOver({
   Key key,
   @required this.score,
   @required this.onRestartPressed,
}) : assert(onRestartPressed != null), super (key: key);


  @override
  Widget build(BuildContext context) {


    //Dynamischer Ergebnistext je nach Anzahl erreichter Punkte

    String resultText = " ";
    if(score == 0){
      resultText = 'Oh, du hast keine auffälligen Hautflecken erkannt. Hattest du Schwierigkeiten dabei? '
          'Schaue dir jetzt alles etwas genauer in der Hautkrebs-Info-App an, oder starte das Spiel erneut! ';
    } else if(score == 1){
      resultText = 'Oh, du hast nur eine verdächtige Hautveränderung entdeckt! Da wurden aber einige übersehen.'
          ' Schaue dir jetzt alles etwas genauer in der Hautkrebs-Info-App an, oder starte das Spiel erneut! ';
    } else if(score >=5 && score <= 6) {
      resultText = 'Gar nicht so schlecht! Du hast $score verdächtige Hautflecken entdeckt.'
          ' Schaue dir jetzt die Info-App rund um das Thema Hautkrebs an';
    } else if(score > 6 && score <=11) {
      resultText = 'Sehr gut! Du hast  $score verdächtige Hautflecken entdeckt.'
          ' Schaue dir jetzt die Info-App rund um das Thema Hautkrebs an. ';
    }


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
                  'Game Over',
                  style: TextStyle(fontSize: 70.0, color: Colors.white),
                ),
                Text("   ",
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                Text(
                  resultText,
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                Text("   ",
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Neustart
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Neustart',
                                style: TextStyle(fontSize: 30.0, color: Colors.black),
                              ),
                              IconButton(
                                  onPressed: () { //onRestartPressed.call();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => MainMenu()
                                      ),
                                    );
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
                    // Info-App
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
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


}