import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/routes.dart';

class DocumentPlaceholder extends StatelessWidget {

  late final Document _documentDisplayed;

  DocumentPlaceholder(this._documentDisplayed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("${_documentDisplayed.documentHolderName} document placeholder has been tapped");
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        child: ListTile(
          leading: Image(
            image: AssetImage("assets/images/${_documentDisplayed.placeholderBGImage}.png"),
            fit: BoxFit.fill,
          ),
          title: Text(
            _documentDisplayed.documentHolderName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}