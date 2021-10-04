// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardSliverAppBar extends StatefulWidget {
  final double height;
  final Image background;
  final double appBarHeight = 60;
  final Text title;
  final Text titleDescription;
  final bool backButton;
  final List<Color> backButtonColors;
  final Widget action;
  final Widget body;
  final ImageProvider card;

  // ignore: prefer_const_constructors_in_immutables
  CardSliverAppBar(
      {required this.height,
      required this.background,
      required this.title,
      required this.body,
      required this.titleDescription,
      this.backButton = false,
      required this.backButtonColors,
      required this.action,
      required this.card,
      Key? key,})
      // ignore: unnecessary_null_comparison
      : assert(height != null && height > 0),
        // ignore: unnecessary_null_comparison
        assert(background != null),
        // ignore: unnecessary_null_comparison
        assert(title != null),
        // ignore: unnecessary_null_comparison
        assert(body != null),
        super(key: key);

  @override
  _CardSliverAppBarState createState() => _CardSliverAppBarState();
}

class _CardSliverAppBarState extends State<CardSliverAppBar>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _fadeTransition;
  late Animatable<Color> _animatedBackButtonColors;
  late Animation<double> _rotateCard;

  double _scale = 0.0;
  double _offset = 0.0;

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    _fadeTransition = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),))
      ..addListener(() {
        // ignore: no-empty-block
        setState(() {});
      });
    // ignore: unnecessary_null_comparison
    if (widget.card != null) {
      _rotateCard = Tween(begin: 0.0, end: 0.4).animate(
          CurvedAnimation(curve: Curves.linear, parent: _animationController),)
        ..addListener(() {
          // ignore: no-empty-block
          setState(() {});
        });
    }
    _scrollController = ScrollController()
      ..addListener(() {
        // ignore: no-empty-block
        setState(() {});
      });
  }

  // ignore: use_setters_to_change_properties
  void _animationValue(double scale) {
    _animationController.value = scale;
  }

  //gets
  List<Color> get _backButtonColors => widget.backButtonColors;
  ImageProvider<Object> get _card => widget.card;
  Widget get _action => widget.action;
  bool get _backButton => widget.backButton;
  double get _height => widget.height;
  Widget get _body => widget.body;
  double get _appBarHeight => widget.appBarHeight;
  Image get _background => widget.background;
  Text get _titleDescription => widget.titleDescription;
  Text get _title => widget.title;

  @override
  Widget build(BuildContext context) {
    if (_scrollController.hasClients) {
      _scale = _scrollController.offset / (widget.height - widget.appBarHeight);
      if (_scale > 1) {
        _scale = 1.0;
      }
      _offset = _scrollController.offset;
    }
    _animationValue(_scale);
    _scale = 1.0 - _scale;

    // ignore: unnecessary_null_comparison
    if (_backButtonColors != null && _backButtonColors.length >= 2) {
      _animatedBackButtonColors = TweenSequence<Color>([
        TweenSequenceItem(
            weight: 1.0,
            tween: Tween(
              begin: _backButtonColors[0],
              end: _backButtonColors[1],
            ),),
      ]);
    }

    final List<Widget> stackOrder = <Widget>[];
    if (_scale >= 0.5) {
      stackOrder.add(_bodyContainer());
      stackOrder.add(_backgroundConstructor());
      stackOrder.add(_shadowConstructor());
      stackOrder.add(_titleConstructor());
      // ignore: unnecessary_null_comparison
      if (_card != null) stackOrder.add(_cardConstructor());
      // ignore: unnecessary_null_comparison
      if (_action != null) stackOrder.add(_actionConstructor());
      // ignore: unnecessary_null_comparison
      if (_backButton != null && _backButton) {
        stackOrder.add(_backButtonConstructor());
      }
    } else {
      stackOrder.add(_backgroundConstructor());
      // ignore: unnecessary_null_comparison
      if (_card != null) stackOrder.add(_cardConstructor());
      stackOrder.add(_bodyContainer());
      stackOrder.add(_shadowConstructor());
      stackOrder.add(_titleConstructor());
      // ignore: unnecessary_null_comparison
      if (_action != null) stackOrder.add(_actionConstructor());
      // ignore: unnecessary_null_comparison
      if (_backButton != null && _backButton) {
        stackOrder.add(_backButtonConstructor());
      }
    }

    return SafeArea(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: ListView(
          controller: _scrollController,
          primary: false,
          children: <Widget>[
            Stack(
              key: const Key("widget_stack"),
              children: stackOrder,
            ),
          ],
        ),
      ),
    );
  }

  Widget _backButtonConstructor() {
    return Positioned(
      top: _offset + 7,
      left: 5,
      child: Column(
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            // ignore: unnecessary_null_comparison
            color: _animatedBackButtonColors != null
                ? _animatedBackButtonColors.evaluate(
                    AlwaysStoppedAnimation(_animationController.value),)
                : Colors.white,
            iconSize: 25,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _bodyContainer() {
    return Container(
      key: const Key("widget_body"),
      margin: EdgeInsets.only(top: _height),
      child: _body,
    );
  }

  double _getRotationAnimationValue(double animValue) {
    // ignore: parameter_assignments
    animValue = animValue * 5;
    final double value = -pow(animValue, 2) + (2 * animValue);

    return value;
  }

  double _getCardTopMargin() {
    final double value = _scale <= 0.5
        ? widget.height - ((widget.appBarHeight * 3.6) * _scale)
        : widget.height - (widget.appBarHeight * 1.8);

    return value;
  }

  Widget _cardConstructor() {
    return Positioned(
      key: const Key("widget_card"),
      top: _getCardTopMargin(),
      left: 20,
      child: Transform.rotate(
        angle: _getRotationAnimationValue(_rotateCard.value),
        origin: const Offset(50, -70),
        child: SizedBox(
          width: _appBarHeight * 1.67,
          height: _appBarHeight * 2.3,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(image: _card, fit: BoxFit.cover),),
          ),
        ),
      ),
    );
  }

  Widget _backgroundConstructor() {
    return Container(
      key: const Key("widget_background"),
      height: _height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: FadeTransition(
        opacity: _fadeTransition,
        child: _background,
      ),
    );
  }

  Widget _shadowConstructor() {
    return Positioned(
        key: const Key("widget_appbar_shadow"),
        top: _scale == 0.0 ? _offset + _appBarHeight : _height,
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            decoration:
                const BoxDecoration(color: Colors.transparent, boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 1.0,
              ),
            ]),),);
  }

  Widget _titleConstructor() {
    return Positioned(
      key: const Key("widget_title"),
      top: _scale == 0.0 ? _offset : widget.height - widget.appBarHeight,
      child: ClipPath(
        clipper: _MyCliperChanfro(_animationController.value),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
              left: _scale >= 0.12
                  ? 40 + ((MediaQuery.of(context).size.width / 4) * _scale)
                  : 50,),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: _appBarHeight,
          child: _titleDescriptionHandler(),
        ),
      ),
    );
  }

  Widget _titleDescriptionHandler() {
    // ignore: unnecessary_null_comparison
    if (_titleDescription != null) {
      final titleContainer = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(bottom: 25 * _scale),
        child: _title,
      );

      final titleDescriptionContainer = Opacity(
        opacity: _scale <= 0.7 ? _scale / 0.7 : 1.0,
        child: Container(
          alignment: Alignment.centerLeft,
          // ignore: unnecessary_parenthesis
          padding: EdgeInsets.only(top: (25 * _scale)),
          child: _titleDescription,
        ),
      );

      return Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          titleDescriptionContainer,
          titleContainer,
        ],
      );
    } else {
      return _title;
    }
  }

  Widget _actionConstructor() {
    return Positioned(
        key: const Key("widget_action"),
        top: _height - _appBarHeight - 25,
        right: 10,
        child: Transform.scale(
            scale: _scale >= 0.5 ? 1.0 : (_scale / 0.5),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(color: Colors.black54, blurRadius: 3.0),
                  ],),
              child: _action,
            ),),);
  }
}

class _MyCliperChanfro extends CustomClipper<Path> {
  double scale;

  _MyCliperChanfro(this.scale);

  @override
  Path getClip(Size size) {
    final Path path = Path();
    scale = 1.0 - scale;
    if (scale >= 0.5) {
      path.lineTo(0, 30);
      path.lineTo(50, 0);
    } else {
      path.lineTo(0, (scale / 0.5) * 30);
      path.lineTo((scale / 0.5) * 50, 0);
    }
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
