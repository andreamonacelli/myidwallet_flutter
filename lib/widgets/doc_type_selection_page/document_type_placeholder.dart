import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:myidwallet_flutter/routes/doc_type_selection_page.dart';

class DocumentTypePlaceholder extends StatelessWidget {

  static const int fileNameIndex = 0;
  final int _documentTypeTitle = 1;
  static const int documentTypeNation = 2;
  static const int documentTypeDescr = 3;
  late final List<String> _docTypeDescription;

  DocumentTypePlaceholder(this._docTypeDescription);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* LOG */print("${_docTypeDescription[fileNameIndex]} placeholder has been tapped");
        DocTypeSelectionPage.selectedType = _docTypeDescription[documentTypeDescr];
        DocTypeSelectionPage.selectedNation = _docTypeDescription[documentTypeNation];
        DocTypeSelectionPage.placeholderBGImagePath = "assets/images/${_docTypeDescription[fileNameIndex]}.png";
        Navigator.of(context).pushNamed(RoutesManager.cameraScreenRoute);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        child: Row(
          children: [
            Flexible( child:
              ListTile(
                  leading: Image(
                    image: AssetImage("assets/images/${_docTypeDescription[fileNameIndex]}.png"),
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                      _docTypeDescription[_documentTypeTitle],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                  subtitle: Text(
                      _docTypeDescription[documentTypeNation],
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14
                      ),
                    )
              )
            ),
            Icon(Icons.chevron_right)
          ],
        ),
      ),
    );
  }
}