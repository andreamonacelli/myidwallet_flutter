import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager{
  static late Database database;
  static const String tableName = "Documents";
  static const String idColumn = "INTERNAL_DOC_ID";
  static const String nameColumn = "DOC_NAME";
  static const String typeColumn = "DOC_TYPE";
  static const String nationColumn = "DOC_NATION";
  static const String uniqueCodeColumn = "DOC_UNIQUE_CODE";
  static const String expiryDateColumn = "DOC_EXPIRY_DATE";
  static const String issuedDateColumn = "DOC_DATE_OF_ISSUE";
  static const String additionalDataColumn = "DOC_ADDITIONAL_DATA";

  static Future<void> initializeDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'myidwallet_database.db'),
      onCreate: (db, version) => DBManager.onDBCreate(),
      version: 1
    );
  }

  static Future<void> onDBCreate() async{
    return await database.execute(
        "CREATE TABLE $tableName (\n\t\"$idColumn\"\tTEXT NOT NULL,\n\t\"$nameColumn\"\tTEXT,\n\t\"$typeColumn\"\tTEXT,\n\t\"$nationColumn\"\tTEXT,\n\t\"$uniqueCodeColumn\"\tTEXT,\n\t\"$expiryDateColumn\"\tTEXT,\n\t\"$issuedDateColumn\"\tTEXT,\n\t\"$additionalDataColumn\"\tTEXT,\n\tPRIMARY KEY(\"$idColumn\")\n)"
    );
  }

  static Future<void> insertDocument(Document document) async {
    await database.insert(
        tableName,
        document.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Document>> fetchDocuments() async {
    final List<Map<String, Object?>> documentAsMaps = await database.query(tableName);
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

  static Future<void>? updateDocument(Document document) async {
    await database.update(
        tableName,
        document.toMap(),
        where: 'id = ?',
        whereArgs: [document.documentGUID]
    );
  }

  static Future<void>? deleteDocument(String docGUID) async {
    await database.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [docGUID]
    );
  }
}