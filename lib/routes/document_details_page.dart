import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/document_info_list.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/document_name_type_banner.dart';

class DocumentDetailsPage extends StatelessWidget {

  static late Document displayedDocument;
  final double _aspectRatio = 7.5;

  const DocumentDetailsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                print("Edit document button pressed!");
              },
              icon: Icon(Icons.edit)
          ),
          IconButton(
              onPressed: () {
                print("Delete document button pressed!");
              },
              icon: Icon(Icons.delete_rounded)
          )
        ],
      ),
      body: Column(
        children: [
          DocumentMainInfoBanner(displayedDocument),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
            child: BarcodeWidget(
              data: displayedDocument.uniqueCode,
              barcode: Barcode.code128(),
              height: MediaQuery.of(context).size.height / _aspectRatio,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: DocumentTextInfoList(displayedDocument),
          )
        ],
      )
    );
  }

}