// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

import 'dart:math';

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';

class PolygonShape extends Shape {
  final int numberOfSides;

  PolygonShape({this.numberOfSides = 5}) : assert(numberOfSides >= 3);

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(rect: rect as Rect);
  }

  Path generatePath({bool? useBezier, Rect? rect}) {
    final height = rect!.height;
    final width = rect.width;

    final double section = 2.0 * pi / numberOfSides;
    final double polygonSize = min(width, height);
    final double radius = polygonSize / 2;
    final double centerX = width / 2;
    final double centerY = height / 2;

    final Path polygonPath = Path();
    polygonPath.moveTo(
        centerX + radius * cos(0), centerY + radius * sin(0),);

    for (int i = 1; i < numberOfSides; i++) {
      polygonPath.lineTo(centerX + radius * cos(section * i),
          centerY + radius * sin(section * i),);
    }

    polygonPath.close();
    
    return polygonPath;
  }
}
