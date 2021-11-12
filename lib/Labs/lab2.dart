import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import '../main.dart';

class Lab02 extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Lab02({Key? key, required this.cameras}) : super(key: key);

  @override
  _Lab02State createState() => _Lab02State();
}

class _Lab02State extends State<Lab02> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Picker(
        cameras: widget.cameras,
      ),
    );
  }
}

class Picker extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Picker({Key? key, required this.cameras}) : super(key: key);

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context) {
    return CameraPage(
      cameras: widget.cameras,
    );
  }
}

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPage({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  late File img = File('/sdcard/documents/example.jpg');
  


  @override
  void initState() {
    super.initState();
    controller =
        CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyApp.analytics
        .logEvent(name: 'flutter_labs_lab2_tab_was_opened', parameters: null);

    if (!controller.value.isInitialized) {
      return Container(
          child: const Center(
        child: Text(
          'Camera controller isn\'t initialized.',
          style: TextStyle(fontSize: 20),
        ),
      ));
    }
    return Center(
        child: Expanded(
      child: Column(
        children: <Widget>[
          Container(
            child: CameraPreview(controller),
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.9,
          ),
          Expanded(
              child: Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final params = SaveFileDialogParams(sourceFilePath: img.path);
                    final filePath = await FlutterFileDialog.saveFile(params: params);
                    print(filePath);
                  },
                  child: const Icon(
                    Icons.camera_alt,
                  )),
            ],
          ))
        ],
      ),
    ));
  }
}
