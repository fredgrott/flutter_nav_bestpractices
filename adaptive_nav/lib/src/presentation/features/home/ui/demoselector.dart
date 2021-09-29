// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:adaptive_nav/src/presentation/features/custom/ui/custom_scaffold.dart';
import 'package:adaptive_nav/src/presentation/features/default/ui/default_scaffold.dart';
import 'package:adaptive_nav/src/presentation/features/mine/ui/minescaffolddemo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoSelector extends StatelessWidget {
  const DemoSelector({Key? key}) : super(key: key);

  static const routeName = '/';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Default Scaffold'),
              onPressed: () {
                Navigator.of(context).pushReplacement<dynamic, dynamic>(
                  MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return const DefaultScaffoldDemo();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Custom Scaffold'),
              onPressed: () {
                Navigator.of(context).pushReplacement<dynamic, dynamic>(
                  MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return const CustomScaffoldDemo();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Mine Scaffold'),
              onPressed: () {
                Navigator.of(context).pushReplacement<dynamic, dynamic>(
                  MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return const MineScaffoldDemo();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
