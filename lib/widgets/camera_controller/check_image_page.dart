import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/dbmanager/dbmanager.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:myidwallet_flutter/routes/doc_type_selection_page.dart';

class CheckImagePage extends StatelessWidget{

  late final String _imagePath;
  final GlobalKey<FormState> _holderNameForm = GlobalKey<FormState>();
  final TextEditingController formController = TextEditingController();
  final double _imageSectionHeightRatio = 1.8;

  CheckImagePage(this._imagePath);

  @override
  Widget build(BuildContext context) {
    TextFormField textForm = TextFormField(
      controller: formController,
      decoration: InputDecoration(
          hintText: "Nome dell'intestatario"
      ),
      validator: (String? holderName) {
        if(holderName == null || holderName.isEmpty){
          return "Per favore inserire il nome dell'intestatario";
        }
        return null;
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Risultati scansione"),
        centerTitle: true
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / _imageSectionHeightRatio,
            color: Colors.white70,
            alignment: Alignment.center,
            child: Image.file(File(_imagePath))
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Form(
              key: _holderNameForm,
              child: textForm
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: FloatingActionButton.extended(
              heroTag: "retry_fab",
              backgroundColor: Colors.grey,
              label: Text(
                    "Scatta di nuovo la foto",
                    style: TextStyle(
                      backgroundColor: Colors.grey,
                      fontSize: 12,
                      color: Colors.black54
                    ),
                ),
              onPressed: () {
                Navigator.of(context).pushNamed(RoutesManager.cameraScreenRoute);
              }
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "add_fab",
        backgroundColor: Colors.green,
        label: Text(
            "Aggiungi",
            style: TextStyle(
                backgroundColor: Colors.green,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white70
            ),
        ),
        onPressed: () {
          ///TODO: Add the data processing snippet -> save it in the DB instantly
          Document newDocument = Document(formController.text, DocTypeSelectionPage.selectedNation);
          newDocument.documentTypeDescr = DocTypeSelectionPage.selectedType;
          DBManager.insertDocument(newDocument);
          Navigator.of(context).pushNamed(RoutesManager.homepageRoute);
        },
      ),
    );
  }

}