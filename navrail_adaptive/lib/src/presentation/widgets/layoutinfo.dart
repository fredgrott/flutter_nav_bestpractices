// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Modified from BreakPoint Scaffold

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/widgets.dart';

/// Provides info about how this scaffold should be laid out.
///
/// Uses [getWindowType] from Material's `adaptive_breakpoints` package to
/// determine which layout should be built and exposes getters such as
/// [hasNavRail] to define how the layout should look.
@immutable
class LayoutInfo {
  /// The breakpoint as defined by [material.io](https://material.io/design/layout/responsive-layout-grid.html#breakpoints)
  final AdaptiveWindowType windowType;

  /// Stores info about the layout based on Material Design breakpoints.
  LayoutInfo(BuildContext context) : windowType = getWindowType(context);

  /// Whether the app is running on a phone.
  bool get isMobile => windowType == AdaptiveWindowType.xsmall;

  /// Whether the app is running on a tablet in portrait mode (or a large phone).
  bool get isTabletPortrait => windowType == AdaptiveWindowType.small;

  /// Whether the app is running on a tablet in landscape mode.
  bool get isTabletLandscape => windowType == AdaptiveWindowType.medium;

  /// Whether the app is running on a desktop.
  bool get isDesktop =>
      windowType == AdaptiveWindowType.large ||
      windowType == AdaptiveWindowType.xlarge;

  /// Whether the app should use a [BottomNavigationBar].
  bool get hasBottomNavBar => isMobile;

  /// Whether the app should use a [NavigationRail].
  bool get hasNavRail => isTabletPortrait || isTabletLandscape;

  /// Whether the app should have a persistent [Scaffold.endDrawer].
  bool get hasStandardSideSheet => isTabletLandscape || isDesktop;

  /// Whether the app should have a persistent [Drawer].
  bool get hasStandardDrawer => isDesktop;
}
