///Definition of the document entity (based on its transposition from the DB structure)
class Document {
  ///Attributes
  String? _documentGUID;
  String? _documentHolderName;
  String? _documentTypeDescr;
  String? _uniqueCode;
  String? _documentNation;
  DateTime? _expiryDate;
  DateTime? _dateOfIssue;
  Map<String, String>? _additionalData;
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

  //implement getRecognizerTextResult
}