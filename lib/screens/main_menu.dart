

import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_game/screens/game_play.dart';

class MainMenu extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    String explain = 'Entdecke so viele verdächtige Hautflecken wie möglich \n und entferne sie durch Antippen! ';

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/startpic.png'),
              fit: BoxFit.cover
          ),
        ),
        child:
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 100,
            child:
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Color(0xFF2D8064).withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Herzlich Willkommen',
                      style: TextStyle(
                        fontSize: 60.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(''),
                    Text(explain,
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(''),
                    Text(''),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          width: 350,
                          height: 360,
                          decoration: BoxDecoration(
                            border: new Border.all(color: Colors.black),
                          ),
                          color: Colors.white,
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Oder besuche direkt die Info-App \n'
                                '✔ Wissenswertes über Hautkrebs \n'
                                '✔ Persönlicher Risikotest \n'
                                '✔ Präventionsmaßnahmen',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(''),
                              Image(
                                image: AssetImage('assets/images/app.png'),
                                fit: BoxFit.cover,
                                width: 1205 / 4,
                                height: 908/4,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          width: 350,
                          height: 360,
                          decoration: BoxDecoration(
                            border: new Border.all(color: Colors.black),
                          ), color: Colors.white,
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Darauf solltest du achten: \n'
                                  '- Asymmetrie \n'
                                  '- Sehr unregelmäßige Begrenzung \n'
                                  '- Farbveränderungen \n',
                                style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.black,
                                ),
                              ),
                              Text(''),
                              Image(
                                image: AssetImage('assets/images/demo.gif'),
                                fit: BoxFit.cover,
                                width: 600 /2,
                                height: 300/2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(''),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  // Zur App
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                ),
                                child: Text('Direkt zur Hautkrebsinfo',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                  ),)
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => GamePlay()
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.black,
                                ),
                                child: Text('Starte die Entdeckungstour!',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.black,
                                  ),)
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),

            ),
          ),
        ),
      ),

    );

  }

}