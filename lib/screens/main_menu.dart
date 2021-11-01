import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:tutorial_game/screens/game_play.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenu extends StatelessWidget {
  get https => null;

  @override
  Widget build(BuildContext context) {
    String explain = 'Entdecke in diesem Spiel so viele\nverdächtige '
        'Hautflecken wie möglich\nund entferne sie durch Antippen!\n'
        'Du hast dabei 90 Sekunden Zeit.';

    TextStyle ts = TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.black);

    TextStyle tsButton = TextStyle(
      fontFamily: 'OpenSans',
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      color: Colors.white,
      //shadows: <Shadow>[
      //  Shadow(
      //    blurRadius: 3.0,
      //    color: Colors.black,
      //  ),
      //],
    );

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/startpic.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 100,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.black
                  .withOpacity(0.4), //Color(0xFF2D8064).withOpacity(0.8),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Herzlich willkommen bei ',
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: Colors.white,
                          ),
                        ),
                        Image(
                          image: AssetImage('assets/images/logo_cc.png'),
                          width: 1082 / 5.5,
                          height: 287 / 5.5,
                        ),
                      ],
                    ),
                    Divider(
                      height: 15,
                      color: Color(0xFF83AA74),
                      thickness: 7,
                    ),
                    Text(''),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 2,
                              //width: 350,
                              //height: 340,
                              decoration: BoxDecoration(
                                border: new Border.all(color: Colors.black),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5, // soften the shadow
                                    spreadRadius: 0, //extend the shadow
                                  ),
                                ],
                              ),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    explain,
                                    style: ts,
                                  ),
                                  Text(''),
                                  Text(
                                    'Bist du bereit?',
                                    textAlign: TextAlign.center,
                                    style: ts,
                                  ),
                                  Text(''),
                                  Image(
                                    image: AssetImage('assets/images/demo.gif'),
                                    fit: BoxFit.cover,
                                    width: 600 / 2,
                                    height: 300 / 2,
                                  ),
                                  Text(''),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => GamePlay()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF6A895F),
                                onPrimary: Colors.black,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width / 3, 50),
                                //shape: RoundedRectangleBorder(
                                //  borderRadius: BorderRadius.circular(25.0),
                                //),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  'Starte die Entdeckungstour',
                                  style: tsButton,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        // Container 2
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 2,
                              //width: 350,
                              //height: 340,
                              decoration: BoxDecoration(
                                border: new Border.all(color: Colors.black),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5, // soften the shadow
                                    spreadRadius: 0, //extend the shadow
                                  ),
                                ],
                              ),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Oder besuche direkt die Info-App: \n'
                                    '✔ Wissenswertes über Hautkrebs \n'
                                    '✔ Persönlicher Risikotest \n'
                                    '✔ Präventionsmaßnahmen',
                                    style: ts,
                                  ),
                                  Text(''),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //Image(
                                      //  image: AssetImage('assets/images/logo.png'),
                                      //  width: 1082/10 ,
                                      //  height: 287/10,
                                      //),
                                    ],
                                  ),
                                  Image(
                                    image:
                                        AssetImage('assets/images/app_2.png'),
                                    fit: BoxFit.cover,
                                    width: 1216 / 4,
                                    height: 712 / 4,
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _launchURL,
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF6A895F), //Color(0xFF779A6A), //Color(0xFF83AA74),
                                onPrimary: Colors.black,
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width / 3, 50),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  'Direkt zur Hautkrebsinfo',
                                  style: tsButton,
                                ),
                              ),
                            ),
                          ],
                        )
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

  void _launchURL() async {
    await canLaunch('https://lab.ise.uni-luebeck.de/tabiri/#/home')
        ? await launch('https://lab.ise.uni-luebeck.de/tabiri/#/home')
        : throw 'Could not launch $https://lab.ise.uni-luebeck.de/tabiri/#/home';
  }
}
