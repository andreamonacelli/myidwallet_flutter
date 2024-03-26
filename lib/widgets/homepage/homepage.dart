import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/homepage/documents_grid.dart';
import 'package:myidwallet_flutter/widgets/homepage/header_text_card.dart';

/// Definition of the homepage UI structure
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homepage_bg.png"),
            fit: BoxFit.fill,
          )
        ),
        child: Column(
          children: [
            HeaderTextCard("Benvenuto nel tuo wallet!"),
            DocumentsGrid(),
          ],
        ),
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