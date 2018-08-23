import 'package:flutter/services.dart';

import 'model/app_state_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:meta/meta.dart';
import 'colors.dart';
import 'shopping_cart.dart';
import 'model/product.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'dart:async';

class ShortBottomSheet extends StatefulWidget {
  final AnimationController hideController;
  const ShortBottomSheet({Key key, this.hideController}) : super(key: key);

  @override
  _ShortBottomSheetState createState() => _ShortBottomSheetState();

  static _ShortBottomSheetState of(BuildContext context, {bool nullOk: false}) {
    assert(nullOk != null);
    assert(context != null);
    final _ShortBottomSheetState result = context
        .ancestorStateOfType(const TypeMatcher<_ShortBottomSheetState>());
    if (nullOk || result != null) {
      return result;
    }
    throw FlutterError(
        'ShortBottomSheet.of() called with a context that does not contain a ShortBottomSheet.\n');
  }
}

class _ShortBottomSheetState extends State<ShortBottomSheet>
    with TickerProviderStateMixin {
  final GlobalKey _shortBottomSheetKey =
      GlobalKey(debugLabel: 'Short bottom sheet');
  // The padding between the left edge of the Material and the shopping cart icon
  double _cartPadding;
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
  // Curves that represent the two curves that compose the emphasized easing curve.
  final Cubic _accelerateCurve = const Cubic(0.3, 0.0, 0.8, 0.15);
  final Cubic _decelerateCurve = const Cubic(0.05, 0.7, 0.1, 1.0);
  final _cartHeight = 56.0;

  @override
  void initState() {
    super.initState();
    _adjustCartPadding(0);
    _updateWidth(0);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Updates the animations for the opening/closing of the ShortBottomSheet,
  // using the size of the screen.
  void _updateAnimations(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double mediaWidth = screenSize.width;
    double mediaHeight = screenSize.height;

    _widthAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          // 1/6 of duration = 40% (0.4) of property delta
          tween: Tween<double>(
                  begin: _width, end: _width + (mediaWidth - _width) * 0.4)
              .chain(CurveTween(curve: _accelerateCurve)),
          weight: 1.0 / 6.0,
        ),
        new TweenSequenceItem<double>(
          tween: Tween<double>(
                  begin: _width + (mediaWidth - _width) * 0.4, end: mediaWidth)
              .chain(CurveTween(curve: _decelerateCurve)),
          weight: 5.0 / 6.0,
        ),
      ],
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: _controller.status == AnimationStatus.forward
              ? Interval(0.0, 0.35)
              : Interval(0.17, 0.72)),
    );

    _heightAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(
                  begin: _cartHeight, end: (mediaHeight - _cartHeight) * 0.4)
              .chain(CurveTween(curve: _accelerateCurve)),
          weight: 1.0 / 6.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(
                  begin: (mediaHeight - _cartHeight) * 0.4, end: mediaHeight)
              .chain(CurveTween(curve: _decelerateCurve)),
          weight: 5.0 / 6.0,
        ),
      ],
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: _controller.status == AnimationStatus.forward
              ? Interval(0.0, 1.0)
              : Interval(0.2, 1.0)),
    );

    _thumbnailOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: _controller.status == AnimationStatus.forward
              ? Interval(0.0, 0.25, curve: Curves.linear)
              : Interval(0.25, 0.75, curve: Curves.linear)),
    );

    _cartOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: _controller.status == AnimationStatus.forward
              ? Interval(0.25, 0.75, curve: Curves.linear)
              : Interval(0.75, 1.0, curve: Curves.linear)),
    );

    _shapeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 24.0, end: (24.0 - 0.0) * 0.4)
              .chain(CurveTween(curve: _accelerateCurve)),
          weight: 1.0 / 6.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: (24.0 - 0.0) * 0.4, end: 0.0)
              .chain(CurveTween(curve: _decelerateCurve)),
          weight: 5.0 / 6.0,
        ),
      ],
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: _controller.status == AnimationStatus.forward
              ? Interval(0.0, 0.35)
              : Interval(0.17, 0.72)),
    );
  }

  // Returns the correct width of the ShortBottomSheet based on the number of
  // products in the cart.
  double _getWidth(int numProducts) {
    if (numProducts == 0) {
      return 64.0;
    } else if (numProducts == 1) {
      return 136.0;
    } else if (numProducts == 2) {
      return 192.0;
    } else if (numProducts == 3) {
      return 248.0;
    } else {
      return 278.0;
    }
  }

  // Updates _width based on the number of products in the cart.
  void _updateWidth(int numProducts) {
    _width = _getWidth(numProducts);
  }

  // Returns true if the cart is open and false otherwise.
  bool get _isOpen {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  // Opens the ShortBottomSheet if it's open, otherwise does nothing.
  void open() {
    if (!_isOpen) {
      setState(() {
        _controller.forward();
      });
    }
  }

  // Closes the ShortBottomSheet if it's open, otherwise does nothing.
  void close() {
    if (_isOpen) {
      setState(() {
        _controller.reverse();
      });
    }
  }

  // Changes the padding between the left edge of the Material and the cart icon
  // based on the number of products in the cart (padding increases when > 0
  // products.)
  void _adjustCartPadding(int numProducts) {
    _cartPadding = numProducts == 0 ? 20.0 : 32.0;
  }

  bool _revealCart() {
    if (_thumbnailOpacityAnimation.value == 0.0) {
      return true;
    } else {
      return false;
    }
  }

  Widget _buildThumbnails(int numProducts) {
    return ExcludeSemantics(
      child: Opacity(
        opacity: _thumbnailOpacityAnimation.value,
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            AnimatedPadding(
                padding: EdgeInsets.only(left: _cartPadding, right: 8.0),
                child: Icon(
                  Icons.shopping_cart,
                ),
                duration: Duration(milliseconds: 225)),
            Container(
              width: ModelFinder<AppStateModel>()
                          .of(context)
                          .productsInCart
                          .keys
                          .length >
                      3
                  ? _width - 94 // Accounts for the overflow number
                  : _width - 64,
              height: _cartHeight,
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: ProductList(),
              ),
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
        opacity: _cartOpacityAnimation.value, child: ShoppingCartPage());
  }

  Widget _buildCart(BuildContext context, Widget child) {
    // numProducts is the number of different products in the cart (does not
    // include multiple of the same product).
    AppStateModel model = ModelFinder<AppStateModel>().of(context);
    int numProducts = model.productsInCart.keys.length;
    int totalCartQuantity = model.totalCartQuantity;

    _adjustCartPadding(numProducts);
    _updateWidth(numProducts);
    _updateAnimations(context);

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
            child: _revealCart()
                ? _buildShoppingCartPage()
                : _buildThumbnails(numProducts)),
      ),
    );
  }

  // Closes the cart if the cart is open, otherwise exits the app (this should
  // only be relevant for Android).
  Future<bool> _onWillPop() {
    if (_isOpen) {
      close();
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Animation<Offset> offsetRect =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(1.0, 0.0)).animate(
            CurvedAnimation(
                parent: widget.hideController.view, curve: Curves.easeOut));
    timeDilation = 1.0;

    return AnimatedSize(
      key: _shortBottomSheetKey,
      duration: Duration(milliseconds: 225),
      curve: Curves.easeInOut,
      vsync: this,
      alignment: FractionalOffset.topLeft,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: SlideTransition(
          position: offsetRect,
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

class ProductList extends StatefulWidget {
  @override
  ProductListState createState() {
    return ProductListState();
  }
}

class ProductListState extends State<ProductList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // _list represents the list that actively manipulates the AnimatedList,
  // meaning that it needs to be updated by _internalList
  ListModel _list;
  // internalList represents the list as it is updated by the AppStateModel
  List<int> _internalList;

  @override
  void initState() {
    super.initState();
    _list = ListModel(
      listKey: _listKey,
      initialItems:
          ModelFinder<AppStateModel>().of(context).productsInCart.keys.toList(),
      removedItemBuilder: _buildRemovedThumbnail,
    );
    _internalList = List<int>.from(_list.list);
  }

  Widget _buildRemovedThumbnail(
      int item, BuildContext context, Animation<double> animation) {
    return ProductThumbnail(animation, animation,
        ModelFinder<AppStateModel>().of(context).getProductById(item));
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

    AppStateModel model = ModelFinder<AppStateModel>().of(context);
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
        ModelFinder<AppStateModel>().of(context).productsInCart.keys.toList();
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
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                margin: EdgeInsets.only(left: 16.0))));
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
