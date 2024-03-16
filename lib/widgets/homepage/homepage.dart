import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/homepage/welcome-card.dart';
import 'package:provider/provider.dart';
import 'package:myidwallet_flutter/main.dart';

/// Definition of the homepage UI structure
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          WelcomeCard('Benvenuto nel tuo wallet!'),
          Text(appState.current.asLowerCase),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Aggiungi nuovo documento',
        onPressed: () => print('FloatingActionButton pressed'), /// To be changed as soon as the adding mechanism will be implemented
        child: const Icon(Icons.add, size: 18)
      ),
    );
  }
}