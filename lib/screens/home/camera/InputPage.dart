import 'package:flutter/material.dart';
import 'ar_camera.dart';

class InputPage extends StatelessWidget {
  final boyController = TextEditingController(); // boy denetleyicisi
  final kiloController = TextEditingController(); // kilo denetleyicisi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boy ve Kilo Bilgisi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: boyController, // boy denetleyicisi eklendi
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Boy (cm)',
              ),
            ),
            TextField(
              controller: kiloController, // kilo denetleyicisi eklendi
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Kilo (kg)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Boyutları al ve CameraPage'e yönlendir
                double boy = double.parse(boyController.text);
                double kilo = double.parse(kiloController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(
                      rectangleWidth: boy * 0.01, // cm'yi metreye dönüştürmek için
                      rectangleHeight: kilo * 0.01, // cm'yi metreye dönüştürmek için
                    ),
                  ),
                );
              },
              child: const Text('Devam'),
            ),
          ],
        ),
      ),
    );
  }
}
