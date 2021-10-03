// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';

class TriangleShape extends Shape {
  final double percentBottom;
  final double percentLeft;
  final double percentRight;

  TriangleShape({
    this.percentBottom = 0.5,
    this.percentLeft = 0,
    this.percentRight = 0,
  });

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(rect: rect as Rect);
  }

  Path generatePath({bool? useBezier, Rect? rect}) {
    final width = rect!.width;
    final height = rect.height;
    
    return Path()
      ..moveTo(0, percentLeft * height)
      ..lineTo(percentBottom * width, height)
      ..lineTo(width, percentRight * height)
      ..close();
  }
}
