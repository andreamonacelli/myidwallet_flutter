import 'package:myidwallet_flutter/models/entities/driving_license.dart';
import 'package:myidwallet_flutter/models/entities/healthcare_insurance.dart';
import 'package:myidwallet_flutter/models/entities/passport.dart';
import 'package:myidwallet_flutter/models/entities/personal_id.dart';

import 'document_type.dart';

///Definition of the document entity (based on its transposition from the DB structure)
class Document {
  ///Attributes
  late String _documentGUID;
  String _documentHolderName;
  late String _documentTypeDescr;
  late String _uniqueCode;
  String _documentNation;
  late DateTime _expiryDate;
  late DateTime _dateOfIssue;
  late Map<String, String> _additionalData;
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
      this._additionalData
  ){
    _documentType = _parseTypeFromDescription();
    _placeholderBGImage = "assets/images/${_documentTypeDescr}_$_documentNation.png";
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

  Map<String, Object?> toMap(){
    return {
      'id': _documentGUID,
      'holderName' : _documentHolderName,
      'type': _documentTypeDescr,
      'nation': _documentNation,
      'uniqueCode': _uniqueCode,
      'expiryDate': _expiryDate.toIso8601String(),
      'issueDate': _dateOfIssue.toIso8601String(),
      'additionalData': _additionalData
    };
  }

  DocumentType _parseTypeFromDescription(){
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

  Map<String, String> get additionalData => _additionalData;

  set additionalData(Map<String, String> value) {
    _additionalData = value;
  }

  DateTime get dateOfIssue => _dateOfIssue;

  set dateOfIssue(DateTime value) {
    _dateOfIssue = value;
  }

  DateTime get expiryDate => _expiryDate;

  set expiryDate(DateTime value) {
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