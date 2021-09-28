// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:navrail_adaptive/src/presentation/features/home/ui/demopage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "1",
      onGenerateRoute: (RouteSettings settings) {
        final int? index = int.tryParse(settings.name!);
        if (index == null) {
          return null;
        }
        return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (_, __, ___) => DemoPage(index),
          transitionDuration: Duration.zero,
        );
      },

    );
  }
}
