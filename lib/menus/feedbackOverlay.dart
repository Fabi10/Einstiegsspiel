

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackOverlay extends StatelessWidget {

  final double x,y;

  const FeedbackOverlay({
    Key key,
    @required this.x,
    @required this.y,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Container(
        child:
        Positioned(
            top: y,
            left: x - 200,
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
            ))
    );

  }

}