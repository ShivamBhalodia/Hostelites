import 'package:flutter/material.dart';
import 'package:hostel_app/homepage.dart';
import 'package:hostel_app/itemList/food_item_card.dart';
import 'package:hostel_app/providers/p_favs.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';

class FavItemsScreen extends StatefulWidget {
  //static final String routename = "/item-list";

  @override
  _FavItemsScreenState createState() => _FavItemsScreenState();
}

class _FavItemsScreenState extends State<FavItemsScreen> {
  // the scaffold global key
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

  bool initial = true;
  bool isLoading = false;
  bool isLoad = false;

  late String search;

  ScrollController _scrollController = new ScrollController();
  ScrollController _search = new ScrollController();
  TextEditingController _controller = TextEditingController();

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   print("didchange called");
  //   if (initial) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     Provider.of<P_Favs>(context, listen: false).fetchFavItems().then((value) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       initial = false;
  //     }).catchError((onerror) {
  //       print("error is");
  //       print(onerror);
  //       setState(() {
  //         isLoading = false;
  //       });

  //       const errorMessage = 'Something went wrong. Please try again later';
  //       //return showErrorDialoug(1, errorMessage, context);
  //     });
  //   }
  // }

  void onSubmitted(String value) {
    setState(() => _explorePageScaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('Hostel-App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            // do something
          },
        ),
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //final shop = Provider.of<P_Restuarant>(context).findByIdShop(widget.shopid);
    return Scaffold(
      key: _explorePageScaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 52,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(4, 4), blurRadius: 5)
            ]),
            child: Row(
              children: [
                Container(
                  height: 100,
                  // width: maxW * 0.1,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 25,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Favorite Items"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
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
                                      "shop.r_name",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFF3a3a3b),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  "shop.address",
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 15),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Card(
                        elevation: 0,
                        child: Consumer<P_Restuarant>(
                          builder: (context, menu, _) => GridView.builder(
                              itemCount: menu.itemss.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return menu.itemss.length == 0
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: FoodItemCard(
                                          id: menu.itemss[index].id,
                                        ),
                                      );
                              }),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
