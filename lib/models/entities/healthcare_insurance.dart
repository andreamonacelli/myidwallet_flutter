import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    RegExp codiceFiscaleRegex = RegExp(r'^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]\$');
    RegExp codiceFiscaleTypoRegex = RegExp(r'^[A-Z0]{6}[0-9O]{2}[A-Z0][0-9O]{2}[A-Z0][0-9O]{3}[A-Z0]$');
    RegExp numeroIdTesseraRegex = RegExp(r'\b\d{20}\b');
    List<String> lines = recognizedText.split('\n');
    List<String> headers = ["3 Cognome", "4 Nome", "5 Data di nascita", "6 Numero identificazione personale", "7 Numero identificazione dell'istituzione", "8 Numero di identificazione della tessera", "9 Scadenza"];
    List<String> textToNotConsider = ["TESSERA EUROPEA DI ASSICURAZIONE MALATTIA", "IT"];
    for(String line in lines){
      if(headers.contains(line) || textToNotConsider.contains(line)){
        continue;
      }
      if(line.contains("SSN-MIN")){
        if(line.indexOf("SSN-MIN") != 0) {
          dataMap["Numero di identificazione dell'istituzione"] = line.substring(line.indexOf(" ") + 1);
          line = line.split(" ")[0];
        } else{
          dataMap["Numero di identificazione dell'istituzione"] = line;
          continue;
        }
      }
      if(codiceFiscaleRegex.hasMatch(line)){
        dataMap["Unique Code"] = line;
        continue;
      }
      if(codiceFiscaleTypoRegex.hasMatch(line)){
        dataMap["Unique Code"] = codiceFiscaleTypoFixing(line);
        continue;
      }
      if(numeroIdTesseraRegex.hasMatch(line)){
        dataMap["Numero di identificazione della tessera"] = line;
      }
      else {
        try{
          DateTime date = DateFormat("dd/MM/yyyy").parse(line.trim());
          if(date.isBefore(DateTime.now())){
            dataMap["Birth Date"] = line.trim();
          } else {
            dataMap["Expiry Date"] = line.trim();
          }
        } catch(e){
          if(dataMap.containsKey("Surname")){
            dataMap["Name"] = line.trim();
          } else{
            dataMap["Surname"] = line.trim();
          }
        }
      }
    }
    return dataMap;
  }

  String codiceFiscaleTypoFixing(String codiceFiscale){
    String correctedCodiceFiscale = codiceFiscale.replaceAll('O', '0');
    correctedCodiceFiscale = correctedCodiceFiscale.split('').asMap().entries.map((entry) {
      int index = entry.key;
      String char = entry.value;
      if ((index < 6 || index == 8 || index == 11 || index == 15) && char == '0') {
        return 'O';
      }
      return char;
    }).join();
    return correctedCodiceFiscale;
  }

}