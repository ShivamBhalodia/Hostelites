import 'package:flutter/material.dart';
import 'package:hostel_app/email_auth.dart';
import 'package:hostel_app/initial_file.dart';

class MainPage extends StatelessWidget {
  static final String routename = "/main-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  child: RaisedButton(
                    child: Text('Register/Login as Consumer'),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AuthScreen.routename, arguments: {
                        'flag': 0,
                      });
                    },
                  ),
                ),
                RaisedButton(
                  child: Text('Register/Login as Shopkeeper'),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AuthScreen.routename, arguments: {
                      'flag': 1,
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
