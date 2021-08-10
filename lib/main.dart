import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/email_auth.dart';
import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/initial_file.dart';
import 'package:hostel_app/login_screen.dart';
import 'package:hostel_app/mainpage.dart';
import 'package:hostel_app/providers/p_Shopkeeper.dart';
import 'package:hostel_app/providers/p_consumer.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hostel_app/drawer.dart';
import 'package:hostel_app/google_map.dart';
import 'package:hostel_app/horizontal_list.dart';
import 'package:hostel_app/images/add_products.dart';
import 'package:hostel_app/order_screen.dart';
import 'package:hostel_app/products.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'google_map.dart';
import 'cart/cart.dart';
import 'itemDetails/details.dart';
import 'editProfile/editProfile.dart';
import './itemList/itemList.dart';

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
            //SettingsScreen.routename: (ctx) => SettingsScreen(),
            HomePage.routename: (ctx) => HomePage(),
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
