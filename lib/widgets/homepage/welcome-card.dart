import 'package:flutter/material.dart';

///Definition of the UI section corresponding to the welcome card
class WelcomeCard extends StatelessWidget{

  final String _welcomeString;

  WelcomeCard(this._welcomeString);

  ///Default constructor (named), if it will turn out to be useless then it will be removed
  WelcomeCard.standard():
      _welcomeString = 'Benvenuto nel tuo wallet!';

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
            _welcomeString,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
        ),
      ),
    );
  }

}