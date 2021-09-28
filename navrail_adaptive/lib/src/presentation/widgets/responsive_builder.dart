// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Modified from BreakPoint Scaffold

import 'package:flutter/widgets.dart';
import 'package:navrail_adaptive/src/presentation/widgets/layoutinfo.dart';

/// A function that returns a widget that depends on a [LayoutInfo].
///
/// Used by [ResponsiveBuilder].
typedef ResponsiveWidgetBuilder = Widget Function(
    BuildContext, LayoutInfo, Widget?);

/// Builds a widget tree according to a [LayoutInfo].
class ResponsiveBuilder extends StatelessWidget {
  /// An optional widget that doesn't depend on the layout info.
  ///
  /// Use this field to cache large portions of the widget tree so they don't
  /// rebuild every frame when a window resizes.
  final Widget? child;

  /// A function to build the widget tree.
  final ResponsiveWidgetBuilder builder;

  /// A builder to layout the widget tree based on the device size.
  const ResponsiveBuilder({Key? key, 
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      builder(context, LayoutInfo(context), child);
}
