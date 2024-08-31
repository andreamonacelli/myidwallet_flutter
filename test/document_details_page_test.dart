import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myidwallet_flutter/models/entities/document.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:myidwallet_flutter/routes/document_details_page.dart';
import 'package:myidwallet_flutter/routes/document_edit_page.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/confirmation_dialog.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/document_info_list.dart';
import 'package:myidwallet_flutter/widgets/document_details_page/document_name_type_banner.dart';

void main(){
  final mockDocument = Document("Mario Rossi", "Italia");

  setUp(() {
    mockDocument.generateDocumentGUID();
    mockDocument.placeholderBGImage = "assets/images/healthcare_it.png";
    mockDocument.documentTypeDescr = "healthcare";
    mockDocument.documentType = mockDocument.parseTypeFromDescription();
    mockDocument.expiryDate = DateTime(2024, 12, 31);
    mockDocument.uniqueCode = "RSSMRA80A01H501U";
    mockDocument.additionalData = {
      "Cognome": "ROSSI",
      "Nome": "MARIO",
      "Data di Nascita": "1/1/1980"
    };
    DocumentDetailsPage.displayedDocument = mockDocument;
  });

  group("DocumentDetailsPage widget testing", () {
    testWidgets("Check if the details page renders correctly", (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          onGenerateRoute: RoutesManager.generateRoute,
          home: DocumentDetailsPage(),
        ),
      );
      expect(find.byType(DocumentMainInfoBanner), findsOneWidget);
      expect(find.byType(DocumentTextInfoList), findsOneWidget);
      expect(find.text("Mario Rossi"), findsOneWidget);
      expect(find.byType(BarcodeWidget), findsOneWidget);
    });

    testWidgets("Test navigation to edit page", (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          onGenerateRoute: RoutesManager.generateRoute,
          home: DocumentDetailsPage(),
        ),
      );
      await widgetTester.tap(find.byIcon(Icons.edit));
      await widgetTester.pumpAndSettle();
      expect(find.byType(DocumentDetailsPage), findsNothing);
      expect(find.byType(DocumentEditPage), findsOneWidget);
    });

    testWidgets("Test document removal confirmation dialog", (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          onGenerateRoute: RoutesManager.generateRoute,
          home: DocumentDetailsPage(),
        ),
      );
      await widgetTester.tap(find.byIcon(Icons.delete_rounded));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ConfirmationDialog), findsOneWidget);
      expect(find.text("ELIMINAZIONE DOCUMENTO"), findsOneWidget);
    });
  });
}