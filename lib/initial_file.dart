import 'package:flutter/material.dart';
import 'package:hostel_app/login_screen.dart';

class InitializerWidget extends StatefulWidget {
  static final String routename = "/initial-login-page";
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  // FirebaseAuth _auth;

  // Future<FirebaseUser> _user;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _auth = FirebaseAuth.instance;
    // _user = _auth.currentUser();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
