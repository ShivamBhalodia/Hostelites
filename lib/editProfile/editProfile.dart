import '../models/user.dart';
import './mytextformField.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userModel;
  TextEditingController? phoneNumber;
  TextEditingController? address;
  TextEditingController? userName;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);

  void vaildation() async {
    if (userName!.text.isEmpty && phoneNumber!.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("All Flied Are Empty"),
        ),
      );
    } else if (userName!.text.isEmpty) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Name Is Empty "),
        ),
      );
    } else if (userName!.text.length < 6) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Name Must Be 6 "),
        ),
      );
    } else if (phoneNumber!.text.length < 11 || phoneNumber!.text.length > 11) {
      _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Phone Number Must Be 11 "),
        ),
      );
    } else {
      userDetailUpdate();
    }
  }

  File? _pickedImage;

  // PickedFile? _image;
  // Future<void> getImage({required ImageSource source}) async {
  //   _image = await ImagePicker().getImage(source: source);
  //   if (_image != null) {
  //     setState(() {
  //       _pickedImage = File(_image!.path);
  //     });
  //   }
  // }

  String? userUid;

  Future<String> _uploadImage({File? image}) async {
    String imageUrl =
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FImage&psig=AOvVaw3miOjKNo3wXrL7lH2rU9yC&ust=1624015525371000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPD1krbHnvECFQAAAAAdAAAAABAD";
    return imageUrl;
  }

  bool centerCircle = false;
  var imageMap;
  void userDetailUpdate() async {
    setState(() {
      centerCircle = true;
    });
    _pickedImage != null
        ? imageMap = await _uploadImage(image: _pickedImage)
        : Container();
    setState(() {
      centerCircle = false;
    });
    setState(() {
      edit = false;
    });
  }

  Widget _buildSingleContainer(
      {Color? color, String? startText, String? endText}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        height: 55,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: edit == true ? color : Colors.white,
          borderRadius: edit == false
              ? BorderRadius.circular(30)
              : BorderRadius.circular(0),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startText!,
              style: TextStyle(fontSize: 17, color: Colors.black45),
            ),
            Text(
              endText!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? userImage;
  bool edit = false;
  Widget _buildContainerPart() {
    address = TextEditingController(text: 'userModel.userAddress');
    userName = TextEditingController(text: 'userModel.userName');
    phoneNumber = TextEditingController(text: 'userModel.userPhoneNumber');

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSingleContainer(
            endText: 'userModel!.userName',
            startText: "Name",
          ),
          _buildSingleContainer(
            endText: 'userModel!.userEmail',
            startText: "Email",
          ),
          _buildSingleContainer(
            endText: 'userModel!.usNumber',
            startText: "Phone Number",
          ),
          _buildSingleContainer(
            endText: 'userModel!.userAddress',
            startText: "Address",
          ),
        ],
      ),
    );
  }

  Future<void> myDialogBox(context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  // ListTile(
                  //   leading: Icon(Icons.camera_alt),
                  //   title: Text("Pick Form Camera"),
                  //   onTap: () {
                  //     getImage(source: ImageSource.camera);
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.photo_library),
                  //   title: Text("Pick Form Gallery"),
                  //   onTap: () {
                  //     getImage(source: ImageSource.gallery);
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextFormFliedPart() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyTextFormField(
            name: "UserName",
            controller: userName!,
          ),
          _buildSingleContainer(
            color: Colors.grey[300],
            endText: 'userModel!.userEmail',
            startText: "Email",
          ),
          MyTextFormField(
            name: "Phone Number",
            controller: phoneNumber!,
          ),
          MyTextFormField(
            name: "Address",
            controller: address!,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: Color(0xfff8f8f8),
      appBar: AppBar(
        leading: edit == true
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    edit = false;
                  });
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black45,
                  size: 30,
                ),
                onPressed: () {},
              ),
        backgroundColor: Colors.white,
        actions: [
          edit == false
              ? IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Color(0xff746bc9),
                  ),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 30,
                    color: Color(0xff746bc9),
                  ),
                  onPressed: () {
                    vaildation();
                  },
                ),
        ],
      ),
      body: centerCircle == false
          ? ListView(
              children: [
                Container(
                  height: 603,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    maxRadius: 65,
                                    backgroundImage:
                                        AssetImage("assets/images/lunch.jpeg")),
                              ],
                            ),
                          ),
                          edit == true
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context)
                                              .viewPadding
                                              .left +
                                          220,
                                      top: MediaQuery.of(context)
                                              .viewPadding
                                              .left +
                                          110),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        myDialogBox(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Color(0xff746bc9),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                child: edit == true
                                    ? _buildTextFormFliedPart()
                                    : _buildContainerPart(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: edit == false
                              ? Container(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        edit = true;
                                      });
                                    },
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
