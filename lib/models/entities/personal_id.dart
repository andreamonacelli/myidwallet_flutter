import 'package:myidwallet_flutter/models/entities/document_type.dart';

class PersonalID implements DocumentType{
  @override
  Future<Map<String, String>> recognizeTextFromImage(String imagePath, String nation) async {
    // TODO: implement fillDataFromImage
    throw UnimplementedError();
  }
}