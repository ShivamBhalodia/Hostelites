import 'package:flutter/material.dart';
import 'package:hostel_app/itemList/itemList.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';

class ProdtoItem extends StatefulWidget {
  static final String routename = "/prod-item";
  const ProdtoItem({Key? key}) : super(key: key);

  @override
  _ProdtoItemState createState() => _ProdtoItemState();
}

class _ProdtoItemState extends State<ProdtoItem> {
  @override
  Widget build(BuildContext context) {
    final details =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    int? id = details['sid'];
    print("inside itemList");
    print(id);

    //print(Provider.of<P_Restuarant>(context, listen: false).itemss);

    return ItemList(id!);
  }
}
