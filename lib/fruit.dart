import 'package:flutter/material.dart';

import 'main.dart';

class Fruit {
  String name;
  String image;
  double price;
  int qty = 0;
  Color? color;
  Position? position;
  bool animtae = false;

  Fruit({
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.color,
  });

  set reAnimate(bool animate) => this.animtae = animate;
  set currentPosition(Position position) => this.position = position;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Fruit && other.name == name;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        qty.hashCode ^
        color.hashCode ^
        position.hashCode ^
        animtae.hashCode;
  }
}

List<Fruit> getFruitList() {
  List<Fruit> fruits = [];
  fruits.add(
    Fruit(
      name: 'Apple',
      image: 'images/apple.png',
      price: 52.0,
      qty: 0,
      color: Colors.red,
    ),
  );
  fruits.add(
    Fruit(
      name: 'Banana',
      image: 'images/banana.png',
      price: 30.0,
      qty: 0,
      color: Colors.amber,
    ),
  );
  fruits.add(
    Fruit(
      name: 'Strawberry',
      image: 'images/strawberry.png',
      price: 45.0,
      qty: 0,
      color: Colors.red[300],
    ),
  );
  fruits.add(
    Fruit(
      name: 'Orange',
      image: 'images/orange.png',
      price: 55.0,
      qty: 0,
      color: Colors.orange[300],
    ),
  );
  fruits.add(
    Fruit(
      name: 'Lemon',
      image: 'images/lemon.png',
      price: 60.0,
      qty: 0,
      color: Colors.yellow[600],
    ),
  );
  return fruits;
}
