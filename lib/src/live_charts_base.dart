// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'live_chart_options.dart';

/// Chart for a live data feed
class LiveChart {
  final LiveChartOptions _options;
  final Element _parent;
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  Timer _renderTimer;

  num _lastValue = 0;
  num _currentValue = 0;

  LiveChart(LiveChartOptions options)
      : _options = options,
        _parent = querySelector("#${options.elementId}") {
    _canvas = new CanvasElement(
        width: _parent.clientWidth, height: _parent.clientHeight);

    _parent.append(_canvas);

    _ctx = _canvas.getContext('2d');
    _ctx.imageSmoothingEnabled = false;
    _ctx.lineWidth = _options.lineWidth;

    if (_options.colorBackground != null) {
      _ctx.setFillColorRgb(
          _options.colorBackground.r,
          _options.colorBackground.g,
          _options.colorBackground.b,
          _options.colorBackground.a);

      _ctx.fillRect(0, 0, _canvas.width, _canvas.height);
    }

    if (_options.colorForeground != null)
      _ctx.setStrokeColorRgb(
          _options.colorForeground.r,
          _options.colorForeground.g,
          _options.colorForeground.b,
          _options.colorForeground.a);
  }

  void _drawLine(num fromY, num toY) {
    if (_options.colorBackground != null)
      _ctx.fillRect(
          _canvas.width - _options.stepWidth, 0, _canvas.width, _canvas.height);

    _ctx.beginPath();
    _ctx.moveTo(_canvas.width - _options.stepWidth, _translateValue(fromY));
    _ctx.lineTo(_canvas.width, _translateValue(toY));
    _ctx.stroke();
  }

  void _advanceCanvas() {
    var data = _ctx.getImageData(0, 0, _canvas.width, _canvas.height);
    _ctx.clearRect(0, 0, _canvas.width, _canvas.height);
    _ctx.putImageData(data, -_options.stepWidth, 0);
    data = null;
  }

  void start() {
    _renderTimer = new Timer.periodic(
        new Duration(milliseconds: 1000 ~/ _options.stepsPerSecond), (t) {
      _drawLine(_lastValue, _currentValue);
      _lastValue = _currentValue;

      _advanceCanvas();
    });
  }

  void stop() {
    _renderTimer.cancel();
  }

  void dispose() {
    stop();

    _canvas.remove();

    _ctx = null;
    _canvas = null;
    _renderTimer = null;
  }

  void addValue(num value) {
    _lastValue = _currentValue;

    if (value > _options.maxValue)
      _currentValue = _options.maxValue;
    else if (value < _options.minValue)
      _currentValue = _options.minValue;
    else
      _currentValue = value;
  }

  int _translateValue(num value) {
    return _canvas.height -
        (value / _options.maxValue * _canvas.height).toInt();
  }
}
