import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';

class DocumentTextInfoList extends StatelessWidget {

  final Document _displayedDocument;

  DocumentTextInfoList(this._displayedDocument);

  @override
  Widget build(BuildContext context) {
    List<String> documentDataList = _displayedDocument.toList();
    return ListView.builder(
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(5),
      shrinkWrap: true,
      itemCount: documentDataList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 2),
          child: Text(
            documentDataList[index],
            style: TextStyle(
                fontSize: 15,
                color: Colors.black87
            ),
          )
        );
      }
    );
  }

}