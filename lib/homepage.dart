import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final String routename = "/home-page";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
