import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/dbmanager/dbmanager.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:myidwallet_flutter/routes/doc_type_selection_page.dart';
import 'package:myidwallet_flutter/widgets/header_text_card.dart';

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
      body: Stack(
        children: [
          Column(
            children: [
              HeaderTextCard("Risultati scansione", Colors.cyan, Colors.white70),
              Expanded(
                flex: 2,
                child: Container(
                    color: Colors.white70,
                    child: Image.file(File(_imagePath))
                )
              ),
              Flexible(
                child: Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Form(
                        key: _holderNameForm,
                        child: textForm
                    )
                )
              )
            ]
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  width: 200,
                  height: 37,
                  child: FloatingActionButton.extended(
                      heroTag: "retry_fab",
                      icon: Icon(Icons.arrow_back),
                      extendedPadding: EdgeInsets.all(5),
                      backgroundColor: Colors.grey,
                      label: Text(
                        "Scatta di nuovo la foto",
                        style: TextStyle(
                            backgroundColor: Colors.grey,
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(RoutesManager.cameraScreenRoute);
                      }
                  ),
                )
            )
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 115,
                  height: 37,
                  child: FloatingActionButton.extended(
                    icon: Icon(Icons.add, color: Colors.white70),
                    extendedPadding: EdgeInsets.all(5),
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
                    onPressed: () async {
                      ///TODO: Add the data processing snippet -> save it in the DB instantly
                      Document newDocument = Document(formController.text, DocTypeSelectionPage.selectedNation);
                      newDocument.documentTypeDescr = DocTypeSelectionPage.selectedType;
                      newDocument.documentNation = DocTypeSelectionPage.selectedNation;
                      newDocument.documentType = newDocument.parseTypeFromDescription();
                      //Document newDocument = Document.forTesting(formController.text, DocTypeSelectionPage.selectedNation);
                      newDocument.placeholderBGImage = DocTypeSelectionPage.placeholderBGImagePath;
                      newDocument.generateDocumentGUID();
                      var tempVar = await newDocument.documentType?.recognizeTextFromImage(_imagePath);
                      DBManager.insertDocument(newDocument);
                      Navigator.of(context).pushNamed(RoutesManager.homepageRoute);
                    },
                  )
                )
            )
          )
        ],
      )
    );
  }

}