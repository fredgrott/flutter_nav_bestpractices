// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

import 'dart:math';

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';

class CutCornerShape extends Shape {
  final BorderRadius borderRadius;

  CutCornerShape({required this.borderRadius});

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(rect: rect as Rect);
  }

  Path generatePath({Rect? rect}) {
    final topLeftDiameter = max(borderRadius.topLeft.x, 0);
    final topRightDiameter = max(borderRadius.topRight.x, 0);
    final bottomLeftDiameter = max(borderRadius.bottomLeft.x, 0);
    final bottomRightDiameter = max(borderRadius.bottomRight.x, 0);

    return Path()
      ..moveTo(rect!.left + topLeftDiameter, rect.top)
      ..lineTo(rect.right - topRightDiameter, rect.top)
      ..lineTo(rect.right, rect.top + topRightDiameter)
      ..lineTo(rect.right, rect.bottom - bottomRightDiameter)
      ..lineTo(rect.right - bottomRightDiameter, rect.bottom)
      ..lineTo(rect.left + bottomLeftDiameter, rect.bottom)
      ..lineTo(rect.left, rect.bottom - bottomLeftDiameter)
      ..lineTo(rect.left, rect.top + topLeftDiameter)
      ..lineTo(rect.left + topLeftDiameter, rect.top)
      ..close();
  }
}
