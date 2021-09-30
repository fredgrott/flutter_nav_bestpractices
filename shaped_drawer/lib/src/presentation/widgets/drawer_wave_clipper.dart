// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';

class DrawerWaveClipper extends CustomClipper<Path> {
  final double _boundaryWidth;

  const DrawerWaveClipper(this._boundaryWidth);
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width - 60, 0.0);

    final firstControlPoint =
        Offset(size.width - (_boundaryWidth / 2), size.height / 4);
    final firstEndPoint = Offset(size.width - 50.0, size.height / 2.25);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy,);

    final secondControlPoint =
        Offset(size.width - 110, size.height - (size.height / 3.25));
    final secondEndPoint = Offset(size.width - 70, size.height);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy,);

    path.lineTo(size.width - 40, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
