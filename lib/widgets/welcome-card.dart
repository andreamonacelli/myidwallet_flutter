import 'package:flutter/material.dart';

///Definition of the UI section corresponding to the welcome card
class WelcomeCard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
            'Benvenuto nel tuo wallet!',
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