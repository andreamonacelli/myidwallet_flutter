import 'dart:io';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:myidwallet_flutter/models/entities/document_type.dart';

class HealthcareInsurance implements DocumentType{
  @override
  Future<String> recognizeTextFromImage(String imagePath) async {
    String recognizedText;
    if(File(imagePath).existsSync()) {
       recognizedText = await FlutterTesseractOcr.extractText(imagePath);
    } else {
      recognizedText = "";
    }
    //Process recognizedText
    return recognizedText;
  }
}