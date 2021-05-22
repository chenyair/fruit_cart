import 'package:flutter/material.dart';

class Fruit {
  String name;
  String image;
  double price;
  int qty = 0;
  Color? color;

  Fruit({
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
    required this.color,
  });
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
