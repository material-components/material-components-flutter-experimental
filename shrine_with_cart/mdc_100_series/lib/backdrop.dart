// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'login.dart';

const double _kFlingVelocity = 2.0;

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
    Key key,
    this.onTap,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: Container(
              height: 40.0,
              alignment: AlignmentDirectional.centerStart,
            ),
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    // TODO: Add emphasized easing when available.
    final Animation<double> animation = CurvedAnimation(
      parent: this.listenable,
      curve: Interval(0.0, 0.78),
    );

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        // branded icon
        SizedBox(
          width: 72.0,
          child: IconButton(
            padding: EdgeInsets.only(right: 8.0),
            onPressed: this.onPress,
            icon: Stack(children: <Widget>[
              Opacity(
                opacity: animation.value,
                child: ImageIcon(AssetImage('assets/slanted_menu.png')),
              ),
              FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(1.0, 0.0),
                ).evaluate(animation),
                child: ImageIcon(AssetImage('assets/diamond.png')),
              )
            ]),
          ),
        ),
        // Here, we do a custom cross fade between backTitle and frontTitle.
        // This makes a smooth animation between the two texts.
        Stack(
          children: <Widget>[
            Opacity(
              opacity: CurvedAnimation(
                parent: ReverseAnimation(animation),
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(0.5, 0.0),
                ).evaluate(animation),
                child: backTitle,
              ),
            ),
            Opacity(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset(-0.25, 0.0),
                  end: Offset.zero,
                ).evaluate(animation),
                child: frontTitle,
              ),
            ),
          ],
        )
      ]),
    );
  }
}

/// Builds a Backdrop.
///
/// A Backdrop widget has two layers, front and back. The front layer is shown
/// by default, and slides down to show the back layer, from which a user
/// can make a selection. The user can also configure the titles for when the
/// front or back layer is showing.
class Backdrop extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;
  final AnimationController controller;

  const Backdrop({
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
    @required this.controller,
  })  : assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Animation<RelativeRect> layerAnimation;
  final Cubic _accelerateCurve = const Cubic(0.548, 0.0, 0.757, 0.464);
  final Cubic _decelerateCurve = const Cubic(0.23, 0.94, 0.41, 1.0);
  final double _peakVelocityTime = 0.248210;
  final double _peakVelocityProgress = 0.379146;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _frontLayerVisible ? _controller.reverse() : _controller.forward();
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    layerAnimation = _frontLayerVisible ? TweenSequence(
      <TweenSequenceItem<RelativeRect>>[
        TweenSequenceItem<RelativeRect>(
            tween: RelativeRectTween(
              begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerTop - layerSize.height),
              end: RelativeRect.fromLTRB(0.0, layerTop * _peakVelocityProgress, 0.0, (layerTop - layerSize.height) * _peakVelocityProgress),
            ).chain(CurveTween(curve: _decelerateCurve.flipped)),
            weight: 1.0 - _peakVelocityTime),
        TweenSequenceItem<RelativeRect>(
            tween: RelativeRectTween(
              begin: RelativeRect.fromLTRB(0.0, layerTop * _peakVelocityProgress, 0.0, (layerTop - layerSize.height) * _peakVelocityProgress),
              end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
            ).chain(CurveTween(curve: _accelerateCurve.flipped)),
            weight: _peakVelocityTime),
      ],
    ).animate(
      CurvedAnimation(
          parent: _controller.view,
          curve: Interval(0.0, 1.0)
      ),
    ) : TweenSequence(
      <TweenSequenceItem<RelativeRect>>[
        TweenSequenceItem<RelativeRect>(
            tween: RelativeRectTween(
              begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerTop - layerSize.height),
              end: RelativeRect.fromLTRB(0.0, layerTop * _peakVelocityProgress, 0.0, (layerTop - layerSize.height) * _peakVelocityProgress),
            ).chain(CurveTween(curve: _accelerateCurve)),
            weight: _peakVelocityTime),
        TweenSequenceItem<RelativeRect>(
            tween: RelativeRectTween(
              begin: RelativeRect.fromLTRB(0.0, layerTop * _peakVelocityProgress, 0.0, (layerTop - layerSize.height) * _peakVelocityProgress),
              end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
            ).chain(CurveTween(curve: _decelerateCurve)),
            weight: 1.0 - _peakVelocityTime),
      ],
    ).animate(
      CurvedAnimation(
          parent: _controller.view,
          curve: Interval(0.0, 0.78).flipped, //TODO: Update with flipped version
      ),
    );

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        widget.backLayer,
        AnimatedBuilder(
          builder: _buildPositionedTransition,
          animation: layerAnimation,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  Widget _buildPositionedTransition(BuildContext context, Widget child) {
    return PositionedTransition(
      rect: layerAnimation,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      title: _BackdropTitle(
        listenable: _controller.view,
        onPress: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search, semanticLabel: 'login'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.tune, semanticLabel: 'login'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            );
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}
