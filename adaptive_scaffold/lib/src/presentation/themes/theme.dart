// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ThemeData myTheme = ThemeData(
  primarySwatch: Colors.red,
  //canvasColor: Colors.amber.shade400,
  hoverColor: Colors.red.shade100,
  focusColor: Colors.blue,
  iconTheme: IconThemeData(
    color: Colors.green.shade600,
  ),
  dividerColor: Colors.grey.shade600,
  dividerTheme: const DividerThemeData(
    thickness: 1,
    space: 1, // Width of the divider
    //color: Colors.black,
  ),
  /*
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey.shade200,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      selectedItemColor: Colors.red.shade500,
      selectedIconTheme: IconThemeData(
        color: Colors.red.shade400,
        size: 24,
      )),
      */
  navigationRailTheme: NavigationRailThemeData(
    backgroundColor: Colors.red.shade500,
    selectedIconTheme: const IconThemeData(
      color: Colors.white,
    ),
    selectedLabelTextStyle: const TextStyle(
      color: Colors.white,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.red.shade200,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: Colors.red.shade200,
    ),
    labelType: NavigationRailLabelType.all,
  ),
);
