import 'package:flutter/material.dart';

import 'package:fruit_cart/cart_item.dart';

import 'fruit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController slideController;
  List<Fruit> cartFruits = [];

  @override
  void initState() {
    super.initState();
    slideController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: slideController,
            builder: (context, snapshot) {
              return Positioned(
                width: size.width - (105 * slideController.value),
                height: size.height,
                child: _buildSafeArea(),
              );
            },
          ),
          AnimatedBuilder(
            animation: slideController,
            builder: (context, snapshot) {
              return Positioned(
                right: 102 * (slideController.value),
                child: SafeArea(
                  child: Container(
                    height: size.height,
                    width: 2,
                    color: Colors.grey[400],
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
              animation: slideController,
              builder: (context, snapshot) {
                return Positioned(
                  right: 0,
                  height: size.height,
                  width: 100 * slideController.value,
                  child: _buildSecondList(),
                );
              })
        ],
      ),
    );
  }

  Widget _buildSafeArea() {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20),
          _buildTopBar(),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: getFruitList().map((f) => _buildFruit(f)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  _buildTopBar() {
    return Row(
      children: [
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.search),
              SizedBox(width: 20),
              Text('Search'),
              SizedBox(width: 60)
            ],
          ),
        ),
        SizedBox(width: 20),
        Icon(Icons.local_bar),
        Spacer()
      ],
    );
  }

  Widget _buildFruit(Fruit fruit) {
    GlobalKey key = GlobalKey();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: 10),
        Expanded(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    key: key,
                    color: fruit.color,
                    child: Image.asset(
                      fruit.image,
                      height: 100,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 10),
                    height: 50,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(fruit.name, style: TextStyle(fontSize: 20)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                '\$${fruit.price}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (cartFruits.length == 0) slideController.forward();
                setState(() {
                  fruit.currentPosition = getPositionByKey(key);
                  int index = cartFruits.indexOf(fruit);
                  if (index != -1) {
                    cartFruits[index].qty += 1;
                    cartFruits[index].qty == 2
                        ? cartFruits[index].reAnimate = true
                        : null;
                  } else {
                    fruit.qty = 1;
                    cartFruits.add(fruit);
                  }
                });
              },
              child: Card(
                elevation: 4,
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  color: Colors.white,
                  child: Icon(Icons.add_circle_outline),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildSecondList() {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 24),
          Icon(Icons.shopping_cart),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: cartFruits.length,
              itemBuilder: (context, index) {
                return CartItem(fruit: cartFruits[index], index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Position getPositionByKey(GlobalKey key) {
  RenderBox box = key.currentContext!.findRenderObject()! as RenderBox;
  Size size = box.size;
  Offset position = box.localToGlobal(Offset.zero);
  double x = position.dx;
  double y = position.dy;
  return Position(x: x, y: y, size: size);
}

class Position {
  double x;
  double y;
  Size size;
  Position({
    required this.x,
    required this.y,
    required this.size,
  });
}
