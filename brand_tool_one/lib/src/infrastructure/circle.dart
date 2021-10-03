// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

import 'dart:math';

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleShape extends Shape with BorderShape {
  final double borderWidth;
  final Color borderColor;

  final Paint borderPaint = Paint();

  CircleShape({
    this.borderWidth = 0,
    this.borderColor = Colors.white,
  }) {
    // ignore: unnecessary_this
    this.borderPaint.isAntiAlias = true;
    // ignore: unnecessary_this
    this.borderPaint.style = PaintingStyle.stroke;
  }

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(rect: rect as Rect);
  }

  Path generatePath({bool? useBezier, Rect? rect}) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(rect!.width / 2.0, rect.height / 2.0),
        radius: min(rect.width / 2.0, rect.height / 2.0),
      ));
  }

  @override
  void drawBorder(Canvas canvas, Rect rect) {
    // ignore: unnecessary_this
    if (this.borderWidth > 0) {
      // ignore: unnecessary_this
      borderPaint.color = this.borderColor;
      // ignore: unnecessary_this
      borderPaint.strokeWidth = this.borderWidth;
      canvas.drawCircle(
          rect.center,
          min((rect.width - borderWidth) / 2.0,
              (rect.height - borderWidth) / 2.0,),
          borderPaint,);
    }
  }
}
