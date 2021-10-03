// Copyright 2021 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
//
// Original Copyright 2019 Florent Champigny (florent37) under Apache License
// Modifications were to make it null-safe.

// ignore_for_file: cast_nullable_to_non_nullable

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class KenBurnsGeneratorConfig {
  double newScale;
  Offset newTranslation;
  Duration newDuration;

  KenBurnsGeneratorConfig({
    required this.newScale,
    required this.newTranslation,
    required this.newDuration,
  });
}

/// The random scale, translation, duration generator
class KenburnsGenerator {
  final Random _random = Random();

  KenburnsGenerator();

  /// Generates a positive random integer distributed on the range
  double _randomValue(double min, double max) =>
      min + _random.nextDouble() * (max - min);

  double generateNextScale({
    double? lastScale,
    double? maxScale,
    bool? scaleDown,
  }) {
    const double minScale = 1.0;

    return scaleDown as bool && minScale < lastScale!
        ? _randomValue(minScale, lastScale)
        : _randomValue(max(minScale, lastScale as double), maxScale as double);
  }

  Duration generateNextDuration({
    double? minDurationMillis,
    double? maxDurationMillis,
  }) {
    return Duration(
      milliseconds:
          _randomValue(minDurationMillis as double, maxDurationMillis as double)
              .floor(),
    );
  }

  Offset generateNextTranslation({
    double? width,
    double? height,
    Size? nextSize,
    double? nextScale,
  }) {
    final availableXOffset = (nextSize!.width - width!) / 2;
    final availableYOffset = (nextSize.height - height!) / 2;

    final x = _randomValue(-1 * availableXOffset, availableXOffset);
    final y = _randomValue(-1 * availableYOffset, availableYOffset);

    return Offset(x, y);
  }

  // ignore: long-parameter-list
  KenBurnsGeneratorConfig generateNextConfig({
    double? width,
    double? height,
    double? maxScale,
    double? lastScale,
    bool? scaleDown,
    double? minDurationMillis,
    double? maxDurationMillis,
    Offset? lastTranslation,
  }) {
    Duration nextDuration;
    double nextScale;
    Offset nextTranslation;

    // ignore: duplicate_ignore
    nextDuration = generateNextDuration(
     
      minDurationMillis: minDurationMillis as double,
      
      maxDurationMillis: maxDurationMillis as double,
    );

    nextScale = generateNextScale(
      
      lastScale: lastScale as double,
      
      maxScale: maxScale as double,
      
      scaleDown: scaleDown as bool,
    );

    final Size nextSize = Size(width! * nextScale, height! * nextScale);

    nextTranslation = generateNextTranslation(
      width: width,
      height: height,
      nextScale: nextScale,
      nextSize: nextSize,
    );

    return KenBurnsGeneratorConfig(
      newDuration: nextDuration,
      newTranslation: nextTranslation,
      newScale: nextScale,
    );
  }
}

/// KenBurns widget, please provide a `child` Widget,
/// Will animate the child, using random scale, translation & duration
class KenBurns extends StatefulWidget {
  final Widget? child;

  /// minimum translation & scale duration, not null
  final Duration minAnimationDuration;

  /// maximum translation & scale duration, not null
  final Duration maxAnimationDuration;

  /// Maximum allowed child scale, > 1
  final double maxScale;

  //region multiple images
  /// If specified (using the constructor multiple)
  /// Will animate [childLoop] each children then will fade to the next child
  /// Not Null & Size must be > 1
  /// if size == 1 -> Will use the KenBurns as a single child
  final List<Widget>? children;

  /// If specified (using the constructor multiple)
  /// Will specify the fade in duration between 2 child
  final Duration? childrenFadeDuration;

  /// If specified (using the constructor multiple)
  /// Will determine how many times each child will stay in the KenBurns
  /// Until the next child will be displayed
  final num? childLoop;

  //end region

  /// Constructor for a single child KenBurns
  KenBurns({
    Key? key,
    // ignore: tighten_type_of_initializing_formals
    required this.child,
    this.minAnimationDuration = const Duration(milliseconds: 3000),
    this.maxAnimationDuration = const Duration(milliseconds: 10000),
    this.maxScale = 8,
    // ignore: unnecessary_this
  })  : this.childrenFadeDuration = null,
        // ignore: unnecessary_this
        this.children = null,
        // ignore: unnecessary_this
        this.childLoop = null,
        // ignore: unnecessary_null_comparison
        assert(minAnimationDuration != null &&
            minAnimationDuration.inMilliseconds > 0),
        // ignore: unnecessary_null_comparison
        assert(maxAnimationDuration != null &&
            maxAnimationDuration.inMilliseconds > 0),
        assert(minAnimationDuration < maxAnimationDuration),
        assert(maxScale > 1),
        // ignore: unnecessary_null_comparison
        assert(child != null),
        super(key: key);

  /// Constructor for multiple child KenBurns
  const KenBurns.multiple({
    Key? key,
    this.minAnimationDuration = const Duration(milliseconds: 1000),
    this.maxAnimationDuration = const Duration(milliseconds: 10000),
    this.maxScale = 10,
    this.childLoop = 3,
    required this.children,
    this.childrenFadeDuration = const Duration(milliseconds: 800),
  })  
  // ignore: unnecessary_this
  : this.child = null,
        super(key: key);

  @override
  _KenBurnsState createState() => _KenBurnsState();
}

class _KenBurnsState extends State<KenBurns> with TickerProviderStateMixin {
  bool _running = false;

  /// The generated scale controller
  /// Will be destroyed / created at each loop (because duration is different)
  late AnimationController _scaleController;

  /// The generated scale controller's animation
  /// Will be destroyed / created at each loop (because duration is different)
  late Animation<double> _scaleAnim;

  /// The generated translation controller
  /// Will be destroyed / created at each loop (because duration is different)
  late AnimationController _translationController;

  /// The generated translation controller's X animation
  /// Will be destroyed / created at each loop (because duration is different)
  late Animation<double> _translationXAnim;

  /// The generated translation controller's Y animation
  /// Will be destroyed / created at each loop (because duration is different)
  late Animation<double> _translationYAnim;

  /// The animated current scale
  double _currentScale = 1;

  /// The animated current translation X
  double _currentTranslationX = 0;

  /// The animated current translation Y
  double _currentTranslationY = 0;

  /// If true : next animation will scale down,
  /// false : next animation will scale up
  bool _scaleDown = true;

  /// For developers : set to true to enable logs
  final bool _displayLogs = false;

  /// The random [scale/duration/translation] generator
  final KenburnsGenerator _kenburnsGenerator = KenburnsGenerator();

  //region multiple childs
  /// if true : the widget setup is multipleImages
  bool get _displayMultipleImage =>
      // ignore: unnecessary_null_comparison
      widget.children != null && widget.children!.length > 1;
  int _nextChildIndex = -1;
  int _currentChildIndex = 0;
  int _currentChildLoop = 0;

  double _opacityCurrentChild = 1;
  double _opacityNextChild = 0;

  /// The generated fade controller
  late AnimationController _fadeController;

  /// The generated opacity fade in controller's animation
  late Animation<double> _fadeInAnim;

  /// The generated opacity fade out controller's animation
  late Animation<double> _fadeOutAnim;

  //end region

  /// Generate the fade (in & out) animations
  Future<void> _createFadeAnimations() async {
    _fadeController.dispose();
    _fadeController = AnimationController(
      duration: widget.childrenFadeDuration,
      vsync: this,
    );
    _fadeInAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.linear),
    )..addListener(() {
        setState(() {
          _opacityNextChild = _fadeInAnim.value;
        });
      });
    _fadeOutAnim = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.linear),
    )..addListener(() {
        setState(() {
          _opacityCurrentChild = _fadeOutAnim.value;
        });
      });
  }

  /// Generate the next animation [scale, duration, translation]
  /// Using the [KenBurnsGenerator] generateNextConfig
  // ignore: long-method
  Future<void> _createNextAnimations({double? height, double? width}) async {
    final KenBurnsGeneratorConfig nextConfig =
        _kenburnsGenerator.generateNextConfig(
      width: width,
      height: height,
      maxScale: widget.maxScale,
      lastScale: _currentScale,
      scaleDown: _scaleDown,
      minDurationMillis: widget.minAnimationDuration.inMilliseconds.toDouble(),
      maxDurationMillis: widget.maxAnimationDuration.inMilliseconds.toDouble(),
      lastTranslation: Offset(_currentTranslationX, _currentTranslationY),
    );

    /// Recreate the scale animations
    _scaleController.dispose();
    _scaleController = AnimationController(
      duration: nextConfig.newDuration,
      vsync: this,
    );

    _scaleAnim =
        // ignore: unnecessary_this
        Tween(begin: this._currentScale, end: nextConfig.newScale).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.linear),
    )..addListener(() {
            setState(() {
              _currentScale = _scaleAnim.value;
            });
          });

    /// Recreate the translations animations
    _translationController.dispose();
    _translationController = AnimationController(
      duration: nextConfig.newDuration,
      vsync: this,
    );

    _translationXAnim = Tween(
      // ignore: unnecessary_this
      begin: this._currentTranslationX, end: nextConfig.newTranslation.dx,
    ).animate(
      CurvedAnimation(parent: _translationController, curve: Curves.linear),
    )..addListener(() {
        setState(() {
          _currentTranslationX = _translationXAnim.value;
        });
      });
    _translationYAnim = Tween(
      // ignore: unnecessary_this
      begin: this._currentTranslationY, end: nextConfig.newTranslation.dy,
    ).animate(
      CurvedAnimation(parent: _translationController, curve: Curves.linear),
    )..addListener(() {
        setState(() {
          _currentTranslationY = _translationYAnim.value;
        });
      });

    log("kenburns started");
    log("kenburns d(${nextConfig.newDuration}) translation(${nextConfig.newTranslation.dx}, ${nextConfig.newTranslation.dy}) scale(${nextConfig.newScale})");

    /// Next scale animation will be inverted
    _scaleDown = !_scaleDown;

    /// fire scale & translation animations
    await Future.wait(
      [
        _scaleController.forward(),
        _translationController.forward(),
      ],
    );

    log("kenburns finished");
  }

  /// Display on debug logs (enable with [_displayLogs])
  void log(String text) {
    if (_displayLogs) {
      log(text);
    }
  }

  /// Fire the fade (in/out) animation
  Future<void> _fade() async {
    await _fadeController.forward();

    if (!_running) return;

    setState(() {
      _currentChildIndex = _nextChildIndex;

      _nextChildIndex = _currentChildIndex + 1;
      _nextChildIndex = _nextChildIndex % widget.children!.length;
    });

    _fadeController.reset();
  }

  Future<void> fire({double? height, double? width}) async {
    _running = true;

    final num myNum = widget.childLoop as num;

    if (_displayMultipleImage) {
      _nextChildIndex = 1;

      /// Create one time the fade animation
      await _createFadeAnimations();

      /// Cancel if _running go to false
      while (_running) {
        await _createNextAnimations(
            width: width as double, height: height as double,);
        if (!_running) return;

        if (_currentChildLoop % myNum == 0) {
          _fade(); //parallel
        }
        _currentChildLoop++;
      }
    } else {
      /// Cancel if _running go to false
      while (_running) {
        await _createNextAnimations(
            width: width as double, height: height as double,);
      }
    }
  }

  @override
  void initState() {
    /// Reset _running state
    _running = false;
    super.initState();
  }

  @override
  void didUpdateWidget(KenBurns oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.children!.length != oldWidget.children!.length) {
      _running = false;
      _scaleController.dispose();
      _fadeController.dispose();
      _translationController.dispose();
      _currentChildIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    /// Layout builder to provide constrains height/width
    return LayoutBuilder(builder: (context, constraints) {
      /// create the animation only if we have a size (not possible in initState())
      if (!_running) {
        fire(height: constraints.maxHeight, width: constraints.maxWidth);
      }

      return ClipRect(
        ///Clip because we scale up children, if not clipped : child can take all the screen
        /// Apply the current animated translation
        child: Transform.translate(
          offset: Offset(_currentTranslationX, _currentTranslationY),

          /// Apply the current animated scale
          child: Transform.scale(
            scale: _currentScale,
            child: _buildChild(),
          ),
        ),
      );
    });
  }

  Widget _buildChild() {
    // ignore: prefer-conditional-expressions
    if (_displayMultipleImage) {
      /// If the [currentChildIndex] changed (different than [lastChildIndex])
      /// -> we animate to display the next child
      /// We use the stack to keep the same structure as multiple/single child
      return Stack(fit: StackFit.expand, children: <Widget>[
        Opacity(
          opacity: _opacityCurrentChild,
          child: widget.children![_currentChildIndex],
        ),
        Opacity(
          opacity: _opacityNextChild,
          child: widget.children![_nextChildIndex],
        ),
      ]);
    } else {
      /// If we have only 1 child
      /// We use the stack to keep the same structure as multiple/single child
      return Stack(
        fit: StackFit.expand,
        children: [
          widget.child as Widget,
        ],
      );
    }
  }

  @override
  void dispose() {
    /// will stop the [fire()] loop
    _running = false;
    _scaleController.dispose();
    _translationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('_displayLogs', _displayLogs));
  }
}
