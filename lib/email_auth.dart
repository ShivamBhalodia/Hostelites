import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/auth_form.dart';

class AuthScreen extends StatefulWidget {
  static final String routename = "/email-auth-page";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // final _auth = FirebaseAuth.instance;
  // var _isLoading = false;

  // void _submitAuthForm(
  //   String email,
  //   String password,
  //   String username,
  //   String confirmpassword,
  //   String phonenumber,
  //   bool isLogin,
  //   BuildContext ctx,
  // ) async {
  //   AuthResult authResult;
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     if (isLogin) {
  //       authResult = await _auth.signInWithEmailAndPassword(
  //           email: email, password: password);
  //     } else {
  //       authResult = await _auth.createUserWithEmailAndPassword(
  //           email: email, password: password);

  //       //extra user data
  //       await Firestore.instance
  //           .collection('users')
  //           .document(authResult.user.uid)
  //           .setData({
  //         'username': username,
  //         'email': email,
  //         'phone number': phonenumber,
  //       });
  //     }
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } on PlatformException catch (error) {
  //     var message = 'An error occured, please check your credentials!';

  //     if (error.message != null) {
  //       message = error.message!;
  //     }

  //     Scaffold.of(ctx).showSnackBar(SnackBar(
  //       content: Text(message),
  //       backgroundColor: Theme.of(ctx).errorColor,
  //     ));
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } catch (error) {
  //     print(error);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final details =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    int? id = details['flag'];
    return AuthForm(id);
  }
}
