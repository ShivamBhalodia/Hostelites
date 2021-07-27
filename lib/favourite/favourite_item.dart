import 'package:flutter/material.dart';
import 'package:hostel_app/itemList/food_item_card.dart';
import 'package:hostel_app/utils/size_config.dart';

class FavouriteItem extends StatefulWidget {
  @override
  _FavouriteItemState createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
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
            child: Text('FoodItemCard'),
            // child: FoodItemCard(
            //   // id: menu.itemss[index].id,
            // ),
          );
        });
  }
}
