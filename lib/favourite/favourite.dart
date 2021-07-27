import 'package:flutter/material.dart';
import 'package:hostel_app/favourite/favourite_item.dart';
import 'package:hostel_app/favourite/favourite_restaurant.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Favourites'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.restaurant_sharp),
                text: 'Favourite Restaurants',
              ),
              Tab(
                icon: Icon(
                  Icons.fastfood,
                ),
                text: 'Favourite Items',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            FavouriteRestaurant(),
            FavouriteItem(),
          ],
        ),
      ),
    );
  }
}
