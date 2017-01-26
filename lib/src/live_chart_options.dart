import 'rgbcolor.dart';

class LiveChartOptions {
  String elementId;
  num stepsPerSecond;
  num stepWidth;
  num minValue;
  num maxValue;
  RgbColor colorBackground;
  RgbColor colorForeground;
  num lineWidth;

  LiveChartOptions(this.elementId,
      {this.stepsPerSecond: 30,
      this.stepWidth: 1,
      this.minValue: 0,
      this.maxValue: 100,
      this.colorBackground: null,
      this.colorForeground: const RgbColor(0, 0, 0),
      this.lineWidth: 2});
}