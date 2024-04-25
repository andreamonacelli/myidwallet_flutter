import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/camera_controller/check_image_page.dart';
import 'package:myidwallet_flutter/widgets/header_text_card.dart';

class DocumentCapturePage extends StatefulWidget{

  final CameraDescription camera;

  DocumentCapturePage({
    super.key,
    required this.camera,
  });

  @override
  DocumentCapturePageState createState() => DocumentCapturePageState();
}

class DocumentCapturePageState extends State<DocumentCapturePage> {

  late CameraController _cameraController;
  late Future<void> _initializeCameraControllerFuture;

  @override
  void initState(){
    super.initState();
    _cameraController = CameraController(
        widget.camera,
        ResolutionPreset.max
    );
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose(){
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return Stack(
              children: [
                CameraPreview(_cameraController),
                HeaderTextCard("Scansiona il documento:", Colors.cyan, Colors.white70)
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try{
            await _initializeCameraControllerFuture;
            final image = await _cameraController.takePicture();
            if(!context.mounted) return;
            await Navigator.of(context).push(
              ///As soon as the picture is taken, the user will be sent to an intermediate page that will handle the data processing
              MaterialPageRoute(
                  builder: (context) => CheckImagePage(image.path),
              )
            );
          } catch(exception){
            print(exception);
          }
        },
        backgroundColor: Colors.cyan,
        child: const Icon(
            Icons.camera_alt,
            color: Colors.white70,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  
}