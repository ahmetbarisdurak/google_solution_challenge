import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef Callback = void Function(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  const Camera(this.cameras, this.model, this.setRecognitions, {super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      // print('No camera is found');
    }
    else {
      controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            Tflite.detectObjectOnFrame(
              bytesList: img.planes.map((plane) => plane.bytes).toList(),
              model: "SSDMobileNet",
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: 127.5,
              imageStd: 127.5,
              numResultsPerClass: 1,
              threshold: 0.4,
            ).then((List<dynamic>? recognitions) {
              // Ensure recognitions is not null before proceeding
              if (recognitions != null) {
                // Algılama sonuçları üzerinden döngü yap
                for (var recognition in recognitions) {
                  // `label` objenin türünü temsil eder (örneğin: "bed", "chair")
                  String label = recognition["detectedClass"];

                  // Belirli objeler için kontrol yap
                  if (label == "bed" || label == "chair" || label == "book") {
                    setState(() {
                      
                    });
                    break; // Bir kez uyarı göstermek yeterli
                  }
                }

                widget.setRecognitions(recognitions, img.height, img.width);
              }
              isDetecting = false;
            }).catchError((error) {
              // Handle any errors here
              // print("Error detecting objects: $error");
              isDetecting = false;
            });
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    Size? tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;

    Size temp;
    double previewH = 0;
    double previewW = 0;
    double screenRatio = screenH / screenW;
    double previewRatio = 0;

    if(tmp != null) {
      temp = tmp;
      previewH = math.max(temp.height, temp.width);
      previewW = math.min(temp.height, temp.width);
      previewRatio = previewH / previewW;
    }

// Ensure we use these variables only when they have valid (non-null and non-zero) values
    if (previewH > 0 && previewW > 0) {
      return OverflowBox(
        maxHeight: screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
        maxWidth: screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
        child: CameraPreview(controller),
      );
    } else {
      return Container(); // or some placeholder indicating the camera preview is not available
    }
  }
}