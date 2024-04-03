import 'package:flutter/material.dart';

class DocumentTypePlaceholder extends StatelessWidget {

  late final String _docTypeDescription;

  DocumentTypePlaceholder(this._docTypeDescription);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("$_docTypeDescription placeholder has been tapped"),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        child: Row(
          children: [
            Flexible( child:
              ListTile(
                  leading: Image(
                    image: AssetImage("assets/images/$_docTypeDescription"),
                    fit: BoxFit.fill,
                  ),
                  title: Text(
                      "Codice Fiscale", ///TODO: parametrize the field
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                  subtitle: Text(
                      "(Italia)", ///TODO: parametrize the field
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