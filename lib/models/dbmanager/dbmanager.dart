import 'dart:convert';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/widgets/doc_type_selection_page/document_type_placeholder.dart';
import 'package:myidwallet_flutter/widgets/doc_type_selection_page/document_type_placeholders_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager{
  static late Future<Database> database;
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
    database = openDatabase(
      join(await getDatabasesPath(), 'myidwallet_database.db'),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE $tableName (\n\t\"$idColumn\"\tTEXT NOT NULL,\n\t\"$nameColumn\"\tTEXT,\n\t\"$typeColumn\"\tTEXT,\n\t\"$nationColumn\"\tTEXT,\n\t\"$uniqueCodeColumn\"\tTEXT,\n\t\"$expiryDateColumn\"\tTEXT,\n\t\"$issuedDateColumn\"\tTEXT,\n\t\"$additionalDataColumn\"\tTEXT,\n\tPRIMARY KEY(\"$idColumn\")\n)"
        );
      },
      version: 1
    );
  }

  static Future<void> onDBCreate() async{
    final db = await database;
    await db.execute(
        "CREATE TABLE $tableName (\n\t\"$idColumn\"\tTEXT NOT NULL,\n\t\"$nameColumn\"\tTEXT,\n\t\"$typeColumn\"\tTEXT,\n\t\"$nationColumn\"\tTEXT,\n\t\"$uniqueCodeColumn\"\tTEXT,\n\t\"$expiryDateColumn\"\tTEXT,\n\t\"$issuedDateColumn\"\tTEXT,\n\t\"$additionalDataColumn\"\tTEXT,\n\tPRIMARY KEY(\"$idColumn\")\n)"
    );
  }

  static Future<void> insertDocument(Document document) async {
    final db = await database;
    await db.insert(
        tableName,
        document.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Document>> fetchDocuments() async {
    final db = await database;
    final List<Map<String, Object?>> documentAsMaps = await db.query(tableName);
    return [
      for(final {
        idColumn: documentGUID as String,
        nameColumn : documentHolderName as String,
        typeColumn: documentTypeDescr as String,
        nationColumn: documentNation as String,
        uniqueCodeColumn: uniqueCode as String,
        expiryDateColumn: expiryDate as String?,
        issuedDateColumn: dateOfIssue as String?,
        additionalDataColumn: additionalData as String
      } in documentAsMaps)
      Document.setAll(documentGUID, documentHolderName, documentTypeDescr, documentNation, uniqueCode, (expiryDate != null) ? DateTime.tryParse(expiryDate) : null, (dateOfIssue != null) ? DateTime.tryParse(dateOfIssue) : null, jsonDecode(additionalData), fetchBGImageAssetPath(documentTypeDescr, documentNation))
    ];
  }

  static String fetchBGImageAssetPath(String typeDescr, String nation){
    String assetsPath = "assets/images/";
    String? imageName;
    for(List<String> documentTypeData in DocumentPlaceholdersList.availableTypesAndNations){
      if(documentTypeData[DocumentTypePlaceholder.documentTypeDescr] == typeDescr && documentTypeData[DocumentTypePlaceholder.documentTypeNation] == nation){
        imageName = documentTypeData[DocumentTypePlaceholder.fileNameIndex];
      }
    }
    if(imageName == null){
      assetsPath += "plain_bg.png";
    } else {
      assetsPath += "$imageName.png";
    }
    return assetsPath;
  }

  static Future<void>? updateDocument(Document document) async {
    final db = await database;
    await db.update(
        tableName,
        document.toMap(),
        where: '$idColumn = ?',
        whereArgs: [document.documentGUID]
    );
  }

  static Future<void>? deleteDocument(String docGUID) async {
    final db = await database;
    await db.delete(
        tableName,
        where: '$idColumn = ?',
        whereArgs: [docGUID]
    );
  }
}