// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Copyright 2019 Florent Champigny (florent37) under Apache 2 License
// Modified to make null-safe

import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/widgets.dart';

typedef ShapeBuilder = Path Function(Rect rect);

class CustomShape extends Shape {
  final ShapeBuilder builder;

  CustomShape({
    required this.builder,
  });

  @override
  Path build({Rect? rect, double? scale}) {
    // ignore: cast_nullable_to_non_nullable
    return generatePath(rect: rect as Rect);
  }

  Path generatePath({Rect? rect}) {
    // ignore: unnecessary_this, cast_nullable_to_non_nullable
    return this.builder(rect as Rect);
  }
}
