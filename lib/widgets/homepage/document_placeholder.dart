import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/routes/document_details_page.dart';
import 'package:myidwallet_flutter/routes.dart';

class DocumentPlaceholder extends StatelessWidget {

  late final Document _documentDisplayed;

  DocumentPlaceholder(this._documentDisplayed);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("${_documentDisplayed.documentHolderName} document placeholder has been tapped");
        DocumentDetailsPage.displayedDocument = _documentDisplayed;
        Navigator.of(context).pushNamed(RoutesManager.documentDetailsRoute);
      },
      child: Container(
          height: MediaQuery.of(context).size.height / 4,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(_documentDisplayed.placeholderBGImage),
              fit: BoxFit.fill,
            ),
          ),
        child: Center(
            child: Text(
                _documentDisplayed.documentHolderName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Baloo2',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black87
                ),
            )
        )
      ),
    );
  }
}