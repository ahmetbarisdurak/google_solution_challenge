import 'package:tflite_flutter/tflite_flutter.dart';

class ModelService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('building_damage_model.tflite');
  }

  Future<dynamic> predict(dynamic input) async {
    var output = List.filled(1 * 2, 0).reshape([1, 2]);  // Output şeklini modele göre ayarlayın
    _interpreter.run(input, output);
    return output;
  }
}