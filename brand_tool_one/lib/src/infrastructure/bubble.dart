// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

import 'dart:math';

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';

enum BubblePosition { bottom, top, left, right }

class BubbleShape extends Shape {
  final BubblePosition position;

  final double borderRadius;
  final double arrowHeight;
  final double arrowWidth;

  final double arrowPositionPercent;

  BubbleShape(
      {this.position = BubblePosition.bottom,
      this.borderRadius = 12,
      this.arrowHeight = 10,
      this.arrowWidth = 10,
      this.arrowPositionPercent = 0.5,});

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(rect: rect as Rect);
  }

  // ignore: long-method
  Path generatePath({Rect? rect}) {
    final Path path = Path();

    final double topLeftDiameter = max(borderRadius, 0);
    final double topRightDiameter = max(borderRadius, 0);
    final double bottomLeftDiameter = max(borderRadius, 0);
    final double bottomRightDiameter = max(borderRadius, 0);

    final double spacingLeft =
        position == BubblePosition.left ? arrowHeight : 0;
    final double spacingTop =
        position == BubblePosition.top ? arrowHeight : 0;
    final double spacingRight =
        position == BubblePosition.right ? arrowHeight : 0;
    final double spacingBottom =
        position == BubblePosition.bottom ? arrowHeight : 0;

    final double left = spacingLeft + rect!.left;
    final double top = spacingTop + rect.top;
    final double right = rect.right - spacingRight;
    final double bottom = rect.bottom - spacingBottom;

    final double centerX = (rect.left + rect.right) * arrowPositionPercent;

    path.moveTo(left + topLeftDiameter / 2.0, top);
    //LEFT, TOP

    if (position == BubblePosition.top) {
      path.lineTo(centerX - arrowWidth, top);
      path.lineTo(centerX, rect.top);
      path.lineTo(centerX + arrowWidth, top);
    }
    path.lineTo(right - topRightDiameter / 2.0, top);

    path.quadraticBezierTo(right, top, right, top + topRightDiameter / 2);
    //RIGHT, TOP

    if (position == BubblePosition.right) {
      path.lineTo(
          right, bottom - (bottom * (1 - arrowPositionPercent)) - arrowWidth,);
      path.lineTo(rect.right, bottom - (bottom * (1 - arrowPositionPercent)));
      path.lineTo(
          right, bottom - (bottom * (1 - arrowPositionPercent)) + arrowWidth,);
    }
    path.lineTo(right, bottom - bottomRightDiameter / 2);

    path.quadraticBezierTo(
        right, bottom, right - bottomRightDiameter / 2, bottom,);
    //RIGHT, BOTTOM

    if (position == BubblePosition.bottom) {
      path.lineTo(centerX + arrowWidth, bottom);
      path.lineTo(centerX, rect.bottom);
      path.lineTo(centerX - arrowWidth, bottom);
    }
    path.lineTo(left + bottomLeftDiameter / 2, bottom);

    path.quadraticBezierTo(left, bottom, left, bottom - bottomLeftDiameter / 2);
    //LEFT, BOTTOM

    if (position == BubblePosition.left) {
      path.lineTo(
          left, bottom - (bottom * (1 - arrowPositionPercent)) + arrowWidth,);
      path.lineTo(rect.left, bottom - (bottom * (1 - arrowPositionPercent)));
      path.lineTo(
          left, bottom - (bottom * (1 - arrowPositionPercent)) - arrowWidth,);
    }
    path.lineTo(left, top + topLeftDiameter / 2);

    path.quadraticBezierTo(left, top, left + topLeftDiameter / 2, top);

    path.close();

    return path;
  }
}
