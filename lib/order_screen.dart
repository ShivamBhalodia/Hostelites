import 'package:flutter/material.dart';
import 'package:hostel_app/order_item.dart';
import 'drawer.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView(
        children: <Widget>[
          OrderItem(),
          OrderItem(),
          OrderItem(),
        ],
      ),
    );
  }
}