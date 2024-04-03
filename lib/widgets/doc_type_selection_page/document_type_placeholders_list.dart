import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myidwallet_flutter/widgets/doc_type_selection_page/document_type_placeholder.dart';

class DocumentPlaceholdersList extends StatelessWidget{

  final String _resourceFilePath = "assets/data/available_documents.json";
  final String _availableTypesEncoding = "document_nation";
  final List<String> _availableTypesAndNations = [
    "healthcare_it"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemCount: _availableTypesAndNations.length,
        itemBuilder: (BuildContext context, int index) {
          //Future.sync(() => _fetchAvailableTypes());
          return DocumentTypePlaceholder(_availableTypesAndNations[index]);
        }
    );
  }

  /* Future<void> _fetchAvailableTypes() async {
    final String response = await rootBundle.loadString(_resourceFilePath);
    final data = await json.decode(response);
    _availableTypesAndNations = data[_availableTypesEncoding];
  } */

}