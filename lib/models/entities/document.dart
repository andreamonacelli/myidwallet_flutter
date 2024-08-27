import 'dart:convert';
import 'package:myidwallet_flutter/models/dbmanager/dbmanager.dart';
import 'package:myidwallet_flutter/models/entities/driving_license.dart';
import 'package:myidwallet_flutter/models/entities/healthcare_insurance.dart';
import 'package:myidwallet_flutter/models/entities/passport.dart';
import 'package:myidwallet_flutter/models/entities/personal_id.dart';
import 'package:uuid/uuid.dart';
import 'document_type.dart';

///Definition of the document entity (based on its transposition from the DB structure)
class Document {
  ///Attributes
  late String _documentGUID;
  String _documentHolderName;
  late String _documentTypeDescr;
  late String _uniqueCode;
  String _documentNation;
  late DateTime? _expiryDate;
  DateTime? _dateOfIssue;
  late Map<String, Object?> _additionalData;
  DocumentType? _documentType;
  late String _placeholderBGImage;

  ///Constructors
  Document(this._documentHolderName, this._documentNation);
  Document.setAll(
      this._documentGUID,
      this._documentHolderName,
      this._documentTypeDescr,
      this._documentNation,
      this._uniqueCode,
      this._expiryDate,
      this._dateOfIssue,
      this._additionalData,
      this._placeholderBGImage
  ){
    _documentType = parseTypeFromDescription();
  }
  Document.forTesting(this._documentHolderName, this._documentNation){
    _documentTypeDescr = "healthcare";
    _documentGUID = "tryoutGUID";
    _uniqueCode = "debugUniqueCode";
    _expiryDate = DateTime.now();
    _dateOfIssue = DateTime.now();
    _additionalData = {"prova": "test"};
  }

  ///Methods
  void fillData(){
    throw UnimplementedError();
  }

  void export(){
    throw UnimplementedError();
  }

  Set<String> getAllProperties(){
    throw UnimplementedError();
  }

  Map<String, String?> toMap(){
    return {
      DBManager.idColumn : _documentGUID,
      DBManager.nameColumn : _documentHolderName,
      DBManager.typeColumn : _documentTypeDescr,
      DBManager.nationColumn : _documentNation,
      DBManager.uniqueCodeColumn : _uniqueCode,
      DBManager.expiryDateColumn : _expiryDate?.toIso8601String(),
      DBManager.issuedDateColumn : _dateOfIssue?.toIso8601String(),
      DBManager.additionalDataColumn : jsonEncode(_additionalData)
    };
  }

  List<String> toList(){
    String formattedDateOfIssue = (_dateOfIssue != null) ? "${_dateOfIssue?.day}/${_dateOfIssue?.month}/${_dateOfIssue?.year}" : "Non disponibile";
    String formattedExpiryDate = (_expiryDate != null) ? "${_expiryDate?.day}/${_expiryDate?.month}/${_expiryDate?.year}" : "Non disponibile";
    List<String> outList = [
      "Intestatario documento:    $_documentHolderName",
      "Nazione:    $_documentNation",
      "Data di emissione:    $formattedDateOfIssue",
      "Data di scadenza:    $formattedExpiryDate",
    ];
    if(_additionalData.keys.isNotEmpty) {
      for (String key in _additionalData.keys) {
        outList.add(
            "$key:    ${_additionalData[key]}"
        );
      }
    }
    return outList;
  }

  void generateDocumentGUID(){
    Uuid uuid = Uuid();
    _documentGUID = uuid.v1();
  }

  DocumentType parseTypeFromDescription(){
    switch(_documentTypeDescr){
      case 'healthcare':
        return HealthcareInsurance();
      case 'drlicense':
        return DrivingLicense();
      case 'passport':
        return Passport();
      case 'personalid':
        return PersonalID();
      default: return HealthcareInsurance();
    }
  }

  DocumentType? get documentType => _documentType;

  set documentType(DocumentType? value) {
    _documentType = value;
  }

  Map<String, Object?> get additionalData => _additionalData;

  set additionalData(Map<String, Object?> value) {
    _additionalData = value;
  }

  DateTime? get dateOfIssue => _dateOfIssue;

  set dateOfIssue(DateTime? value) {
    _dateOfIssue = value;
  }

  DateTime? get expiryDate => _expiryDate;

  set expiryDate(DateTime? value) {
    _expiryDate = value;
  }

  String get documentNation => _documentNation;

  set documentNation(String value) {
    _documentNation = value;
  }

  String get uniqueCode => _uniqueCode;

  set uniqueCode(String value) {
    _uniqueCode = value;
  }

  String get documentTypeDescr => _documentTypeDescr;

  set documentTypeDescr(String value) {
    _documentTypeDescr = value;
  }

  String get documentHolderName => _documentHolderName;

  set documentHolderName(String value) {
    _documentHolderName = value;
  }

  String get documentGUID => _documentGUID;

  set documentGUID(String value) {
    _documentGUID = value;
  }

  String get placeholderBGImage => _placeholderBGImage;

  set placeholderBGImage(String value) {
    _placeholderBGImage = value;
  }

}