// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Modified from BreakPoint Scaffold

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navrail_adaptive/src/presentation/widgets/layoutinfo.dart';
import 'package:navrail_adaptive/src/presentation/widgets/navigationitem.dart';
import 'package:navrail_adaptive/src/presentation/widgets/responsive_builder.dart';

/// A Scaffold that rearranges itself according to the device size.
///
/// Uses [LayoutInfo] to decide key elements of the layout. This class has
/// two uses: with and without primary navigation items. These are items that
/// would normally be placed in a [BottomNavigationBar]. When primary navigation
/// items are provided, two different drawers are used: with and without the
/// primary navigation items (to avoid duplication in the UI).
///
/// See the package documentation for how the layout is determined.
class ResponsiveScaffold extends StatelessWidget {
  /// The app bar.
  ///
  /// This does not change with the layout, except for showing a drawer menu.
  final PreferredSizeWidget appBar;

  /// The main body of the scaffold.
  final Widget body;

  /// The full drawer to show.
  ///
  /// When there are primary navigation items, it is recommended not to include
  /// them in the drawer, as that may confuse your users. Instead, provide two
  /// drawers, one with them and the other, without.
  ///
  /// This field should include all navigation items, whereas [secondaryDrawer]
  /// should exclude all navigation items that are in [navItems].
  final Widget drawer;

  /// The secondary, more compact, navigation drawer.
  ///
  /// When there are primary navigation items, it is recommended not to include
  /// them in the drawer, as that may confuse your users. Instead, provide two
  /// drawers, one with them and the other, without.
  ///
  /// This field should exclude all navigation items that are in [navItems],
  /// whereas [drawer] should include them.
  final Widget? secondaryDrawer;

  /// The [side sheet](https://material.io/components/sheets-side).
  ///
  /// On larger screens (tablets and desktops), this will be a standard
  /// (persistent) side sheet. On smaller screens, this will be modal.
  ///
  /// See [LayoutInfo.hasStandardSideSheet].
  final Widget? sideSheet;

  /// The [Floating Action Button](https://material.io/components/buttons-floating-action-button).
  ///
  /// Currently, the position does not change based on layout.
  final Widget? floatingActionButton;

  /// The location of the floating action button.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// The navigation items.
  ///
  /// On phones, these will be in a [BottomNavigationBar]. On tablets, these
  /// will be in a [NavigationRail]. On desktops, these should be included in
  /// [drawer] instead.
  ///
  /// On phones and tablets, so that the items do not appear twice, provide a
  /// [secondaryDrawer] that does not include these items.
  final List<NavigationItem>? navItems;

  /// The index of the current navigation item in [navItems].
  final int? navIndex;

  /// A callback for when the user selects a navigation item.
  final ValueChanged<int>? onNavIndexChanged;

  /// Creates a scaffold that responds to the screen size.
  const ResponsiveScaffold({Key? key, 
    required this.drawer,
    required this.body,
    required this.appBar,
    this.floatingActionButton,
    this.sideSheet,
    this.floatingActionButtonLocation,
  })  : secondaryDrawer = null,
        navItems = null,
        navIndex = null,
        onNavIndexChanged = null, super(key: key);

  /// Creates a responsive layout with primary navigation items.
  const ResponsiveScaffold.navBar({Key? key, 
    required this.drawer,
    required this.secondaryDrawer,
    required this.appBar,
    required this.body,
    required this.navItems,
    required this.navIndex,
    required this.onNavIndexChanged,
    this.sideSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  }) : super(key: key);

  /// Whether this widget is being used with a navigation bar.
  bool get hasNavBar => navItems != null;

  @override
  Widget build(BuildContext context) => ResponsiveBuilder(
        child: body, // ignore: sort_child_properties_last
        builder: (BuildContext context, LayoutInfo info, Widget? child) =>
            Scaffold(
                appBar: appBar,
                drawer: info.hasStandardDrawer
                    ? null
                    : hasNavBar
                        ? secondaryDrawer
                        : drawer,
                endDrawer: info.hasStandardSideSheet ? null : sideSheet,
                floatingActionButton: floatingActionButton,
                floatingActionButtonLocation: floatingActionButtonLocation,
                bottomNavigationBar: !hasNavBar || !info.hasBottomNavBar
                    ? null
                    : BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        items: [
                          for (final NavigationItem item in navItems!)
                            item.bottomNavBar,
                        ],
                        currentIndex: navIndex!,
                        onTap: onNavIndexChanged,
                      ),
                body: Row(children: [
                  if (hasNavBar && info.hasNavRail)
                    NavigationRail(
                      labelType: NavigationRailLabelType.all,
                      destinations: [
                        for (final NavigationItem item in navItems!)
                          item.navRail,
                      ],
                      selectedIndex: navIndex!,
                      onDestinationSelected: onNavIndexChanged,
                    )
                  else if (info.hasStandardDrawer)
                    drawer,
                  Expanded(child: child!),
                  if (sideSheet != null && info.hasStandardSideSheet)
                    SizedBox(
                      width: 320,
                      child: sideSheet,
                    )
                ])),
      );
}
