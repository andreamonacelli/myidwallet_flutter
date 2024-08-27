import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/confirmation_dialog.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/document_info_list.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/document_name_type_banner.dart';
import 'package:myidwallet_flutter/widgets/document_edit_page/document_edit_page.dart';

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
              onPressed: () async {
                print("Edit document button pressed!");
                /* Bring user to a similar page but where the fields are editable */
                final editResult = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DocumentEditPage(displayedDocument: displayedDocument,) )
                );
              },
              icon: Icon(Icons.edit)
          ),
          IconButton(
              onPressed: () async {
                print("Delete document button pressed!");
                /* Ask user for confirmation then invoke the DB delete procedure */
                showDialog<String>(
                    context: context,
                    builder: (BuildContext buildContext) => ConfirmationDialog("delete_doc", RoutesManager.homepageRoute)
                );
                //await DBManager.deleteDocument(displayedDocument.documentGUID);
              },
              icon: Icon(Icons.delete_rounded)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                child: DocumentTextInfoList(displayedDocument)
            )
          ],
        ),
      )
    );
  }

}