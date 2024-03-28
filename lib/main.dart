import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:provider/provider.dart';
import 'package:myidwallet_flutter/routes/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'My ID Wallet',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        initialRoute: RoutesManager.HOMEPAGE_ROUTE,
        onGenerateRoute: RoutesManager.generateRoute,
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}