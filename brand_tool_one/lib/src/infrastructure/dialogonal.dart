// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

// ignore_for_file: unnecessary_this

import 'dart:math';

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart';

enum DiagonalPosition { bottom, top, left, right }

enum DiagonalDirection { left, right }

class DiagonalAngle {
  final double angleRadians;

  const DiagonalAngle.radians({double angle = 0}) : angleRadians = angle;

  DiagonalAngle.deg({double angle = 0}) : this.radians(angle: radians(angle));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiagonalAngle &&
          runtimeType == other.runtimeType &&
          angleRadians == other.angleRadians;

  @override
  int get hashCode => angleRadians.hashCode;
}

class DiagonalShape extends Shape {
  final DiagonalPosition position;
  final DiagonalDirection direction;
  final DiagonalAngle angle;

  DiagonalShape({
    this.position = DiagonalPosition.bottom,
    this.direction = DiagonalDirection.left,
    this.angle = const DiagonalAngle.radians(angle: pi/ -20),
  });

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(rect: rect as Rect);
  }

  // ignore: long-method
  Path generatePath({Rect? rect}) {
    final Path path = Path();

    final width = rect!.width;
    final height = rect.height;

    final double diagonalAngleRadAbs = this.angle.angleRadians.abs();
    final bool isDirectionLeft = this.direction == DiagonalDirection.left;
    final double perpendicularHeight = rect.width * tan(diagonalAngleRadAbs);

    switch (this.position) {
      case DiagonalPosition.bottom:
        if (isDirectionLeft) {
          path.moveTo(0, 0);
          path.lineTo(width, 0);
          path.lineTo(width, height - perpendicularHeight);
          path.lineTo(0, height);
          path.close();
        } else {
          path.moveTo(width, height);
          path.lineTo(0, height - perpendicularHeight);
          path.lineTo(0, 0);
          path.lineTo(width, 0);
          path.close();
        }
        break;
      case DiagonalPosition.top:
        if (isDirectionLeft) {
          path.moveTo(width, height);
          path.lineTo(width, 0 + perpendicularHeight);
          path.lineTo(0, 0);
          path.lineTo(0, height);
          path.close();
        } else {
          path.moveTo(width, height);
          path.lineTo(width, 0);
          path.lineTo(0, 0 + perpendicularHeight);
          path.lineTo(0, height);
          path.close();
        }
        break;
      case DiagonalPosition.right:
        if (isDirectionLeft) {
          path.moveTo(0, 0);
          path.lineTo(width, 0);
          path.lineTo(width - perpendicularHeight, height);
          path.lineTo(0, height);
          path.close();
        } else {
          path.moveTo(0, 0);
          path.lineTo(width - perpendicularHeight, 0);
          path.lineTo(width, height);
          path.lineTo(0, height);
          path.close();
        }
        break;
      case DiagonalPosition.left:
        if (isDirectionLeft) {
          path.moveTo(0 + perpendicularHeight, 0);
          path.lineTo(width, 0);
          path.lineTo(width, height);
          path.lineTo(0, height);
          path.close();
        } else {
          path.moveTo(0, 0);
          path.lineTo(width, 0);
          path.lineTo(width, height);
          path.lineTo(0 + perpendicularHeight, height);
          path.close();
        }
        break;
    }
    
    return path;
  }
}
