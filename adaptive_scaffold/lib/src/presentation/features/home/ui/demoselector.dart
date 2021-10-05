// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:adaptive_scaffold/src/presentation/features/scaffold_one/ui/scaffoldone.dart';
import 'package:adaptive_scaffold/src/presentation/features/scaffold_two/ui/scaffold_two.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoSelector extends StatelessWidget {
  const DemoSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Scaffold One'),
              onPressed: () {
                Navigator.of(context).pushReplacement<dynamic, dynamic>(
                  MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return const ScaffoldOne();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Scaffold Two'),
              onPressed: () {
                Navigator.of(context).pushReplacement<dynamic, dynamic>(
                  MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return const ScaffoldTwo();
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
