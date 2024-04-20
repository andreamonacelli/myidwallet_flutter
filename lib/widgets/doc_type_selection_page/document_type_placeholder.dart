import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:myidwallet_flutter/routes/doc_type_selection_page.dart';

class DocumentTypePlaceholder extends StatelessWidget {

  final int _fileNameIndex = 0;
  final int _documentTypeTitle = 1;
  final int _documentTypeNation = 2;
  late final List<String> _docTypeDescription;

  DocumentTypePlaceholder(this._docTypeDescription);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /* LOG */print("${_docTypeDescription[_fileNameIndex]} placeholder has been tapped");
        DocTypeSelectionPage.selectedType = _docTypeDescription[_documentTypeTitle];
        DocTypeSelectionPage.selectedNation = _docTypeDescription[_documentTypeNation];
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
                    image: AssetImage("assets/images/${_docTypeDescription[_fileNameIndex]}.png"),
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
                      _docTypeDescription[_documentTypeNation],
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