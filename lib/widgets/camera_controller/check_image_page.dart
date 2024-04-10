import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/routes.dart';

class CheckImagePage extends StatelessWidget{

  late final String _imagePath;
  final GlobalKey<FormState> _holderNameForm = GlobalKey<FormState>();
  final double _imageSectionHeightRatio = 1.8;

  CheckImagePage(this._imagePath);

  ///TODO: Refactor widget's structure based on the draft obtained from the Figma-to-Code plugin (adjusting responsiveness and replacing containers with respective widgets)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nome dell'intestatario"
                ),
                validator: (String? holderName) {
                  if(holderName == null || holderName.isEmpty){
                    return "Per favore inserire il nome dell'intestatario";
                  }
                  return null;
                },
              )
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: FloatingActionButton.extended(
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
          ///TODO: Add the data processing snippet
          Navigator.of(context).pushNamed(RoutesManager.homepageRoute);
        },
      ),
    );
  }

}