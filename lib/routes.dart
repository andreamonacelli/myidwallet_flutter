import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/main.dart';
import 'package:myidwallet_flutter/routes/document_capture_page.dart';
import 'package:myidwallet_flutter/routes/doc_type_selection_page.dart';
import 'package:myidwallet_flutter/routes/homepage.dart';
import 'package:myidwallet_flutter/widgets/camera_controller/check_image_page.dart';

class RoutesManager {
  static const String homepageRoute = "/";
  static const String docTypeSelectionPageRoute = "/doctypeselection";
  static const String cameraScreenRoute = "/docscanner";
  static late String databaseOperation;

  RoutesManager._();

  ///TODO: Edit the method in order to ensure that it waits for the respective database operation
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
      default:
        throw FormatException("Route not found!");
    }
  }
}

class RouteException implements Exception{
  final String message;
  const RouteException(this.message);
}