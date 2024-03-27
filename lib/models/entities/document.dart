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
  late DocumentType _documentType;
  //documentScan

  ///Constructors
  Document(this._documentHolderName, this._documentNation);

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

  DocumentType get documentType => _documentType;

  set documentType(DocumentType value) {
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

//implement getRecognizerTextResult


}