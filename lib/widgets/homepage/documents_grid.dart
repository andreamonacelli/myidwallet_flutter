import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/dbmanager/dbmanager.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/widgets/homepage/document_placeholder.dart';

///Definition of the grid that will contain the document cards in the homepage
class DocumentsGrid extends StatefulWidget{

  const DocumentsGrid({super.key});

  @override
  State<DocumentsGrid> createState() => _DocumentGridState();
}

///Handling the state of the grid, which will vary based on the documents in the DB
class _DocumentGridState extends State<DocumentsGrid>{

  List<Document> _documentList = [];

  Future<void> _initializeDocList() async {
    _documentList = await DBManager.fetchDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeDocList(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              shrinkWrap: true,
              itemCount: _documentList.length,
              itemBuilder: (BuildContext context, int index) {
                return DocumentPlaceholder(_documentList[index]);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

}