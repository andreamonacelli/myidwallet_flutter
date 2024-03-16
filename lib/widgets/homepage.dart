import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/welcome-card.dart';
import 'package:provider/provider.dart';
import 'package:myidwallet_flutter/main.dart';

/// Definition of the homepage UI structure
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      ///Here we define the "welcome" section for the home page
      body: Column(
        children: [
          WelcomeCard(),
          Text(appState.current.asLowerCase),
        ],
      ),
    );
  }
}