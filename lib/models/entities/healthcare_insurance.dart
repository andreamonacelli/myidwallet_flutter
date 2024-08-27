import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:myidwallet_flutter/models/entities/document_type.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class HealthcareInsurance implements DocumentType{
  @override
  Future<Map<String, Object?>> recognizeTextFromImage(String imagePath, String nation) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    final recognizedDataMap = parseTesseraSanitariaText(recognizedText.text);
    return recognizedDataMap;
  }

  Map<String, Object?> parseTesseraSanitariaText(String recognizedText) {
    Map<String, Object> dataMap = {};
    RegExp codiceFiscaleRegex = RegExp(r'^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]\$');
    RegExp codiceFiscaleTypoRegex = RegExp(r'^[A-Z0]{6}[0-9O]{2}[A-Z0][0-9O]{2}[A-Z0][0-9O]{3}[A-Z0]$');
    RegExp numeroIdTesseraRegex = RegExp(r'\b\d{20}\b');
    List<String> lines = recognizedText.split('\n');
    for(String line in lines){
      if(discardString(line)){
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
      if(codiceFiscaleRegex.hasMatch(line.replaceAll(" ", ""))){
        dataMap["Unique Code"] = line.replaceAll(" ", "");
        continue;
      }
      if(codiceFiscaleTypoRegex.hasMatch(line.replaceAll(" ", ""))){
        dataMap["Unique Code"] = codiceFiscaleTypoFixing(line.replaceAll(" ", ""));
        continue;
      }
      if(numeroIdTesseraRegex.hasMatch(line.replaceAll(" ", ""))){
        dataMap["Numero di identificazione della tessera"] = line;
      }
      else {
        try{
          DateTime date = DateFormat("dd/MM/yyyy").parse(line.replaceAll(" ", ""));
          if(date.isBefore(DateTime.now())){
            dataMap["Data di nascita"] = line.replaceAll(" ", "");
          } else {
            dataMap["Expiry Date"] = line.replaceAll(" ", "");
          }
        } catch(e){
          if(dataMap.containsKey("Cognome")){
            dataMap["Nome"] = line.trim();
          } else{
            dataMap["Cognome"] = line.trim();
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

  bool discardString(String string){
    List<String> headers = ["3 Cognome", "4 Nome", "5 Data di nascita", "6 Numero identificazione personale", "7 Numero identificazione dell'istituzione", "8 Numero di identificazione della tessera", "9 Scadenza"];
    List<String> textToNotConsider = ["TESSERA EUROPEA DI ASSICURAZIONE MALATTIA", "IT"];
    if(headers.contains(string) || textToNotConsider.contains(string)){
      return true;
    }
    //Perform fuzzy matching over the strings in order to be solid against low quality readings
    for(String header in headers){
      if(ratio(string, header) >= 80){
        return true;
      }
    }
    for(String text in textToNotConsider){
      if(ratio(string, text) >= 80){
        return true;
      }
    }
    //If all the checks are passed, then the string is good to be used
    return false;
  }

}