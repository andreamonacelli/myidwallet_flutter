import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/dbmanager/dbmanager.dart';
import 'package:myidwallet_flutter/routes/document_details_page.dart';

class ConfirmationDialog extends StatelessWidget {

  final String _operationToConfirm;
  final String _nextPageRouteCode;
  late final BuildContext _dialogContext;
  final int _titleIndex = 0;
  final int _descriptionIndex = 1;
  final Map<String, List<String>> _operationsTextFields = {
    "delete_doc" : ["ELIMINAZIONE DOCUMENTO", "Sei sicuro di voler eliminare il documento?\nATTENZIONE: OPERAZIONE IRREVERSIBILE!"],
    "update_doc" : ["Salvataggio Modifiche", "Vuoi salvare le modifiche apportate?"],
    "implicit_update" : ["Modifiche non salvate", "Sono presenti modifiche non salvate, vuoi salvarle prima di tornare indietro?"]
  };

  ConfirmationDialog(this._operationToConfirm, this._nextPageRouteCode);

  @override
  Widget build(BuildContext context) {
    _dialogContext = context;
    return AlertDialog(
      title: Text(_operationsTextFields[_operationToConfirm]![_titleIndex]),
      content: Text(_operationsTextFields[_operationToConfirm]![_descriptionIndex]),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            print('Operation has been canceled');
            /* If operation is canceled stay in the current page */
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('NO'),
        ),
        TextButton(
          onPressed: () async {
            print('Operation has been confirmed');
            /* If operation is confirmed call the respective operation and then switch to the linked page */
            //Navigator.pop(context, 'OK');
            await _executeOperation();
            if(context.mounted){
              Navigator.of(context).pushNamed(_nextPageRouteCode);
            }
          },
          child: const Text('SI'),
        ),
      ],
    );
  }

  Future<void> _executeOperation() async{
    switch(_operationToConfirm){
      case "delete_doc":
        await DBManager.deleteDocument(DocumentDetailsPage.displayedDocument.documentGUID);
      case "update_doc":
        await DBManager.updateDocument(DocumentDetailsPage.displayedDocument);
      case "implicit_update":
        ///TODO: implement the implicit update feature
        break;
      default: print("UNEXCPECTED ERROR!");
    }
  }
}
