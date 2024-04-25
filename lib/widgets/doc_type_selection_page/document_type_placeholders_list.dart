import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/doc_type_selection_page/document_type_placeholder.dart';

class DocumentPlaceholdersList extends StatelessWidget{

  /* final String _resourceFilePath = "assets/data/available_documents.json";
  final String _availableTypesEncoding = "document_nation"; */
  static final List<List<String>> availableTypesAndNations = [
    ["healthcare_it", "Tessera Sanitaria", "Italia", "healthcare"]
    /*,["personalid_it", "Carta d'Identità", "Italia", "personalid"]*/
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            physics: ScrollPhysics(),
            padding: EdgeInsets.all(5),
            shrinkWrap: true,
            itemCount: availableTypesAndNations.length,
            itemBuilder: (BuildContext context, int index) {
              //Future.sync(() => _fetchAvailableTypes());
              return DocumentTypePlaceholder(availableTypesAndNations[index]);
            }
        )
    );
  }

  /* Future<void> _fetchAvailableTypes() async {
    final String response = await rootBundle.loadString(_resourceFilePath);
    final data = await json.decode(response);
    _availableTypesAndNations = data[_availableTypesEncoding];
  } */

}