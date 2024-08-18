import 'package:myidwallet_flutter/models/entities/document_type.dart';

class Passport implements DocumentType{
  @override
  Future<Map<String, String>> recognizeTextFromImage(String imagePath, String nation) async {
    // TODO: implement fillDataFromImage
    throw UnimplementedError();
  }
}