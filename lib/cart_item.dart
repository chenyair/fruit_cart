import 'package:flutter/material.dart';

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

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return _buildMoving();
  }

  Widget _buildMoving() {}
}
