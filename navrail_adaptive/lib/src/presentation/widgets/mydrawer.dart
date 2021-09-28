// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Modified from BreakPoint Scaffold

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyDrawer extends StatelessWidget {
  final bool includePrimaryNavItems;
  const MyDrawer({Key? key, required this.includePrimaryNavItems}) : super(key: key);

  Widget get header => const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(child: Text("U")),
          accountName: Text("User"),
          accountEmail: Text("username@gmail.com"),
          otherAccountsPictures: [
            CircleAvatar(child: Text("A")),
            CircleAvatar(child: Text("B")),
            CircleAvatar(child: Text("C")),
          ]);

  @override
  Widget build(BuildContext context) => Drawer(
          child: ListView(children: [
        header,
        if (includePrimaryNavItems)
          for (int index = 0; index < 5; index++)
            ListTile(
                title: Text("Go to page $index"),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(index.toString())),
        const ListTile(title: Text("About")),
        const ListTile(title: Text("Log out")),
      ]));
}
