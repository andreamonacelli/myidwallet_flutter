import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/routes/doc_type_selection_page.dart';
import 'package:myidwallet_flutter/routes/homepage.dart';

class RoutesManager {
  static const String HOMEPAGE_ROUTE = "/";
  static const String DOCTYPESELECTIONPAGE_ROUTE = "/doctypeselection";

  RoutesManager._();

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case HOMEPAGE_ROUTE:
        return MaterialPageRoute(
            builder: (_) => const HomePage(),
        );
      case DOCTYPESELECTIONPAGE_ROUTE:
        return MaterialPageRoute(
          builder: (_) => const DocTypeSelectionPage(),
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