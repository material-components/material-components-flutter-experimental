import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';


// Curves that represent the two curves that compose the emphasized easing curve.
const Cubic _kAccelerateCurve = const Cubic(0.548, 0.0, 0.757, 0.464);
const Cubic _kDecelerateCurve = const Cubic(0.23, 0.94, 0.41, 1.0);
// The time at which the accelerate and decelerate curves switch off
const double _kPeakVelocityTime = 0.248210;
// Percent (as a decimal) of animation that should be completed at _peakVelocityTime
const double _kPeakVelocityProgress = 0.379146;
const double _kCartHeight = 56.0;
// Radius of the shape on the top left of the sheet.
const double _kCornerRadius = 24.0;

class ShortBottomSheetOwl extends StatefulWidget {
  const ShortBottomSheetOwl({ Key key, @required this.hideController })
      : assert(hideController != null),
        super(key: key);

  final AnimationController hideController;

  @override
  _ShortBottomSheetOwlState createState() => _ShortBottomSheetOwlState();

  static _ShortBottomSheetOwlState of(BuildContext context, { bool isNullOk: false }) {
    assert(isNullOk != null);
    assert(context != null);
    final _ShortBottomSheetOwlState result = context
        .ancestorStateOfType(const TypeMatcher<_ShortBottomSheetOwlState>());
    if (isNullOk || result != null) {
      return result;
    }
    throw FlutterError(
      'ShortBottomSheet.of() called with a context that does not contain a ShortBottomSheet.\n'
    );
  }
}

class _ShortBottomSheetOwlState extends State<ShortBottomSheetOwl> with TickerProviderStateMixin {
  final GlobalKey _shortBottomSheetKey =
      GlobalKey(debugLabel: 'Short bottom sheet');
  // The width of the Material, calculated by _getWidth & based on the number of
  // products in the cart.
  double _width;
  // Controller for the opening and closing of the ShortBottomSheet
  AnimationController _controller;
  // Animations for the opening and closing of the ShortBottomSheet
  Animation<double> _widthAnimation;
  Animation<double> _heightAnimation;
  Animation<double> _thumbnailOpacityAnimation;
  Animation<double> _cartOpacityAnimation;
  Animation<double> _shapeAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _width = 64.0;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _getWidthAnimation(double screenWidth) {
    if (_controller.status == AnimationStatus.forward) {
      // opening animation
      return Tween<double>(begin: _width, end: screenWidth).animate(
        CurvedAnimation(
          parent: _controller.view,
          curve: Interval(
            0.0,
            0.3,
            curve: Curves.fastOutSlowIn,
          ),
        ),
      );
    } else {
      // closing animation
      return TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: _width,
              end: _width + (screenWidth - _width) * (_kPeakVelocityProgress),
            ).chain(CurveTween(curve: _kDecelerateCurve.flipped)),
            weight: 1 - _kPeakVelocityTime,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: _width + (screenWidth - _width) * (_kPeakVelocityProgress),
              end: screenWidth,
            ).chain(CurveTween(curve: _kAccelerateCurve.flipped)),
            weight: _kPeakVelocityTime,
          ),
        ],
      ).animate(
        CurvedAnimation(
          parent: _controller.view,
          curve: Interval(0.0, 0.87),
        ),
      );
    }
  }

  Animation<double> _getHeightAnimation(double screenHeight) {
    if (_controller.status == AnimationStatus.forward) {
      // opening animation
      return TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: _kCartHeight,
              end: _kCartHeight + (screenHeight - _kCartHeight) * _kPeakVelocityProgress,
            ).chain(CurveTween(curve: _kAccelerateCurve)),
            weight: _kPeakVelocityTime,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: _kCartHeight + (screenHeight - _kCartHeight) * _kPeakVelocityProgress,
              end: screenHeight,
            ).chain(CurveTween(curve: _kDecelerateCurve)),
            weight: 1 - _kPeakVelocityTime,
          ),
        ],
      ).animate(_controller.view);
    } else {
      // opening animation
      return Tween<double>(
        begin: _kCartHeight,
        end: screenHeight,
      ).animate(
        CurvedAnimation(
          parent: _controller.view,
          curve: Interval(
            0.434,
            1.0,
            curve: Curves.fastOutSlowIn,
          ),
          reverseCurve: Interval( // only the reverseCurve will be used
            0.0,
            0.566,
            curve: Curves.fastOutSlowIn,
          ).flipped,
        ),
      );
    }
  }

  Animation<double> _getShapeAnimation() {
    if (_controller.status == AnimationStatus.forward) {
      return Tween<double>(begin: _kCornerRadius, end: 0.0).animate(
        CurvedAnimation(
          parent: _controller.view,
          curve: Interval(
            0.0,
            0.3,
            curve: Curves.fastOutSlowIn,
          ),
        ),
      );
    } else {
      return TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: _kCornerRadius,
              end: _kCornerRadius * _kPeakVelocityProgress,
            ).chain(CurveTween(curve: _kDecelerateCurve.flipped)),
            weight: 1 - _kPeakVelocityTime,
          ),
          TweenSequenceItem<double>(
            tween: Tween<double>(
              begin: _kCornerRadius * _kPeakVelocityProgress,
              end: 0.0,
            ).chain(CurveTween(curve: _kAccelerateCurve.flipped)),
            weight: _kPeakVelocityTime,
          ),
        ],
      ).animate(
        CurvedAnimation(
          parent: _controller.view,
          curve: Interval(0.0, 0.87),
        ),
      );
    }
  }

  Animation<double> _getThumbnailOpacityAnimation() {
    return Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller.view,
          curve: _controller.status == AnimationStatus.forward
              ? Interval(0.0, 0.3)
              : Interval(0.234, 0.468).flipped),
    );
  }

  Animation<double> _getCartOpacityAnimation() {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller.view,
          curve: _controller.status == AnimationStatus.forward
              ? Interval(0.3, 0.6)
              : Interval(0.0, 0.234).flipped),
    );
  }

  // Returns true if the cart is open or opening and false otherwise.
  bool get _isOpen {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  // Opens the ShortBottomSheet if it's closed, otherwise does nothing.
  void open() {
    if (!_isOpen) {
      _controller.forward();
    }
  }

  // Closes the ShortBottomSheet if it's open or opening, otherwise does nothing.
  void close() {
    if (_isOpen) {
      _controller.reverse();
    }
  }


  bool get _cartIsVisible => _thumbnailOpacityAnimation.value == 0.0;

  Widget _buildShoppingCartPage() {
    return Opacity(
      opacity: _cartOpacityAnimation.value,
      child: null,
    );
  }

  Widget _buildCart(BuildContext context, Widget child) {
    // numProducts is the number of different products in the cart (does not
    // include multiples of the same product).
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    _width = 70.0;
    _widthAnimation = _getWidthAnimation(screenWidth);
    _heightAnimation = _getHeightAnimation(screenHeight);
    _shapeAnimation = _getShapeAnimation();
    _thumbnailOpacityAnimation = _getThumbnailOpacityAnimation();
    _cartOpacityAnimation = _getCartOpacityAnimation();

    return Container(
      width: _widthAnimation.value,
      height: _heightAnimation.value,
      child: Material(
        type: MaterialType.canvas,
        animationDuration: Duration(milliseconds: 0),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_shapeAnimation.value)),
        ),
        elevation: 4.0,
        color: Colors.orange,
        child: _cartIsVisible
            ? _buildShoppingCartPage()
            : Icon(Icons.star),
      ),
    );
  }

  // Builder for the hide and reveal animation when the backdrop opens and closes
  Widget _buildSlideAnimation(BuildContext context, Widget child) {
    Curve firstCurve;
    Curve secondCurve;
    double firstWeight;
    double secondWeight;

    if (widget.hideController.status == AnimationStatus.forward) {
      firstCurve = _kAccelerateCurve;
      secondCurve = _kDecelerateCurve;
      firstWeight = _kPeakVelocityTime;
      secondWeight = 1.0 - _kPeakVelocityTime;
    } else {
      firstCurve = _kDecelerateCurve.flipped;
      secondCurve = _kAccelerateCurve.flipped;
      firstWeight = 1.0 - _kPeakVelocityTime;
      secondWeight = _kPeakVelocityTime;
    }

    _slideAnimation = TweenSequence(
            <TweenSequenceItem<Offset>>[
              TweenSequenceItem<Offset>(
                  tween: Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset(_kPeakVelocityProgress, 0.0),
                  ).chain(CurveTween(curve: firstCurve)),
                  weight: firstWeight),
              TweenSequenceItem<Offset>(
                  tween: Tween<Offset>(
                    begin: Offset(_kPeakVelocityProgress, 0.0),
                    end: Offset(0.0, 0.0),
                  ).chain(CurveTween(curve: secondCurve)),
                  weight: secondWeight),
            ],
          ).animate(widget.hideController);

    return SlideTransition(
      position: _slideAnimation,
      child: child,
    );
  }

  // Closes the cart if the cart is open, otherwise exits the app (this should
  // only be relevant for Android).
  Future<bool> _onWillPop() {
    _isOpen ? close() : SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      key: _shortBottomSheetKey,
      duration: Duration(milliseconds: 225),
      curve: Curves.easeInOut,
      vsync: this,
      alignment: FractionalOffset.topLeft,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: AnimatedBuilder(
          animation: widget.hideController,
          builder: _buildSlideAnimation,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: open,
            child: _buildCart(context, null),
          ),
        ),
      ),
    );
  }
}
