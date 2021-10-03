// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class Shape {
  Path build({Rect rect, double scale});
}

abstract class BorderShape {
  void drawBorder(Canvas canvas, Rect rect);
}

class ShapeOfViewBorder extends ShapeBorder {
  final Shape shape;

  // ignore: unnecessary_null_comparison
  const ShapeOfViewBorder({required this.shape}) : assert(shape != null);

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.all(0);
  }

  @override
  ShapeBorder scale(double t) => this;

  /*
  @override
  ShapeBorder lerpFrom(ShapeBorder a, double t) {
    if (a is CircleBorder)
      return CircleBorder(side: BorderSide.lerp(a.side, side, t));
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder lerpTo(ShapeBorder b, double t) {
    if (b is CircleBorder)
      return CircleBorder(side: BorderSide.lerp(side, b.side, t));
    return super.lerpTo(b, t);
  }
  */

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return shape.build(rect: rect, scale: 1);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return shape.build(rect: rect, scale: 1);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (shape is BorderShape) {
      (shape as BorderShape).drawBorder(canvas, rect);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShapeOfViewBorder &&
      other.shape == shape;
  }

  @override
  int get hashCode => shape.hashCode;

  @override
  String toString() {
    // ignore: no_runtimetype_tostring
    return '$runtimeType($shape)';
  }
}

class ShapeOfView extends StatelessWidget {
  final Widget child;
  final Shape shape;
  final double elevation;
  final Clip clipBehavior;
  final double height;
  final double width;

  const ShapeOfView({
    Key? key,
    required this.child,
    this.elevation = 4,
    required this.shape,
    this.clipBehavior = Clip.antiAlias,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // ignore: unnecessary_this
      shape: ShapeOfViewBorder(shape: this.shape),
      // ignore: unnecessary_this
      clipBehavior: this.clipBehavior,
      // ignore: unnecessary_this
      elevation: this.elevation,
      child: SizedBox(
        // ignore: unnecessary_this
        height: this.height,
        // ignore: unnecessary_this
        width: this.width,
        // ignore: unnecessary_this
        child: this.child,
      ),
    );
  }
}
