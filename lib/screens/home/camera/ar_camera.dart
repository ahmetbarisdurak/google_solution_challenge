import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CameraPage extends StatefulWidget {
  final double rectangleWidth; // Dikdörtgenin genişliği
  final double rectangleHeight; // Dikdörtgenin yüksekliği

  // Constructor ekledik
  const CameraPage({super.key,
    required this.rectangleWidth,
    required this.rectangleHeight,
  });

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late ArCoreController arCoreController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Olamaz Ya'),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addRectangle(arCoreController);
  }

  void _addRectangle(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: const Color.fromARGB(120, 66, 134, 244),
    );
    final rectangle = ArCoreNode(
      shape: ArCoreCube(
        materials: [material],
        size: vector.Vector3(widget.rectangleWidth, 0.01, widget.rectangleHeight),
      ),
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(rectangle);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
