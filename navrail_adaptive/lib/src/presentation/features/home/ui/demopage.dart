// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navrail_adaptive/src/presentation/widgets/adaptive_appbar.dart';
import 'package:navrail_adaptive/src/presentation/widgets/mydrawer.dart';
import 'package:navrail_adaptive/src/presentation/widgets/navigationitem.dart';
import 'package:navrail_adaptive/src/presentation/widgets/respsonsive_scaffold.dart';
import 'package:navrail_adaptive/src/presentation/widgets/sidesheet.dart';

class DemoPage extends StatelessWidget {
  final int index;
  const DemoPage(this.index, {Key? key}) : super(key: key);

  Widget get fab => FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.info),
      );

  AdaptiveAppBar get appBar => AdaptiveAppBar(title: Text("Page $index"), actions: [
        Builder(
            builder: (BuildContext context) => IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                }))
      ]);

  @override
  Widget build(BuildContext context) => ResponsiveScaffold.navBar(
        navItems: [
          for (int index = 0; index < 5; index++)
            NavigationItem(
                label: index.toString(), icon: const Icon(Icons.info)),
        ],
        navIndex: index,
        onNavIndexChanged: (int value) =>
            Navigator.of(context).pushReplacementNamed(value.toString()),
        drawer: const MyDrawer(includePrimaryNavItems: true),
        appBar: appBar,
        body: const Placeholder(),
        secondaryDrawer: const MyDrawer(includePrimaryNavItems: false),
        sideSheet: const SideSheet(),
        floatingActionButton: fab,
      );
}
