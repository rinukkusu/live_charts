class RgbColor {
  final int r;
  final int g;
  final int b;
  final num a;

  const RgbColor(this.r, this.g, this.b, [this.a = 1]);

  static final RgbColor BLACK = const RgbColor(0, 0, 0);
  static final RgbColor WHITE = const RgbColor(255, 255, 255);
}