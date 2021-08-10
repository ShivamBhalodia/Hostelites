import "package:flutter/material.dart";
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';

class FoodItemCard extends StatelessWidget {
  final int id;
  // final String title = "Pizza";
  // final String description = "";
  // final String price = '\$100';

  FoodItemCard({
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    print("inside foodItemCard");
    print(id);
    final menus = Provider.of<P_Restuarant>(context).findByIdItems(id);
    print(menus.name);
    return InkWell(
      onTap: () => null,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    "assets/images/lunch.jpeg",
                    height: 135,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 175,
                    color: Colors.black38,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            menus.name,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            menus.price.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ]),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.red,
                          size: 25.0,
                        ),
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.red,
                          ),
                        ),
                      ]),
                    ),
                    onTap: () {}),
                InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                        size: 27,
                      ),
                    ),
                    onTap: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }
}
