import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/models/dbmanager/dbmanager.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/confirmation_dialog.dart';

class DocumentEditPage extends StatefulWidget {
  final Document displayedDocument;

  DocumentEditPage({required this.displayedDocument});

  @override
  _DocumentEditPageState createState() => _DocumentEditPageState();
}

class _DocumentEditPageState extends State<DocumentEditPage> {
  late TextEditingController _documentHolderNameController;
  late TextEditingController _documentNationController;
  late TextEditingController _dateOfIssueController;
  late TextEditingController _expiryDateController;
  late Map<String, TextEditingController> _additionalDataControllers;

  @override
  void initState() {
    super.initState();

    _documentHolderNameController = TextEditingController(text: widget.displayedDocument.documentHolderName);
    _documentNationController = TextEditingController(text: widget.displayedDocument.documentNation);

    _dateOfIssueController = TextEditingController(
      text: widget.displayedDocument.dateOfIssue != null
          ? "${widget.displayedDocument.dateOfIssue!.day}/${widget.displayedDocument.dateOfIssue!.month}/${widget.displayedDocument.dateOfIssue!.year}"
          : "Non disponibile",
    );

    _expiryDateController = TextEditingController(
      text: widget.displayedDocument.expiryDate != null
          ? "${widget.displayedDocument.expiryDate!.day}/${widget.displayedDocument.expiryDate!.month}/${widget.displayedDocument.expiryDate!.year}"
          : "Non disponibile",
    );

    _additionalDataControllers = {
      for (var entry in widget.displayedDocument.additionalData.entries)
        entry.key: TextEditingController(text: entry.value?.toString())
    };
  }

  @override
  void dispose() {
    _documentHolderNameController.dispose();
    _documentNationController.dispose();
    _dateOfIssueController.dispose();
    _expiryDateController.dispose();
    for (var controller in _additionalDataControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveDocument() {
    //Fetch data from the controllers and store it in the document entity
    widget.displayedDocument.documentHolderName = _documentHolderNameController.text;
    widget.displayedDocument.documentNation = _documentNationController.text;
    widget.displayedDocument.dateOfIssue = DateFormat("dd/MM/yyyy").parse(_dateOfIssueController.text);
    widget.displayedDocument.expiryDate = DateFormat("dd/MM/yyyy").parse(_expiryDateController.text);
    widget.displayedDocument.additionalData = {
      for (var entry in _additionalDataControllers.entries)
        entry.key: entry.value.text
    };
    //Before actually storing the data, ask the user for confirmation, as done when deleting an entity
    showDialog<String>(
        context: context,
        builder: (BuildContext buildContext) => ConfirmationDialog("update_doc", RoutesManager.documentDetailsRoute)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifica documento"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveDocument,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _documentHolderNameController,
                decoration: InputDecoration(
                  labelText: "Intestatario documento",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _documentNationController,
                decoration: InputDecoration(
                  labelText: "Nazione",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _dateOfIssueController,
                decoration: InputDecoration(
                  labelText: "Data di emissione",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  labelText: "Scadenza",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ..._additionalDataControllers.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: entry.value,
                    decoration: InputDecoration(
                      labelText: entry.key,
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
