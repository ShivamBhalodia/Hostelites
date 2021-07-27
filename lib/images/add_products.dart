// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({Key? key}) : super(key: key);

//   @override
//   _AddProductScreenState createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final _priceFocusNode = FocusNode();
//   final _titleFocusNode = FocusNode();
//   final _categoryFocusNode = FocusNode();
//   final _descriptionFocusNode = FocusNode();
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _initValues = {
//     'title': '',
//     'price': '',
//     'description': '',
//     'imageUrl': '',
//     'category': '',
//   };
//   var _isInit = true;
//   var _isloading = false;
//   File? _image;
//   String dropdownValue = 'One';
//   Future<void> _imgFromCamera() async {
//     File image = await ImagePicker.pickImage(
//         source: ImageSource.camera, imageQuality: 50);

//     setState(() {
//       _image = image;
//     });
//   }

//   Future<void> _imgFromGallery() async {
//     File image = await ImagePicker.pickImage(
//         source: ImageSource.gallery, imageQuality: 50);

//     setState(() {
//       _image = image;
//     });
//   }

//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         _imgFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _imgFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var onChanged;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Products'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _form,
//           child: ListView(
//             children: <Widget>[
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: <Widget>[
//                   Expanded(
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 32,
//                         ),
//                         Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               _showPicker(context);
//                             },
//                             child: CircleAvatar(
//                               radius: 100,
//                               backgroundColor: Color(0xffFDCF09),
//                               child: _image != null
//                                   ? ClipRRect(
//                                       borderRadius: BorderRadius.circular(50),
//                                       child: Image.file(
//                                         _image!,
//                                         width: 150,
//                                         height: 150,
//                                         fit: BoxFit.fitHeight,
//                                       ),
//                                     )
//                                   : Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.grey[200],
//                                           borderRadius:
//                                               BorderRadius.circular(50)),
//                                       width: 100,
//                                       height: 100,
//                                       child: Icon(
//                                         Icons.camera_alt,
//                                         color: Colors.grey[800],
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Divider(),
//               TextFormField(
//                 initialValue: _initValues['title'],
//                 decoration: InputDecoration(labelText: 'Title'),
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.text,
//                 focusNode: _titleFocusNode,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_priceFocusNode);
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please Enter a Title';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {},
//               ),
//               TextFormField(
//                 initialValue: _initValues['price'],
//                 decoration: InputDecoration(labelText: 'Price'),
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.number,
//                 focusNode: _priceFocusNode,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_categoryFocusNode);
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please enter a Price.';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Please enter a valid number.';
//                   }
//                   if (double.parse(value) <= 0) {
//                     return 'Please enter a number greater than 0.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {},
//               ),
//               TextFormField(
//                 initialValue: _initValues['category'],
//                 decoration: InputDecoration(labelText: 'Category'),
//                 textInputAction: TextInputAction.next,
//                 keyboardType: TextInputType.text,
//                 focusNode: _categoryFocusNode,
//                 onFieldSubmitted: (_) {
//                   FocusScope.of(context).requestFocus(_descriptionFocusNode);
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please Enter a Category';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {},
//               ),
//               TextFormField(
//                 initialValue: _initValues['description'],
//                 decoration: InputDecoration(labelText: 'Description'),
//                 //textInputAction: TextInputAction.next,
//                 // maxLines: 3,
//                 keyboardType: TextInputType.multiline,
//                 focusNode: _descriptionFocusNode,
//                 onSaved: (value) {},
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please enter a Description.';
//                   }
//                   if (value.length < 10) {
//                     return 'Should be atleast 10 characters long.';
//                   }
//                   return null;
//                 },
//               ),
              
//               SizedBox(height: 50),
//               FlatButton(
//                 // splashColor: Colors.red,
//                 color: Colors.blue,
//                 // textColor: Colors.white,
//                 child: Text(
//                   'Add',
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
