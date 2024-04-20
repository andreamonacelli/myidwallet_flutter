import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static late final Database database;
  static const String tableName = "Documents";
  static const String idColumn = "INTERNAL_DOC_ID";
  static const String nameColumn = "DOC_NAME";
  static const String typeColumn = "DOC_TYPE";
  static const String nationColumn = "DOC_NATION";
  static const String uniqueCodeColumn = "DOC_UNIQUE_CODE";
  static const String expiryDateColumn = "DOC_EXPIRY_DATE";
  static const String issuedDateColumn = "DOC_DATE_OF_ISSUE";
  static const String additionalDataColumn = "DOC_ADDITIONAL_DATA";

  static onDBCreate(){
    return database.execute(
        "CREATE TABLE $tableName (\n\t\"$idColumn\"\tTEXT NOT NULL,\n\t\"$nameColumn\"\tTEXT,\n\t\"$typeColumn\"\tTEXT,\n\t\"$nationColumn\"\tTEXT,\n\t\"$uniqueCodeColumn\"\tTEXT,\n\t\"$expiryDateColumn\"\tTEXT,\n\t\"$issuedDateColumn\"\tTEXT,\n\t\"$additionalDataColumn\"\tTEXT,\n\tPRIMARY KEY(\"$idColumn\")\n)"
    );
  }

  Future<void> insertDocument(Document document) async {
    final Database db = await database;
    await db.insert(
        tableName,
        document.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<Document>> fetchDocuments() async {
    final Database db = await database;
    final List<Map<String, Object?>> documentAsMaps = await db.query(tableName);
    return [
      for(final {
        'id': documentGUID as String,
        'holderName' : documentHolderName as String,
        'type': documentTypeDescr as String,
        'nation': documentNation as String,
        'uniqueCode': uniqueCode as String,
        'expiryDate': expiryDate as DateTime,
        'issueDate': dateOfIssue as DateTime,
        'additionalData': additionalData as Map<String, String>
      } in documentAsMaps)
      Document.setAll(documentGUID, documentHolderName, documentTypeDescr, documentNation, uniqueCode, expiryDate, dateOfIssue, additionalData)
    ];
  }

  Future<void> updateDocument(Document document) async {
    final Database db = await database;
    await db.update(
        tableName,
        document.toMap(),
        where: 'id = ?',
        whereArgs: [document.documentGUID]
    );
  }

  Future<void> deleteDocument(String docGUID) async {
    final Database db = await database;
    await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [docGUID]
    );
  }
}