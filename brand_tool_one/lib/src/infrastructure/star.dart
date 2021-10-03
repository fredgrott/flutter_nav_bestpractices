// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

import 'dart:math';

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';

class StarShape extends Shape {
  final int noOfPoints;

  StarShape({required this.noOfPoints}) : assert(noOfPoints > 3);

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(rect: rect as Rect);
  }

  Path generatePath({bool? useBezier, Rect? rect}) {
    final height = rect!.height;
    final width = rect.width;

    final int vertices = noOfPoints * 2;
    final double alpha = (2 * pi) / vertices;
    final double radius = (height <= width ? height : width) / 2.0;
    final double centerX = width / 2;
    final double centerY = height / 2;

    final Path path = Path();
    for (int i = vertices + 1; i != 0; i--) {
      final double r = radius * (i % 2 + 1) / 2;
      final double omega = alpha * i;
      path.lineTo((r * sin(omega)) + centerX, (r * cos(omega)) + centerY);
    }
    path.close();
    
    return path;
  }
}
