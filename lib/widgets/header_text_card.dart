import 'package:flutter/material.dart';

///Definition of the UI section corresponding to the welcome card
class HeaderTextCard extends StatelessWidget{

  final String _headerString;
  final Color _backgroundColor;
  final Color _textColor;

  HeaderTextCard(this._headerString, this._backgroundColor, this._textColor);

  ///Default constructor (named), if it will turn out to be useless then it will be removed
  HeaderTextCard.standard():
      _headerString = 'Benvenuto nel tuo wallet!',
      _backgroundColor = Colors.cyan,
      _textColor = Colors.white70;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 13,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 2),
      decoration: ShapeDecoration(
        color: _backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
          _headerString,
          style: TextStyle(
            fontFamily: 'Baloo2',
            color: _textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
      ),
    );
  }

}