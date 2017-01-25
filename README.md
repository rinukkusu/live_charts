# live_charts [![Pub](https://img.shields.io/pub/v/live_charts.svg)](https://pub.dartlang.org/packages/live_charts)

A library for creating live charts.

## Usage

A simple usage example:

```dart
import 'dart:math';
import 'package:live_charts/live_charts.dart';

main() {
  // create new options with the id of the parent element tag
  var chartOptions = new LiveChartOptions("wrapper");

  // create new chart
  var chart = new LiveChart(options);

  // start drawing the chart
  chart.start();

  // feed data to it
  var rng = new Random();
  new Timer.periodic(new Duration(milliseconds: 100), (_) {
    chart.addValue(rng.nextInt(100));
  });
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/rinukkusu/live_charts/issues
