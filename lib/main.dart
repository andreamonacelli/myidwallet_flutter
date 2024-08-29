import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/models/dbmanager/dbmanager.dart';
import 'package:myidwallet_flutter/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await initializeApplication();
  ///Run the application once all the setup operations are completed
  runApp(MyIDWalletApp());
}

class MyIDWalletApp extends StatelessWidget {
  const MyIDWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return ChangeNotifierProvider(
      create: (context) => MyIDWalletAppState(),
      child: MaterialApp(
        title: 'My ID Wallet',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        initialRoute: RoutesManager.homepageRoute,
        onGenerateRoute: RoutesManager.generateRoute,
      ),
    );
  }

}

class MyIDWalletAppState extends ChangeNotifier {
  static late final CameraDescription selectedCamera;
}

Future<void> initializeApplication() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  MyIDWalletAppState.selectedCamera = cameras.first;
  await DBManager.initializeDatabase();
}