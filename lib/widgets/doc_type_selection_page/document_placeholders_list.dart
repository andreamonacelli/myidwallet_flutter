import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myidwallet_flutter/widgets/doc_type_selection_page/document_placeholder.dart';

class DocumentPlaceholdersList extends StatelessWidget{

  final String _resourceFilePath = "assets/data/available_documents.json";
  final String _availableTypesEncoding = "document_nation";
  late final List<String> _availableTypesAndNations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(5),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Future.sync(() => _fetchAvailableTypes());
          return DocumentPlaceholder(_availableTypesAndNations[index]);
        }
    );
  }

  Future<void> _fetchAvailableTypes() async {
    final String response = await rootBundle.loadString(_resourceFilePath);
    final data = await json.decode(response);
    _availableTypesAndNations = data[_availableTypesEncoding];
  }

}