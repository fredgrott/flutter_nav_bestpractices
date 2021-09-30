// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Modified from wave drawer original under MIT license
// by Calamity210 Copyright 2020.

import 'package:flutter/widgets.dart';

class WavePathPainter extends CustomPainter {
  final Color _boundaryColor;
  final double _boundaryWidth;

  const WavePathPainter(this._boundaryColor, this._boundaryWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..color = _boundaryColor;

    final path = Path();
    final halfBoundaryWidth = _boundaryWidth / 2;

    path.moveTo(size.width - (60 - halfBoundaryWidth), 0.0);

    final firstControlPoint = Offset(size.width, size.height / 4);
    final firstEndPoint =
        Offset(size.width - (50 - halfBoundaryWidth), size.height / 2.25);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy,);

    final secondControlPoint = Offset(size.width - (110 - halfBoundaryWidth),
        size.height - (size.height / 3.25),);
    final secondEndPoint =
        Offset(size.width - (70 - halfBoundaryWidth), size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy,);

    path.moveTo(0.0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
