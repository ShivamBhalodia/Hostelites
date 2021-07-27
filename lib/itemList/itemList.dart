import 'package:flutter/material.dart';

import './food_item_card.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage();
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // the scaffold global key
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _explorePageScaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.restaurant,
                                color: Colors.yellow,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Burger king',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color(0xFF3a3a3b),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            'Ahmedabad, Gujarat',
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF3a3a3b),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      )),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.asset("assets/images/lunch.jpeg",
                        fit: BoxFit.cover, width: 100, height: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 6,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 6,
              margin: EdgeInsets.symmetric(vertical: 15),
            ),
            Center(
                child: Text(
              'Menu',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            )),
            Expanded(
              child: Card(
                elevation: 0,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    FoodItemCard(),
                    FoodItemCard(),
                    FoodItemCard(),
                    FoodItemCard(),
                    FoodItemCard(),
                    FoodItemCard(),
                    FoodItemCard(),
                    FoodItemCard(),
                    FoodItemCard(),
                    FoodItemCard()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
