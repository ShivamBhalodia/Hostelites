import "package:flutter/material.dart";
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:hostel_app/utils/size_config.dart';
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
          borderRadius: BorderRadius.circular(
              1.66772554003 * SizeConfig.heightMultiplier),
        ),
        elevation: 4,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        1.66772554003 * SizeConfig.heightMultiplier),
                    topRight: Radius.circular(
                        1.66772554003 * SizeConfig.heightMultiplier),
                  ),
                  child: Image.asset(
                    "assets/images/lunch.jpeg",
                    height: 15.0095298602 * SizeConfig.heightMultiplier,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 42.5347222222 * SizeConfig.widthMultiplier,
                    color: Colors.black38,
                    padding: EdgeInsets.symmetric(
                      vertical: 0.55590851334 * SizeConfig.heightMultiplier,
                      horizontal: 1.21527777778 * SizeConfig.widthMultiplier,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            menus.name,
                            style: TextStyle(
                              fontSize:
                                  2.00127064803 * SizeConfig.heightMultiplier,
                              color: Colors.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            menus.price.toString(),
                            style: TextStyle(
                              fontSize:
                                  2.00127064803 * SizeConfig.heightMultiplier,
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
                      padding: EdgeInsets.symmetric(
                          vertical: 0.77827191867 * SizeConfig.heightMultiplier,
                          horizontal:
                              1.21527777778 * SizeConfig.widthMultiplier),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.red,
                          size: 2.77954256671 * SizeConfig.heightMultiplier,
                        ),
                        Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize:
                                1.77890724269 * SizeConfig.heightMultiplier,
                            color: Colors.red,
                          ),
                        ),
                      ]),
                    ),
                    onTap: () {}),
                InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.77827191867 * SizeConfig.heightMultiplier,
                          horizontal:
                              1.21527777778 * SizeConfig.widthMultiplier),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                        size: 3.00190597205 * SizeConfig.heightMultiplier,
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
