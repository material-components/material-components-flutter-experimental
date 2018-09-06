import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

import 'colors.dart';
import 'model/app_state_model.dart';
import 'model/product.dart';
import 'shopping_cart.dart';

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

class ShortBottomSheet extends StatefulWidget {
  const ShortBottomSheet({ Key key, @required this.hideController })
      : assert(hideController != null),
        super(key: key);

  final AnimationController hideController;

  @override
  _ShortBottomSheetState createState() => _ShortBottomSheetState();

  static _ShortBottomSheetState of(BuildContext context, { bool isNullOk: false }) {
    assert(isNullOk != null);
    assert(context != null);
    final _ShortBottomSheetState result = context
        .ancestorStateOfType(const TypeMatcher<_ShortBottomSheetState>());
    if (isNullOk || result != null) {
      return result;
    }
    throw FlutterError(
      'ShortBottomSheet.of() called with a context that does not contain a ShortBottomSheet.\n'
    );
  }
}

class _ShortBottomSheetState extends State<ShortBottomSheet> with TickerProviderStateMixin {
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

  // Returns the correct width of the ShortBottomSheet based on the number of
  // products in the cart.
  double _widthFor(int numProducts) {
    switch (numProducts) {
      case 0:
        return 64.0;
        break;
      case 1:
        return 136.0;
        break;
      case 2:
        return 192.0;
        break;
      case 3:
        return 248.0;
        break;
      default:
        return 278.0;
    }
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

  // Changes the padding between the start edge of the Material and the cart icon
  // based on the number of products in the cart (padding increases when > 0
  // products.)
  EdgeInsetsDirectional _cartPaddingFor(int numProducts) {
    if (numProducts == 0) {
      return EdgeInsetsDirectional.only(start: 20.0, end: 8.0);
    } else {
      return EdgeInsetsDirectional.only(start: 32.0, end: 8.0);
    }
  }

  bool get _cartIsVisible => _thumbnailOpacityAnimation.value == 0.0;

  Widget _buildThumbnails(int numProducts) {
    return ExcludeSemantics(
      child: Opacity(
        opacity: _thumbnailOpacityAnimation.value,
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            AnimatedPadding(
              padding: _cartPaddingFor(numProducts),
              child: Icon(Icons.shopping_cart),
              duration: Duration(milliseconds: 225),
            ),
            Container(
              width: ScopedModel.of<AppStateModel>(context)
                          .productsInCart
                          .keys
                          .length > 3
                  ? _width - 94 // Accounts for the overflow number
                  : _width - 64,
              height: _kCartHeight,
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: ProductThumbnailRow(),
            ),
            ExtraProductsNumber()
          ]),
          // Ensures the thumbnails are "pinned" to the top left when opening the
          // sheet by filling the space beneath them.
          Expanded(child: Container())
        ]),
      ),
    );
  }

  Widget _buildShoppingCartPage() {
    return Opacity(
      opacity: _cartOpacityAnimation.value,
      child: ShoppingCartPage(),
    );
  }

  Widget _buildCart(BuildContext context, Widget child) {
    // numProducts is the number of different products in the cart (does not
    // include multiples of the same product).
    final AppStateModel model = ScopedModel.of<AppStateModel>(context);
    final int numProducts = model.productsInCart.keys.length;
    final int totalCartQuantity = model.totalCartQuantity;
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    _width = _widthFor(numProducts);
    _widthAnimation = _getWidthAnimation(screenWidth);
    _heightAnimation = _getHeightAnimation(screenHeight);
    _shapeAnimation = _getShapeAnimation();
    _thumbnailOpacityAnimation = _getThumbnailOpacityAnimation();
    _cartOpacityAnimation = _getCartOpacityAnimation();

    return Semantics(
      button: true,
      value: "Shopping cart, $totalCartQuantity items",
      child: Container(
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
          color: kShrinePink50,
          child: _cartIsVisible
              ? _buildShoppingCartPage()
              : _buildThumbnails(numProducts),
        ),
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
            child: ScopedModelDescendant<AppStateModel>(
              builder: (context, child, model) => AnimatedBuilder(
                builder: _buildCart,
                animation: _controller,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductThumbnailRow extends StatefulWidget {
  @override
  _ProductThumbnailRowState createState() => _ProductThumbnailRowState();
}

class _ProductThumbnailRowState extends State<ProductThumbnailRow> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // _list represents the list that actively manipulates the AnimatedList,
  // meaning that it needs to be updated by _internalList
  ListModel _list;
  // _internalList represents the list as it is updated by the AppStateModel
  List<int> _internalList;

  @override
  void initState() {
    super.initState();
    _list = ListModel(
      listKey: _listKey,
      initialItems:
          ScopedModel.of<AppStateModel>(context).productsInCart.keys.toList(),
      removedItemBuilder: _buildRemovedThumbnail,
    );
    _internalList = List<int>.from(_list.list);
  }

  Widget _buildRemovedThumbnail(
      int item, BuildContext context, Animation<double> animation) {
    return ProductThumbnail(animation, animation,
        ScopedModel.of<AppStateModel>(context).getProductById(item));
  }

  Widget _buildThumbnail(
      BuildContext context, int index, Animation<double> animation) {
    Animation<double> thumbnailSize =
        Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        curve: Interval(
          0.33,
          1.0,
          curve: Curves.easeIn,
        ),
        parent: animation,
      ),
    );

    Animation<double> opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          curve: Interval(
            0.33,
            1.0,
            curve: Curves.linear,
          ),
          parent: animation),
    );

    AppStateModel model = ScopedModel.of<AppStateModel>(context);
    int productId = _list[index];
    Product product = model.getProductById(productId);
    assert(product != null);

    return ProductThumbnail(thumbnailSize, opacity, product);
  }

  // If the lists are the same length, assume nothing has changed.
  // If the internalList is shorter than the ListModel, an item has been removed.
  // If the internalList is longer, then an item has been added.
  void _updateLists() {
    // Update _internalList based on the model
    _internalList =
        ScopedModel.of<AppStateModel>(context).productsInCart.keys.toList();
    while (_internalList.length != _list.length) {
      int index = 0;
      // Check bounds and that the list elements are the same
      while (_internalList.length > 0 &&
          _list.length > 0 &&
          index < _internalList.length &&
          index < _list.length &&
          _internalList[index] == _list[index]) {
        index++;
      }

      if (_internalList.length < _list.length) {
        _list.removeAt(index);
      } else if (_internalList.length > _list.length) {
        _list.insert(_list.length, _internalList[index]);
      }
    }
  }

  Widget _buildAnimatedList() {
    return AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      itemBuilder: _buildThumbnail,
      initialItemCount: _list.length,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(), // Cart shouldn't scroll
    );
  }

  @override
  Widget build(BuildContext context) {
    _updateLists();
    return ScopedModelDescendant<AppStateModel>(
        builder: (context, child, model) => _buildAnimatedList());
  }
}

class ExtraProductsNumber extends StatelessWidget {
  // Calculates the number to be displayed at the end of the row if there are
  // more than three products in the cart. This calculates overflow products,
  // including their duplicates (but not duplicates of products shown as
  // thumbnails).
  int _calculateOverflow(AppStateModel model) {
    Map<int, int> productMap = model.productsInCart;
    // List created to be able to access products by index instead of ID.
    // Order is guaranteed because productsInCart returns a LinkedHashMap.
    List<int> products = productMap.keys.toList();
    int overflow = 0;
    int numProducts = products.length;
    if (numProducts > 3) {
      for (int i = 3; i < numProducts; i++) {
        overflow += productMap[products[i]];
      }
    }
    return overflow;
  }

  Widget _buildOverflow(AppStateModel model, BuildContext context) {
    if (model.productsInCart.length > 3) {
      int numOverflowProducts = _calculateOverflow(model);
      // Maximum of 99 so padding doesn't get messy.
      int displayedOverflowProducts =
          numOverflowProducts <= 99 ? numOverflowProducts : 99;
      return Container(
        child: Text('+$displayedOverflowProducts',
            style: Theme.of(context).primaryTextTheme.button),
      );
    } else {
      return Container(); // build() can never return null.
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppStateModel>(
        builder: (builder, child, model) => _buildOverflow(model, context));
  }
}

class ProductThumbnail extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> opacityAnimation;
  final Product product;

  ProductThumbnail(this.animation, this.opacityAnimation, this.product);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: ScaleTransition(
        scale: animation,
        child: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage(
                product.assetName, // asset name
                package: product.assetPackage, // asset package
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          margin: EdgeInsets.only(left: 16.0),
        ),
      ),
    );
  }
}

// ListModel manipulates an internal list and an AnimatedList
class ListModel {
  ListModel(
      {@required this.listKey,
      @required this.removedItemBuilder,
      Iterable<int> initialItems})
      : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<int>.from(initialItems ?? <int>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<int> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, int item) {
    _items.insert(index, item);
    _animatedList.insertItem(index, duration: Duration(milliseconds: 225));
  }

  int removeAt(int index) {
    final int removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
  }

  int get length => _items.length;

  int operator [](int index) => _items[index];

  int indexOf(int item) => _items.indexOf(item);

  List<int> get list => _items;
}
