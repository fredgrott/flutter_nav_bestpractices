// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Modified from BreakPoint Scaffold

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SideSheet extends StatelessWidget {
  const SideSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
          child: Column(children: const [
        DrawerHeader(
          child: Text("More", textScaleFactor: 1.5),
        ),
        Spacer(),
        Text("This gives you more options"),
        Spacer(),
      ]));
}
