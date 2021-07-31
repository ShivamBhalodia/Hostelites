import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/email_auth.dart';
import 'package:hostel_app/initial_file.dart';
import 'package:hostel_app/login_screen.dart';
import 'package:hostel_app/mainpage.dart';
import 'package:hostel_app/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      routes: {
        InitializerWidget.routename: (ctx) => InitializerWidget(),
        AuthScreen.routename: (ctx) => AuthScreen(),
      },
    );
  }
}
