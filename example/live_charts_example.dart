// Copyright (c) 2017, rinukkusu. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';
import 'dart:async';
import 'package:live_charts/live_charts.dart';

main() {
  // create new options with the id of the parent element tag
  var chartOptions = new LiveChartOptions("wrapper");

  // create new chart
  var chart = new LiveChart(chartOptions);

  // start drawing the chart
  chart.start();

  // feed data to it
  var rng = new Random();
  new Timer.periodic(new Duration(milliseconds: 100), (_) {
    chart.addValue(rng.nextInt(100));
  });
}