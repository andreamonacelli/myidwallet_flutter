import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/homepage/documents_grid.dart';
import 'package:myidwallet_flutter/widgets/homepage/header_text_card.dart';

/// Definition of the homepage UI structure
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
            children: [
              HeaderTextCard("Benvenuto nel tuo wallet!"),
              DocumentsGrid(),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Aggiungi nuovo documento',
        shape: CircleBorder(),
        backgroundColor: Colors.cyan,
        onPressed: () => print('FloatingActionButton pressed'), /// To be changed as soon as the adding mechanism will be implemented
        child: const Icon(Icons.add, size: 35, color: Colors.white70)
      ),
    );
  }
}