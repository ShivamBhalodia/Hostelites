import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/FavItem.dart';
import 'package:hostel_app/email_auth.dart';
import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/initial_file.dart';

import 'package:hostel_app/prodTOitem.dart';
import 'package:hostel_app/providers/p_Shopkeeper.dart';
import 'package:hostel_app/providers/p_consumer.dart';
import 'package:hostel_app/providers/p_favs.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';

import 'package:hostel_app/drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: P_Shopkeeper(),
          ),
          ChangeNotifierProvider.value(
            value: P_Consumer(),
          ),
          ChangeNotifierProvider.value(
            value: P_Restuarant(),
          ),
          ChangeNotifierProvider.value(
            value: P_Favs(),
          ),
        ],
        child: MaterialApp(
          title: 'Hostel App',
          theme: ThemeData(
            primarySwatch: Colors.green,
            // canvasColor: Colors.transparent
          ),
          debugShowCheckedModeBanner: false,
          //home: Intro1(),
          home: HomePage(),
          routes: {
            InitializerWidget.routename: (ctx) => InitializerWidget(),
            AuthScreen.routename: (ctx) => AuthScreen(),
            HomePage.routename: (ctx) => HomePage(),
            ProdtoItem.routename: (ctx) => ProdtoItem(),
            AppDrawer.routename: (ctx) => AppDrawer(),
          },
        ));
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: TestGoogleMap(),
    // );
  }
}
