import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:myidwallet_flutter/models/entities/document_type.dart';

class HealthcareInsurance implements DocumentType{
  @override
  Future<Map<String, String>> recognizeTextFromImage(String imagePath, String nation) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    final recognizedDataMap = parseTesseraSanitariaText(recognizedText.text);
    return recognizedDataMap;
  }

  Map<String, String> parseTesseraSanitariaText(String recognizedText) {
    Map<String, String> dataMap = {};
    List<String> lines = recognizedText.split('\n');
    if(lines.length >= 6){
      dataMap["Surname"] = lines[0].trim();
      dataMap["Name"] = lines[1].trim();
      dataMap["Birth Date"] = lines[2].trim();
      dataMap["Unique Code"] = lines[3].trim();
      dataMap["Numero di identificazione della tessera"] = lines[4].trim();
      dataMap["Expiry Date"] = lines[5].trim();
    }
    return dataMap;
  }
}