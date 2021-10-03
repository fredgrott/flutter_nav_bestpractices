// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

// ignore_for_file: cast_nullable_to_non_nullable

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';

enum ArcPosition { bottom, top, left, right }
enum ArcDirection { outside, inside }

class ArcShape extends Shape {
  final ArcPosition position;
  final double height;
  final ArcDirection direction;

  ArcShape({
    this.position = ArcPosition.bottom,
    this.direction = ArcDirection.outside,
    this.height = 10,
  });

  @override
  Path build({Rect? rect, double? scale}) {
    return generatePath(rect as Rect, scale as double);
  }

  // ignore: long-method
  Path generatePath(Rect rect, double scale) {
    final size = rect.size;
    // ignore: unnecessary_this
    switch (this.position) {
      case ArcPosition.top:
        // ignore: prefer-conditional-expressions
        if (direction == ArcDirection.outside) {
          return Path()
            ..moveTo(0.0, height)
            ..quadraticBezierTo(size.width / 4, 0.0, size.width / 2, 0.0)
            ..quadraticBezierTo(size.width * 3 / 4, 0.0, size.width, height)
            ..lineTo(size.width, size.height)
            ..lineTo(0.0, size.height)
            ..close();
        } else {
          return Path()
            ..quadraticBezierTo(size.width / 4, height, size.width / 2, height)
            ..quadraticBezierTo(size.width * 3 / 4, height, size.width, 0.0)
            ..lineTo(size.width, size.height)
            ..lineTo(0.0, size.height)
            ..close();
        }
        
      case ArcPosition.bottom:
        // ignore: prefer-conditional-expressions
        if (direction == ArcDirection.outside) {
          return Path()
            ..lineTo(0.0, size.height - height)
            ..quadraticBezierTo(
                size.width / 4, size.height, size.width / 2, size.height,)
            ..quadraticBezierTo(size.width * 3 / 4, size.height, size.width,
                size.height - height,)
            ..lineTo(size.width, 0.0)
            ..close();
        } else {
          return Path()
            ..moveTo(0.0, size.height)
            ..quadraticBezierTo(size.width / 4, size.height - height,
                size.width / 2, size.height - height,)
            ..quadraticBezierTo(size.width * 3 / 4, size.height - height,
                size.width, size.height,)
            ..lineTo(size.width, 0.0)
            ..lineTo(0.0, 0.0)
            ..close();
        }
        
      case ArcPosition.left:
        // ignore: prefer-conditional-expressions
        if (direction == ArcDirection.outside) {
          return Path()
            ..moveTo(height, 0.0)
            ..quadraticBezierTo(0.0, size.height / 4, 0.0, size.height / 2)
            ..quadraticBezierTo(0.0, size.height * 3 / 4, height, size.height)
            ..lineTo(size.width, size.height)
            ..lineTo(size.width, 0.0)
            ..close();
        } else {
          return Path()
            ..quadraticBezierTo(
                height, size.height / 4, height, size.height / 2,)
            ..quadraticBezierTo(height, size.height * 3 / 4, 0.0, size.height)
            ..lineTo(size.width, size.height)
            ..lineTo(size.width, 0.0)
            ..close();
        }
        
      default: //right
        // ignore: prefer-conditional-expressions
        if (direction == ArcDirection.outside) {
          return Path()
            ..moveTo(size.width - height, 0.0)
            ..quadraticBezierTo(
                size.width, size.height / 4, size.width, size.height / 2,)
            ..quadraticBezierTo(size.width, size.height * 3 / 4,
                size.width - height, size.height,)
            ..lineTo(0.0, size.height)
            ..lineTo(0.0, 0.0)
            ..close();
        } else {
          return Path()
            ..moveTo(size.width, 0.0)
            ..quadraticBezierTo(size.width - height, size.height / 4,
                size.width - height, size.height / 2,)
            ..quadraticBezierTo(size.width - height, size.height * 3 / 4,
                size.width, size.height,)
            ..lineTo(0.0, size.height)
            ..lineTo(0.0, 0.0)
            ..close();
        }
        
    }
  }
}
