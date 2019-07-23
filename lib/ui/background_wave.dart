import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class BackgroundWave extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
        durations: [19440, 10800, 6000],
        heightPercentages: [0.03, 0.01, 0.02],
        gradientBegin: Alignment.bottomCenter,
        gradientEnd: Alignment.topCenter,
        gradients: [
          [
            Color.fromRGBO(202, 74, 126, 1),
            Color.fromRGBO(225, 170, 206, 1),
            Color.fromRGBO(21, 90, 245, 0.7)
          ],
          [
            Color.fromRGBO(120, 174, 126, 21),
            Color.fromRGBO(220, 58, 10, 1),
            Color.fromRGBO(202, 12, 219, 0.7)
          ],
          [
            Color.fromRGBO(202, 140, 140, 50),
            Color.fromRGBO(205, 00, 206, 1),
            Color.fromRGBO(102, 28, 246, 0.7)
          ],
        ]
      ),
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 25,

    );
  }
}
