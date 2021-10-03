// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

import 'dart:math';

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart';

class RoundRectShape extends Shape with BorderShape {
  final BorderRadius borderRadius;

  final Color borderColor;
  final double borderWidth;

  final Paint borderPaint = Paint();

  RoundRectShape({
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.borderWidth = 0.0,
    this.borderColor = const Color(0xffffffff),
  }) {
    // ignore: unnecessary_this
    this.borderPaint.isAntiAlias = true;
    // ignore: unnecessary_this
    this.borderPaint.style = PaintingStyle.stroke;
  }

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(useBezier: false, rect: rect as Rect);
  }

  // ignore: long-method
  Path generatePath({bool? useBezier, Rect? rect}) {
    final Path path = Path();

    final double left = rect!.left;
    final double top = rect.top;
    final double bottom = rect.bottom;
    final double right = rect.right;

    final double maxSize = min(rect.width / 2.0, rect.height / 2.0);

    double topLeftRadius = borderRadius.topLeft.x.abs();
    double topRightRadius = borderRadius.topRight.x.abs();
    double bottomLeftRadius = borderRadius.bottomLeft.x.abs();
    double bottomRightRadius = borderRadius.bottomRight.x.abs();

    if (topLeftRadius > maxSize) {
      topLeftRadius = maxSize;
    }
    if (topRightRadius > maxSize) {
      topRightRadius = maxSize;
    }
    if (bottomLeftRadius > maxSize) {
      bottomLeftRadius = maxSize;
    }
    if (bottomRightRadius > maxSize) {
      bottomRightRadius = maxSize;
    }

    path.moveTo(left + topLeftRadius, top);
    path.lineTo(right - topRightRadius, top);

    //float left, float top, float right, float bottom, float startAngle, float sweepAngle, boolean forceMoveTo
    // ignore: cast_nullable_to_non_nullable
    if (useBezier as bool) {
      path.quadraticBezierTo(right, top, right, top + topRightRadius);
    } else {
      final double arc = topRightRadius > 0 ? 90 : -270;
      path.arcTo(
          Rect.fromLTRB(right - topRightRadius * 2.0, top, right,
              top + topRightRadius * 2.0,),
          radians(-90),
          radians(arc),
          false,);
    }
    path.lineTo(right, bottom - bottomRightRadius);
    if (useBezier) {
      path.quadraticBezierTo(right, bottom, right - bottomRightRadius, bottom);
    } else {
      final double arc = bottomRightRadius > 0 ? 90 : -270;
      path.arcTo(
          Rect.fromLTRB(right - bottomRightRadius * 2.0,
              bottom - bottomRightRadius * 2.0, right, bottom,),
          0,
          radians(arc),
          false,);
    }
    path.lineTo(left + bottomLeftRadius, bottom);
    if (useBezier) {
      path.quadraticBezierTo(left, bottom, left, bottom - bottomLeftRadius);
    } else {
      final double arc = bottomLeftRadius > 0 ? 90 : -270;
      path.arcTo(
          Rect.fromLTRB(left, bottom - bottomLeftRadius * 2.0,
              left + bottomLeftRadius * 2.0, bottom,),
          radians(90),
          radians(arc),
          false,);
    }
    path.lineTo(left, top + topLeftRadius);
    if (useBezier) {
      path.quadraticBezierTo(left, top, left + topLeftRadius, top);
    } else {
      final double arc = topLeftRadius > 0 ? 90 : -270;
      path.arcTo(
          Rect.fromLTRB(
              left, top, left + topLeftRadius * 2.0, top + topLeftRadius * 2.0,),
          radians(180),
          radians(arc),
          false,);
    }
    path.close();

    return path;
  }

  @override
  void drawBorder(Canvas canvas, Rect rect) {
    // ignore: unnecessary_this
    if (this.borderWidth > 0) {
      borderPaint.strokeWidth = borderWidth;
      borderPaint.color = borderColor;
      canvas.drawPath(generatePath(useBezier: false, rect: rect), borderPaint);
    }
  }
}
