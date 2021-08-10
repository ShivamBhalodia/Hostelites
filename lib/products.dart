import 'package:flutter/material.dart';
import 'package:hostel_app/itemList/itemList.dart';
import 'package:hostel_app/prodTOitem.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';

class Single_prod extends StatelessWidget {
  final int id;
  Single_prod({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final shop = Provider.of<P_Restuarant>(context).findByIdShop(id);
    return Card(
      child: Hero(
        tag: shop.r_name,
        child: Material(
          child: InkWell(
            onTap: () {
              print("jainam");
              print(id);
              Navigator.of(context).pushNamed(
                ProdtoItem.routename,
                arguments: {
                  'sid': id,
                },
              );
            },
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    shop.o_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(Icons.favorite_border),
                ),
              ),
              child: Image.network(
                "https://i.pinimg.com/736x/f2/fd/b4/f2fdb4f12c97f857da3fa4e1d19f1128.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
