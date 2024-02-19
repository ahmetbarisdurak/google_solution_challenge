import 'dart:math' as math;
import 'package:tflite_flutter/tflite_flutter.dart';

import 'building_info.dart';

class PredictionService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/building_damage_model.tflite');
  }

  Future<int> predict(BuildingInfo buildingInfo) async {
    // Modelinizin giriş tensorunun şekline ve tipine bağlı olarak uygun giriş verisi hazırlayın
    var input = buildingInfo.toInputArray(); // Bu metod, BuildingInfo'dan giriş dizisine dönüşümü gerçekleştirmeli
    var output = List.filled(1 * 5, 0).reshape([1, 5]); // Çıkış boyutunuza göre ayarlayın

    _interpreter.run(input, output);
    print("output is ");
    print(output);
    // En yüksek tahmini indeksini bul
    //   // reduce ve max kullanımını tip belirterek düzeltme
    final predictionIndex = output[0].indexOf(output[0].reduce((a, b) => math.max<double>(a, b)));
    return predictionIndex; // En yüksek tahminin indeksini döndürme
  }
}