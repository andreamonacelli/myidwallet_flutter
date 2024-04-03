import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myidwallet_flutter/widgets/camera_controller/check_image_page.dart';

class CaptureDocumentImage extends StatefulWidget{

  final CameraDescription camera;

  CaptureDocumentImage({
    super.key,
    required this.camera,
  });

  @override
  CaptureDocumentImageState createState() => CaptureDocumentImageState();
}

class CaptureDocumentImageState extends State<CaptureDocumentImage> {

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
      appBar: AppBar(title: const Text("Scansiona il documento:")),
      body: FutureBuilder<void>(
        future: _initializeCameraControllerFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return CameraPreview(_cameraController);
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
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
  
}