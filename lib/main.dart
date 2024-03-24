import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myidwallet_flutter/widgets/homepage/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), /* App-wide state defined in the specified class */
      child: MaterialApp( /* Setup of the whole application */
        title: 'My ID Wallet',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        home: HomePage(), /* Defined the widget that will actually hold the homepage */
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}