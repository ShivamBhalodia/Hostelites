import 'package:flutter/material.dart';
import './direction.dart';

class DirectionScreen extends StatelessWidget {
  // const DirectionScreen({ Key key }) : super(key: key);

  static const routeName = '/direction';
  @override
  Widget build(BuildContext context) {
    var detail =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Direction(
      source: detail["source"],
      destination: detail["destination"],
    );
  }
}
