import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/routes.dart';

class CheckImagePage extends StatelessWidget{

  late final String _imagePath;
  final GlobalKey<FormState> _holderNameForm = GlobalKey<FormState>();

  CheckImagePage(this._imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.file(File(_imagePath)),
          Form(
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
          ),
          FloatingActionButton.extended(
              label: Card(
                  shape: CircleBorder(),
                  color: Colors.grey,
                  child: Text(
                    "Scatta di nuovo la foto",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54
                    ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(RoutesManager.cameraScreenRoute);
              }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Card(
          shape: CircleBorder(),
          color: Colors.green,
          child: Text(
            "Aggiungi",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black54
            ),
          ),
        ),
        onPressed: () {
          ///Add the data processing snippet
          Navigator.of(context).pushNamed(RoutesManager.homepageRoute);
        },
      ),
    );
  }

}