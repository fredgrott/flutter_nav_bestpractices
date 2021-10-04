// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sliverappbar_one/src/presentation/widgets/cardsliverappbar.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool favorito = false;
  bool expandText = false;

  late Image image1;
  late Image image2;

  @override
  void initState() {
    super.initState();

    //image1 = Image.asset("assets/images/logo.png");
    image1 = const Image(
      image: AssetImage("assets/images/logo.png"),
      fit: BoxFit.cover,
    );
    image2 = Image.asset("assets/images/card.jpg");
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
    // example using no scaffold so we need a Material container
    return Material(
      child: CardSliverAppBar(
        height: 300,
        background: image1,
        title: const Text(
          "The Walking Dead",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        titleDescription: const Text(
          "Drama, Action, Adventure, Fantasy, \nScience Fiction, Horror, Thriller",
          style: TextStyle(color: Colors.black, fontSize: 11),
        ),
        card: image2.image,
        backButton: true,
        backButtonColors: const [Colors.white, Colors.black],
        action: IconButton(
          onPressed: () {
            setState(() {
              favorito = !favorito;
            });
          },
          icon: favorito
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          color: Colors.red,
          iconSize: 30.0,
        ),
        body: Container(
          alignment: Alignment.topLeft,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  // ignore: avoid_redundant_argument_values
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _ratingIcon(
                      const Icon(Icons.star),
                      const Text(
                        "84%",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _ratingIcon(
                      const Icon(Icons.personal_video),
                      const Text(
                        "AMC",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _ratingIcon(
                      const Icon(Icons.people),
                      const Text(
                        "TV-MA",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _ratingIcon(
                      const Icon(Icons.av_timer),
                      const Text(
                        "45m",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: expandText ? 145 : 65,
                margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      expandText = !expandText;
                    });
                  },
                  child: const Text(
                    "The series centers on sheriff's deputy Rick Grimes, who wakes up from a coma to discover the apocalypse. He becomes the leader of a group of survivors from the Atlanta, Georgia..\n"
                    "region as they attempt to sustain themselves and protect themselves not only against attacks by walkers but by other groups of survivors willing to assure their longevity by any means necessary.",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 30),
                child: const Text(
                  "Related shows",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                    _exampleRelatedShow(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _exampleRelatedShow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.grey,
      ),
      width: 80,
      height: 100,
    );
  }

  Widget _ratingIcon(Icon icon, Text text) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.grey,
            ),
            child: IconButton(
              // ignore: no-empty-block
              onPressed: () {},
              icon: icon,
              color: Colors.white,
              iconSize: 30,
            ),
          ),
          const Divider(),
          text,
        ],
      ),
    );
  }
}
