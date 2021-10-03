// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:brand_tool_one/src/infrastructure/circle.dart';
import 'package:brand_tool_one/src/infrastructure/dialogonal.dart';
import 'package:brand_tool_one/src/infrastructure/kenburns.dart';
import 'package:brand_tool_one/src/infrastructure/shapeofview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class JacksMan extends StatefulWidget {
  const JacksMan({Key? key}) : super(key: key);

  @override
  State<JacksMan> createState() => JacksManState();
}

//in real apps you create a non-native splash screen with future builder
// and then use a stateful to precache the app images
class JacksManState extends State<JacksMan> {
  late Image image1;
  late Image image2;

  @override
  void initState() {
    super.initState();

    image1 = Image.asset("assets/images/diagonallayout_background.jpg");
    image2 = Image.asset("assets/images/diagonallayout_hughjackman.jpg");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // generally reference elsewhere in the app as image1.image and image2.image
    precacheImage(image1.image, context);
    precacheImage(image2.image, context);
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShapeOfView(
          // ignore: avoid_redundant_argument_values
          elevation: 4,
          height: 300,
          shape: DiagonalShape(
            angle: DiagonalAngle.deg(angle: 15),
          ),
          
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              KenBurns(
                maxScale: 5,
                child: Image.asset(
                  "assets/images/diagonallayout_background.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 18, top: 120),
                    child: Text(
                      "Hugh Jackman",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                          fontSize: 20,
                          shadows: [
                            Shadow(
                                // ignore: avoid_redundant_argument_values
                                color: Colors.black,
                                blurRadius: 1,
                                offset: Offset(1, 1),),
                          ],),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 6.0),
                    child: Text(
                      "Actor Producer",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 20,
                          shadows: [
                            Shadow(
                                // ignore: avoid_redundant_argument_values
                                color: Colors.black,
                                blurRadius: 1,
                                offset: Offset(1, 1),),
                          ],),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, top: 230),
          child: ShapeOfView(
            height: 100,
            width: 100,
            // ignore: avoid_redundant_argument_values
            shape: CircleShape(borderColor: Colors.white, borderWidth: 3),
            elevation: 12,
            child: Image.asset(
              "assets/images/diagonallayout_hughjackman.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );

  }
}
