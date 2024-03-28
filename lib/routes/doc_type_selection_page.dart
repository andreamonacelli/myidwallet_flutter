import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/header_text_card.dart';

class DocTypeSelectionPage extends StatelessWidget{

  final String _headerString = "Seleziona il tipo di documento:";

  const DocTypeSelectionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderTextCard(_headerString),
        ],
      )
    );
  }

}