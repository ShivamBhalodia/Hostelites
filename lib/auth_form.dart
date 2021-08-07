import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/providers/p_Shopkeeper.dart';
import 'package:hostel_app/providers/p_consumer.dart';
import 'package:hostel_app/settings.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  int? flag;
  AuthForm(this.flag);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = false;
  String email = '';
  String name = '';
  String password = '';
  String confirmpassword = '';
  String phone = '';
  String c_email = '';
  String c_password = '';
  String c_confirmpassword = '';
  String c_phone = '';

  bool _obpassword = true;
  bool _obpassword1 = true;
  void _togglepassword() {
    setState(() {
      _obpassword = !_obpassword;
    });
  }

  void _togglepasswordnew() {
    setState(() {
      _obpassword1 = !_obpassword1;
    });
  }

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _trySubmit() async {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      print(phone);
      print(confirmpassword);
      print("jainam checking");
      if (isValid) {
        bool isValid = _formKey.currentState!.validate();
        _formKey.currentState!.save();
        if (isValid) {
          await Provider.of<P_Shopkeeper>(context, listen: false)
              .registerShopkeeper(
            phone,
            password,
            confirmpassword,
            name,
            true,
          );
        }
        Navigator.of(context).pushNamed(HomePage.routename);
      }
    }

    void _submit() async {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      print(c_phone);
      print(c_confirmpassword);
      print("jainam checking");
      if (isValid) {
        bool isValid = _formKey.currentState!.validate();
        _formKey.currentState!.save();
        if (isValid) {
          await Provider.of<P_Consumer>(context, listen: false)
              .registerConsumer(
            c_phone,
            c_password,
            c_confirmpassword,
            name,
            false,
          );
        }
        Navigator.of(context).pushNamed(HomePage.routename);
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: !_isLogin ? true : false,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: _isLogin
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (!_isLogin)
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            widget.flag == 0
                                                ? "Register as Shopkeeper in to get started"
                                                : "Register as Consumer in to get started",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      if (_isLogin)
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "Log in to get started",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 15.0),
                                        child: Text(
                                          "Experience the all new App!",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      if (!_isLogin)
                                        TextFormField(
                                          key: ValueKey('Name'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter valid Name!';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                              "assets/images/person-24px (1).png",
                                            ),
                                            labelText: 'Name',
                                          ),
                                          onSaved: (value) {
                                            name = value!;
                                          },
                                        ),
                                      TextFormField(
                                        key: ValueKey('email'),
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !value.contains('@')) {
                                            return 'Enter valid email address!';
                                          }
                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/email-24px.png",
                                          ),
                                          labelText: 'E-mail ID',
                                        ),
                                        onSaved: (value) {
                                          email = value!;
                                        },
                                      ),
                                      if (!_isLogin)
                                        TextFormField(
                                          key: ValueKey('Mobile Number'),
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length != 10) {
                                              return 'Mobile Number must be of 10 digits';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                              "assets/images/phone-24px.png",
                                            ),
                                            labelText: 'Mobile Number',
                                          ),
                                          onSaved: (value) {
                                            phone = value!;
                                          },
                                        ),
                                      TextFormField(
                                        key: ValueKey('password'),
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return 'Password must be atleast 6 characters long!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/Icon ionic-ios-lock.png",
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obpassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black38,
                                            ),
                                            onPressed: _togglepassword,
                                          ),
                                          labelText: 'Password',
                                        ),
                                        obscureText: _obpassword,
                                        onSaved: (value) {
                                          password = value!;
                                        },
                                      ),
                                      if (!_isLogin)
                                        TextFormField(
                                          key: ValueKey('confirm password'),
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                              "assets/images/Icon ionic-ios-lock.png",
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obpassword1
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.black38,
                                              ),
                                              onPressed: _togglepasswordnew,
                                            ),
                                            labelText: 'Confirm Password',
                                          ),
                                          obscureText: _obpassword1,
                                          onSaved: (value) {
                                            confirmpassword = value!;
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value.length < 6) {
                                              return 'Confirm Password must be atleast 6 characters long!';
                                            }
                                            if (value !=
                                                _passwordController.text) {
                                              return 'Password did not match!';
                                            }
                                            return null;
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                // if (widget.isLoading && !_isLogin)
                                //   Center(child: CircularProgressIndicator()),
                                // if (!widget.isLoading && !_isLogin)
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  width: 500,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child:
                                      // widget.isLoading
                                      //     ? Center(
                                      //         child: CircularProgressIndicator(),
                                      //       )
                                      //     :
                                      RaisedButton(
                                    color: Colors.orange,
                                    child: Text(
                                      'REGISTER',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: _trySubmit,
                                  ),
                                ),
                                //if (!widget.isLoading && !_isLogin)
                                FlatButton(
                                  textColor: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _isLogin
                                            ? 'Create new account'
                                            : 'Already have an account?',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        _isLogin ? "" : "Login",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                if (_isLogin)
                                  InkWell(
                                    // onTap: () =>
                                    //     Navigator.of(context).pushNamed(
                                    //   InitializerWidget.routename,
                                    // ),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: 20,
                                      ),
                                      child: Text(
                                        "Use Mobile Number",
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _isLogin
                        ? Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: 500,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                //borderRadius: BorderRadius.circular(60),
                              ),
                              child:
                                  // widget.isLoading
                                  //     ? Center(child: CircularProgressIndicator())
                                  //     :
                                  RaisedButton(
                                color: Colors.orange,
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: _trySubmit,
                              ),
                            ),
                          )
                        : Container()
                  ],
                )
              : Container(
                  padding: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!_isLogin)
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          widget.flag == 1
                                              ? "Register as Shopkeeper in to get started"
                                              : "Register as Consumer in to get started",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    if (_isLogin)
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Log in to get started",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 15.0),
                                      child: Text(
                                        "Experience the all new App!",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    if (!_isLogin)
                                      widget.flag == 1
                                          ? TextFormField(
                                              key: ValueKey('Name'),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter valid Name!';
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                  "assets/images/person-24px (1).png",
                                                ),
                                                labelText: 'Name',
                                              ),
                                              onSaved: (value) {
                                                name = value!;
                                              },
                                            )
                                          : Container(),
                                    if (!_isLogin)
                                      TextFormField(
                                        key: ValueKey('ShopName'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter valid Name!';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/person-24px (1).png",
                                          ),
                                          labelText: widget.flag == 0
                                              ? 'Name'
                                              : 'Shop Name',
                                        ),
                                        onSaved: (value) {
                                          name = value!;
                                        },
                                      ),
                                    if (!_isLogin)
                                      widget.flag == 1
                                          ? TextFormField(
                                              key: ValueKey('Address'),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Enter valid Name!';
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                prefixIcon: Image.asset(
                                                  "assets/images/person-24px (1).png",
                                                ),
                                                labelText: 'Address',
                                              ),
                                              onSaved: (value) {
                                                name = value!;
                                              },
                                            )
                                          : Container(),
                                    widget.flag == 0
                                        ? TextFormField(
                                            key: ValueKey('email'),
                                            validator: (value) {
                                              if (value!.isEmpty ||
                                                  !value.contains('@')) {
                                                return 'Enter valid email address!';
                                              }
                                              return null;
                                            },
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              prefixIcon: Image.asset(
                                                "assets/images/email-24px.png",
                                              ),
                                              labelText: 'E-mail ID',
                                            ),
                                            onSaved: (value) {
                                              c_email = value!;
                                            },
                                          )
                                        : Container(),
                                    if (!_isLogin)
                                      TextFormField(
                                        key: ValueKey('Mobile Number'),
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length != 10) {
                                            return 'Mobile Number must be of 10 digits';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/phone-24px.png",
                                          ),
                                          labelText: 'Mobile Number',
                                        ),
                                        onSaved: (value) {
                                          c_phone = value!;
                                        },
                                      ),
                                    TextFormField(
                                      key: ValueKey('password'),
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            value.length < 6) {
                                          return 'Password must be atleast 6 characters long!';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                          "assets/images/Icon ionic-ios-lock.png",
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obpassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.black38,
                                          ),
                                          onPressed: _togglepassword,
                                        ),
                                        labelText: 'Password',
                                      ),
                                      obscureText: _obpassword,
                                      onSaved: (value) {
                                        c_password = value!;
                                      },
                                    ),
                                    if (!_isLogin)
                                      TextFormField(
                                        key: ValueKey('confirm password'),
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/Icon ionic-ios-lock.png",
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obpassword1
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black38,
                                            ),
                                            onPressed: _togglepasswordnew,
                                          ),
                                          labelText: 'Confirm Password',
                                        ),
                                        obscureText: _obpassword1,
                                        onSaved: (value) {
                                          c_confirmpassword = value!;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length < 6) {
                                            return 'Confirm Password must be atleast 6 characters long!';
                                          }
                                          if (value !=
                                              _passwordController.text) {
                                            return 'Password did not match!';
                                          }
                                          return null;
                                        },
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // if (widget.isLoading && !_isLogin)
                              //   Center(child: CircularProgressIndicator()),
                              // if (!widget.isLoading && !_isLogin)
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                width: 500,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child:
                                    // widget.isLoading
                                    //     ? Center(
                                    //         child: CircularProgressIndicator(),
                                    //       )
                                    //     :
                                    RaisedButton(
                                  color: Colors.orange,
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed:
                                      widget.flag == 1 ? _trySubmit : _submit,
                                ),
                              ),
                              //if (!widget.isLoading && !_isLogin)
                              FlatButton(
                                textColor: Theme.of(context).primaryColor,
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _isLogin
                                          ? 'Create new account'
                                          : 'Already have an account?',
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      _isLogin ? "" : "Login",
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
