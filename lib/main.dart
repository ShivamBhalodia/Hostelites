import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/email_auth.dart';
import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/initial_file.dart';
import 'package:hostel_app/login_screen.dart';
import 'package:hostel_app/mainpage.dart';
import 'package:hostel_app/providers/p_Shopkeeper.dart';
import 'package:hostel_app/providers/p_consumer.dart';
import 'package:hostel_app/settings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
      ],
      child: MaterialApp(
        title: 'Hostel App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          // canvasColor: Colors.transparent
        ),
        debugShowCheckedModeBanner: false,
        //home: Intro1(),
        home: MainPage(),
        routes: {
          InitializerWidget.routename: (ctx) => InitializerWidget(),
          AuthScreen.routename: (ctx) => AuthScreen(),
          SettingsScreen.routename: (ctx) => SettingsScreen(),
          HomePage.routename: (ctx) => HomePage(),
        },
      ),
    );
  }
}
