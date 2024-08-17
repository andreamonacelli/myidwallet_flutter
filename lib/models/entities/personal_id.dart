import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:myidwallet_flutter/models/entities/document_type.dart';

class PersonalID implements DocumentType{
  @override
  Future<String> recognizeTextFromImage(String imagePath) async {
    String recognizedText = await FlutterTesseractOcr.extractText(imagePath);
    //Process recognizedText
    return recognizedText;
  }
}