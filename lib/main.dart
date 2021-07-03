import 'package:flutter/material.dart';
import './steps.dart';
import './directionScreen.dart';
import 'package:flutter/material.dart';
import '../blocs/application_bloc.dart';
import '../services/places_service.dart';
import '../src/screens/home_screen.dart';
import 'package:provider/provider.dart';

import './bottom.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: Direction(),
    //     );
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(title: 'Flutter Demo', home: Bottom(), routes: {
        Steps.routeName: (ctx) => Steps(),
        DirectionScreen.routeName: (ctx) => DirectionScreen(),
      }),
    );
  }
}
