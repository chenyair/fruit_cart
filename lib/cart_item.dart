import 'package:flutter/material.dart';
import 'package:fruit_cart/main.dart';

import 'fruit.dart';

class CartItem extends StatefulWidget {
  final Fruit fruit;
  final int index;

  CartItem({
    Key? key,
    required this.fruit,
    required this.index,
  }) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> with TickerProviderStateMixin {
  late AnimationController moveController;
  late Animation moveAnimation;
  late Position fromPosition;
  GlobalKey currentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    moveController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    moveAnimation =
        CurvedAnimation(parent: moveController, curve: Curves.easeInOut);
    moveController.forward();
  }

  @override
  Widget build(BuildContext context) {
    fromPosition = widget.fruit.position!;
    return Container(
      key: currentKey,
      height: 120,
      width: 90,
      child: _buildMoving(),
    );
  }

  Widget _buildMoving() {
    return AnimatedBuilder(
        animation: moveAnimation,
        builder: (context, snapshot) {
          Position currentPosition;
          double x = 0, y = 0;
          if (currentKey.currentContext!.findRenderObject() != null) {
            currentPosition = getPositionByKey(currentKey);
            x = fromPosition.x -
                currentPosition.x +
                fromPosition.size.width -
                90;
            y = fromPosition.y - currentPosition.y;
          }
          if (x == 0) return Container();
          return Transform.translate(
            offset: Offset(
                x * (1 - moveAnimation.value), y * (1 - moveAnimation.value)),
            child: _buildCard(),
          );
        });
  }

  Widget _buildCard() {
    return Column(
      children: [
        _buildContainerImage(),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('${widget.fruit.qty}'),
          ),
        )
      ],
    );
  }

  Widget _buildContainerImage() {
    return Container(
      height: 80,
      width: 80,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.fruit.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Image.asset(
        widget.fruit.image,
        width: 40,
        height: 40,
      ),
    );
  }
}
