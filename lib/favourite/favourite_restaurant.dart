import 'package:flutter/material.dart';
import 'package:hostel_app/products.dart';
import 'package:hostel_app/utils/size_config.dart';

class FavouriteRestaurant extends StatefulWidget {
  @override
  _FavouriteRestaurantState createState() => _FavouriteRestaurantState();
}

class _FavouriteRestaurantState extends State<FavouriteRestaurant> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 0.44472681067 * SizeConfig.heightMultiplier,
                horizontal: 0.97222222222 * SizeConfig.widthMultiplier),
            child: Text('Single_productCard'),
            // child: Single_prod(
            //   // id: menu.itemss[index].id,
            // ),
          );
        });
  }
}
