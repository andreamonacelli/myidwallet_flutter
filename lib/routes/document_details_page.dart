import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/confirmation_dialog.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/document_info_list.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/document_name_type_banner.dart';

class DocumentDetailsPage extends StatelessWidget {

  static late Document displayedDocument;
  final double _aspectRatio = 7.5;

  const DocumentDetailsPage();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool invoked) {
          /* Whenever a "pop" action occurs from the details page, redirect to homepage no matter what */
          Navigator.of(context).pushNamed(RoutesManager.homepageRoute);
        },
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      print("Edit document button pressed!");
                      /* Redirect user to the edit document page */
                      Navigator.of(context).pushNamed(RoutesManager.documentEditPage);
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
        )
    );
  }

}