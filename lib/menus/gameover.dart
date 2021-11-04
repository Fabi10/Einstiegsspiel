
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main_menu.dart';

class GameOver extends StatelessWidget {
  // Da hier keine Referenz zur Spieloberfläche möglich ist, müssen diese beiden
  // Daten beim Aufruf des Menüs übergeben werden
  final int score;
  final bool timeZero;

  const GameOver({
    Key key,
    @required this.score,
    @required this.timeZero,
  })  : super(key: key);

  get https => null;

  @override
  Widget build(BuildContext context) {
    //Dynamische Ergebnistexte je nach Anzahl erreichter Punkte

    String resultText = '';
    String header = '';
    String res2 = 'da zu viele auffällige Hautflecke übersehen wurden. ';


    // Individuelle Feedback-Texte
    if (score == 0) {
      resultText =
          'Sie haben außerdem keine verdächtigen Hautflecke erkannt. Hatten Sie Schwierigkeiten dabei? '
          'Schauen Sie sich jetzt alles etwas genauer in der Info-App an, oder starten Sie das Spiel erneut! ';
    } else if (score == 1) {
      resultText =
          'Sie haben außerdem nur eine verdächtige Hautveränderung entdeckt! Hatten Sie Schwierigkeiten dabei?'
          ' Schauen Sie sich jetzt alles etwas genauer in der Info-App an, oder starten Sie das Spiel erneut!  ';
    } else if (score > 1 && score < 5) {
      resultText =
          'Sie haben insgesamt $score verdächtige Hautflecke entdeckt. Gar nicht so schlecht! '
          ' Schauen Sie sich jetzt gerne die Info-App rund um das Thema Hautkrebs an. ';
    } else if (score >= 5) {
      resultText = 'Sie haben insgesamt $score verdächtige Hautflecke entdeckt. Das war sehr gut!'
          ' Schauen Sie sich jetzt gerne die Info-App rund um das Thema Hautkrebs an. ';
    }

    // Unterscheidung, ob Spiel bis zum Ende des Timers geschafft, oder ob vorzeitigt beendet wurde.
    if(timeZero == true){
      header = 'Herzlichen Glückwunsch!';
      resultText = 'Sie haben es geschafft und $score verdächtige Hautflecke entdeckt. Das war sehr gut!'
    ' Schauen Sie sich jetzt gerne die Info-App rund um das Thema Hautkrebs an. ';
    } else if(timeZero == true && score == 0 ){
      header = 'Spiel vorbei'; // Spiel vorbei
    } else if(timeZero == false && score >= 5) {
      header = 'Spiel vorbei...';
      resultText = res2 + 'Du konntest dennoch $score verdächtige Hautveränderungen entdecken. Das war sehr gut!'
          ' Schauen Sie sich jetzt gerne die Info-App rund um das Thema Hautkrebs an.';
    } else if(timeZero == false && score < 5){
      header = 'Spiel vorbei...';
      resultText = res2 + resultText;
    }

    // TextStyles für Buttons und Fließtext
    TextStyle ts = TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22.0,
            color: Colors.white);

    TextStyle tsButton = TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
        color: Colors.white);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/startpic.png'), fit: BoxFit.cover),
      ),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 100,
          height: MediaQuery.of(context).size.height - 100,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.black.withOpacity(
                  0.3), //Color(0xFF2D8064), //.withOpacity(0.8),//Color(0xFF83AA74),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 30.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      header,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                          color: Colors.white),
                    ),
                    Divider(
                      height: 15,
                      color: Color(0xFF83AA74),
                      thickness: 7,
                    ),
                    Text(
                      resultText,
                      //textAlign: TextAlign.center,
                      style: ts,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      height: MediaQuery.of(context).size.height / 3.8,
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.white.withOpacity(0.3),
                        child: Column(
                          children: [
                            Text(
                              'Verdächtige Muttermale, die Sie übersehen haben könnten:',
                              textAlign: TextAlign.center,
                              style: ts,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                  image: AssetImage(
                                    'assets/images/flecken_negative/f1.png',
                                  ),
                                  width: MediaQuery.of(context).size.width/ 8,
                                  height: MediaQuery.of(context).size.height /6,
                                ),
                                Image(
                                  image: AssetImage(
                                      'assets/images/flecken_negative/f3.png'),
                                  width: MediaQuery.of(context).size.width/ 8,
                                  height: MediaQuery.of(context).size.height /6,
                                ),
                                Image(
                                  image: AssetImage(
                                      'assets/images/flecken_negative/f7.png'),
                                  width: MediaQuery.of(context).size.width/ 9,
                                  height: MediaQuery.of(context).size.height /7,
                                ),
                                Image(
                                  image: AssetImage(
                                      'assets/images/flecken_negative/f16.png'),
                                  width: MediaQuery.of(context).size.width/ 8,
                                  height: MediaQuery.of(context).size.height /6,
                                ),
                                Image(
                                  image: AssetImage(
                                      'assets/images/flecken_negative/f14.png'),
                                  width: MediaQuery.of(context).size.width/ 9,
                                  height: MediaQuery.of(context).size.height /7,
                                ),
                                Image(
                                  image: AssetImage(
                                      'assets/images/flecken_negative/f11.png'),
                                  width: MediaQuery.of(context).size.width/ 8,
                                  height: MediaQuery.of(context).size.height /6,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Neustart
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 6,
                          //width: 260,
                          //height: 130,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color(
                                0xFF6A895F), //Colors.white.withOpacity(0.8),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Neustart',
                                    style:
                                        tsButton, //TextStyle(fontSize: 30.0, color: Colors.black),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        //onRestartPressed.call();
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => MainMenu()),
                                        );
                                      },
                                      iconSize: 40,
                                      icon: Icon(
                                        Icons.replay,
                                        color: Colors.white,
                                        size: 40.0,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Info-App
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 6,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            color: Color(
                                0xFF6A895F), //Colors.white.withOpacity(0.8),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Zur Hautkrebsinfo',
                                    style: tsButton,
                                  ),
                                  IconButton(
                                      onPressed: _launchURL,
                                      iconSize: 40,
                                      icon: Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                        size: 40.0,
                                      )),
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
