import 'package:flutter/material.dart';

///Definition of the UI section corresponding to the welcome card
class HeaderTextCard extends StatelessWidget{

  final String _headerString;

  HeaderTextCard(this._headerString);

  ///Default constructor (named), if it will turn out to be useless then it will be removed
  HeaderTextCard.standard():
      _headerString = 'Benvenuto nel tuo wallet!';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 13,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      decoration: ShapeDecoration(
        color: Colors.cyan,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Text(
          _headerString,
          style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
      ),
    );
  }

}