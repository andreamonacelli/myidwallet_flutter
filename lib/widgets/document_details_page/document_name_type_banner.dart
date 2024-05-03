import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/widgets/doc_type_selection_page/document_type_placeholders_list.dart';

class DocumentMainInfoBanner extends StatelessWidget {

  final double _bannerAspectRatio = 3;
  final Document _displayedDocument;

  DocumentMainInfoBanner(this._displayedDocument);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / _bannerAspectRatio,
      margin: EdgeInsets.fromLTRB(5, 2, 5, 0),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(_displayedDocument.placeholderBGImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
              child: Text(
                DocumentPlaceholdersList.getVerboseTypeDescr(_displayedDocument.documentTypeDescr, _displayedDocument.documentNation),
                softWrap: true,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87
                ),
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Center(
              child: Text(
                _displayedDocument.documentHolderName,
                softWrap: true,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
                ),
              ),
            )
          )
        ],
      )
    );
  }

}