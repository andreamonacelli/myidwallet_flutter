import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/doc_type_selection_page/document_type_placeholders_list.dart';
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
          DocumentPlaceholdersList(),
        ],
      )
    );
  }

}