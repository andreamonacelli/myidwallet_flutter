import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/main.dart';
import 'package:myidwallet_flutter/routes/document_capture_page.dart';
import 'package:myidwallet_flutter/routes/doc_type_selection_page.dart';
import 'package:myidwallet_flutter/routes/document_details_page.dart';
import 'package:myidwallet_flutter/routes/homepage.dart';

class RoutesManager {
  static const String homepageRoute = "/";
  static const String docTypeSelectionPageRoute = "/doctypeselection";
  static const String cameraScreenRoute = "/docscanner";
  static const String documentDetailsRoute = "/docdetails";
  static late String databaseOperation;

  RoutesManager._();

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case homepageRoute:
        return MaterialPageRoute(
            builder: (_) => const HomePage(),
        );
      case docTypeSelectionPageRoute:
        return MaterialPageRoute(
          builder: (_) => const DocTypeSelectionPage(),
        );
      case cameraScreenRoute:
        return MaterialPageRoute(
            builder: (_) => DocumentCapturePage(camera: MyIDWalletAppState.selectedCamera),
        );
      case documentDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => const DocumentDetailsPage(),
        );
      default:
        throw FormatException("Route not found!");
    }
  }
}

class RouteException implements Exception{
  final String message;
  const RouteException(this.message);
}