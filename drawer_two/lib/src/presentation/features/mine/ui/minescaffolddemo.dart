// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.



import 'package:drawer_two/src/presentation/widgets/adaptive_app_bar.dart';
import 'package:drawer_two/src/presentation/widgets/adaptive_navigation_scaffold.dart';
import 'package:drawer_two/src/presentation/widgets/mydrawerheader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MineScaffoldDemo extends StatefulWidget {
  const MineScaffoldDemo({Key? key}) : super(key: key);

  static const routeName = '/minescaffolddemo';

  @override
  _MineScaffoldDemoState createState() => _MineScaffoldDemoState();
}

class _MineScaffoldDemoState extends State<MineScaffoldDemo> {
  int _destinationCount = 5;
  bool _fabInRail = false;
  bool _includeBaseDestinationsInMenu = true;

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
      drawerHeader: myDrawerHeader(),
      backgroundColor: Colors.blueAccent,
      selectedIndex: 0,
      destinations: _allDestinations.sublist(0, _destinationCount),
      appBar: AdaptiveAppBar(
        title: const Text('Drawer Two'),
        
        shape: const MyShapeBorder(50),
        ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        // ignore: no-empty-block
        onPressed: () {},
      ),
      navigationTypeResolver: (context) {
        return MediaQuery.of(context).size.width > 600
            ? NavigationType.permanentDrawer
            : NavigationType.bottom;
      },
      fabInRail: _fabInRail,
      includeBaseDestinationsInMenu: _includeBaseDestinationsInMenu,
    );
  }

  // ignore: long-method
  Widget _body() {

    // ignore: avoid_unnecessary_containers
    return Container(
      
      child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('''
          This is mine behavior of the AdaptiveNavigationScaffold.
          It switches between bottom navigation and a drawer.
          Resize the window to switch between the navigation types.
          '''),
          const SizedBox(height: 40),
          Slider(
            min: 2,
            max: _allDestinations.length.toDouble(),
            divisions: _allDestinations.length - 2,
            value: _destinationCount.toDouble(),
            label: _destinationCount.toString(),
            onChanged: (value) {
              setState(() {
                _destinationCount = value.round();
              });
            },
          ),
          const Text('Destination Count'),
          const SizedBox(height: 40),
          Switch(
            value: _fabInRail,
            onChanged: (value) {
              setState(() {
                _fabInRail = value;
              });
            },
          ),
          const Text('fabInRail'),
          const SizedBox(height: 40),
          Switch(
            value: _includeBaseDestinationsInMenu,
            onChanged: (value) {
              setState(() {
                _includeBaseDestinationsInMenu = value;
              });
            },
          ),
          const Text('includeBaseDestinationsInMenu'),
          const SizedBox(height: 40),
          ElevatedButton(
            child: const Text('BACK'),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    ),);
      
    
  }
}

const _allDestinations = [
  AdaptiveScaffoldDestination(title: 'Alarm', icon: Icons.alarm),
  AdaptiveScaffoldDestination(title: 'Book', icon: Icons.book),
  AdaptiveScaffoldDestination(title: 'Cake', icon: Icons.cake),
  AdaptiveScaffoldDestination(title: 'Directions', icon: Icons.directions),
  AdaptiveScaffoldDestination(title: 'Email', icon: Icons.email),
  AdaptiveScaffoldDestination(title: 'Favorite', icon: Icons.favorite),
  AdaptiveScaffoldDestination(title: 'Group', icon: Icons.group),
  AdaptiveScaffoldDestination(title: 'Headset', icon: Icons.headset),
  AdaptiveScaffoldDestination(title: 'Info', icon: Icons.info),
];


class MyShapeBorder extends ContinuousRectangleBorder {
  const MyShapeBorder(this.curveHeight);
  final double curveHeight;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()
    ..lineTo(0, rect.size.height)
    ..quadraticBezierTo(
      rect.size.width / 2,
      rect.size.height + curveHeight * 2,
      rect.size.width,
      rect.size.height,
    )
    ..lineTo(rect.size.width, 0)
    ..close();
}
