import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hostel_app/FavItem.dart';
import 'package:hostel_app/email_auth.dart';
import 'package:hostel_app/favourite/favourite.dart';
import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/initial_file.dart';
import 'package:hostel_app/itemDetails/details.dart';
import 'package:hostel_app/login_screen.dart';
import 'package:hostel_app/prodTOitem.dart';
import 'package:hostel_app/providers/p_Shopkeeper.dart';
import 'package:hostel_app/providers/p_consumer.dart';
import 'package:hostel_app/providers/p_favs.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:hostel_app/utils/size_config.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return Text('Initial Setup');
          },
        );
      },
    );
  }
}
