import 'package:flutter/material.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:hostel_app/utils/size_config.dart';
import 'package:provider/provider.dart';
import './food_item_card.dart';

class ItemList extends StatefulWidget {
  //static final String routename = "/item-list";
  int shopid;
  ItemList(this.shopid);
  @override
  _ItemListState createState() => _ItemListState();
}

int sid = 0;

class _ItemListState extends State<ItemList> {
  // the scaffold global key
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

  bool initial = true;
  bool isLoading = false;
  bool isLoad = false;

  late String search;
  bool isSearch = false;

  void allotingserach(String searchstring) {
    print("search is $searchstring");
    print("allotingserach");
    if (searchstring.isEmpty) {
      setState(() {
        isSearch = false;
      });
      return;
    }
    print("isSearch is true");
    print("initstate Shoplistmain widget.isSearch");
    setState(() {
      isLoad = true;
      search = searchstring;
      isSearch = true;
    });
    Provider.of<P_Restuarant>(context, listen: false)
        .searchfromitems(search, widget.shopid);
    Provider.of<P_Restuarant>(context, listen: false)
        .searchShop(search)
        .then((value) {
      print("then value in p_shop search");
      setState(() {
        isLoad = false;
      });
    }).catchError((onError) {
      setState(() {
        isLoad = false;
      });
    });
  }

  ScrollController _scrollController = new ScrollController();
  ScrollController _search = new ScrollController();
  TextEditingController _controller = TextEditingController();

  void initState() {
    // TODO: implement initState
    print("shoplistmain inistate before");
    sid = widget.shopid;
    super.initState();
    print("initstate of Shoplistmain");

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        try {
          Provider.of<P_Restuarant>(context, listen: false)
              .fetchItems(widget.shopid)
              .then((value) {
            setState(() {
              isLoading = false;
            });
          });
        } catch (error) {
          setState(() {
            isLoading = false;
          });
          //showErrorDialoug(2, "Something went wrong, try again", context);
        }
      }
    });
    _search.addListener(() {
      if (_search.position.pixels == _search.position.maxScrollExtent) {
        setState(() {
          isLoad = true;
        });

        Provider.of<P_Restuarant>(context, listen: false)
            .searchfromitems(_controller.text, widget.shopid)
            .then((value) {
          setState(() {
            isLoad = false;
          });
        }).catchError((onerror) {
          setState(() {
            isLoad = false;
          });
          const errorMessage = 'Something went wrong.Please try again later';
          //return showErrorDialoug(2, errorMessage, context);
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didchange called");
    if (initial) {
      setState(() {
        isLoading = true;
      });
      Provider.of<P_Restuarant>(context, listen: false)
          .fetchItems(widget.shopid)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        initial = false;
      }).catchError((onerror) {
        print("error is");
        print(onerror);
        setState(() {
          isLoading = false;
        });

        const errorMessage = 'Something went wrong. Please try again later';
        //return showErrorDialoug(1, errorMessage, context);
      });
    }
  }

  void onSubmitted(String value) {
    setState(() => _explorePageScaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  SearchBar? searchBar = null;

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
    return Scaffold(
      key: _explorePageScaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 5.78144853875 * SizeConfig.heightMultiplier,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.97222222222 * SizeConfig.widthMultiplier,
                      0.44472681067 * SizeConfig.heightMultiplier),
                  blurRadius: 0.55590851334 * SizeConfig.heightMultiplier)
            ]),
            child: Row(
              children: [
                Container(
                  height: 11.1181702668 * SizeConfig.heightMultiplier,
                  // width: maxW * 0.1,
                  padding: EdgeInsets.symmetric(
                      horizontal: 3.64583333333 * SizeConfig.widthMultiplier,
                      vertical: 1.11181702668 * SizeConfig.heightMultiplier),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isSearch = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 2.77954256671 * SizeConfig.heightMultiplier,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(
                          3.64583333333 * SizeConfig.widthMultiplier,
                          1.11181702668 * SizeConfig.heightMultiplier,
                          0,
                          1.11181702668 * SizeConfig.heightMultiplier),
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              3.64583333333 * SizeConfig.widthMultiplier),
                      child: SearchBar(
                        allotSearch: allotingserach,
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.64583333333 * SizeConfig.widthMultiplier),
              child: Column(
                children: <Widget>[
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left:
                                    2.43055555556 * SizeConfig.widthMultiplier),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.restaurant,
                                      color: Colors.yellow,
                                      size: 3.33545108005 *
                                          SizeConfig.heightMultiplier,
                                    ),
                                    SizedBox(
                                        width: 2.43055555556 *
                                            SizeConfig.widthMultiplier),
                                    Text(
                                      "shop.r_name",
                                      style: TextStyle(
                                          fontSize: 2.77954256671 *
                                              SizeConfig.heightMultiplier,
                                          color: Color(0xFF3a3a3b),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Text(
                                  "shop.address",
                                  style: TextStyle(
                                      fontSize: 1.66772554003 *
                                          SizeConfig.heightMultiplier,
                                      color: Color(0xFF3a3a3b),
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                        Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.asset("assets/images/lunch.jpeg",
                              fit: BoxFit.cover,
                              width: 24.3055555556 * SizeConfig.widthMultiplier,
                              height:
                                  11.1181702668 * SizeConfig.heightMultiplier),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                2.22363405337 * SizeConfig.heightMultiplier),
                          ),
                          elevation: 6,
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  4.86111111111 * SizeConfig.widthMultiplier,
                              vertical:
                                  1.66772554003 * SizeConfig.heightMultiplier),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          2.22363405337 * SizeConfig.heightMultiplier),
                    ),
                    elevation: 6,
                    margin: EdgeInsets.symmetric(
                        vertical: 1.66772554003 * SizeConfig.heightMultiplier),
                  ),
                  SizedBox(height: 1.11181702668 * SizeConfig.heightMultiplier),
                  !isSearch
                      ? Center(
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                fontSize:
                                    2.4459974587 * SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w600,
                                letterSpacing:
                                    0.1334180432 * SizeConfig.heightMultiplier),
                          ),
                        )
                      : Container(),
                  !isSearch ? HorizontalList() : Container(),
                  SizedBox(height: 1.11181702668 * SizeConfig.heightMultiplier),
                  Center(
                      child: Text(
                    'Menu',
                    style: TextStyle(
                        fontSize: 2.4459974587 * SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w600,
                        letterSpacing:
                            0.1334180432 * SizeConfig.heightMultiplier),
                  )),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      child: !isSearch
                          ? Consumer<P_Restuarant>(
                              builder: (context, menu, _) => GridView.builder(
                                itemCount: menu.itemss.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.44472681067 *
                                            SizeConfig.heightMultiplier,
                                        horizontal: 0.97222222222 *
                                            SizeConfig.widthMultiplier),
                                    child: FoodItemCard(
                                      id: menu.itemss[index].id,
                                    ),
                                  );
                                },
                              ),
                            )
                          : Consumer<P_Restuarant>(
                              builder: (context, sea, _) => GridView.builder(
                                  itemCount: sea.searchitems.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 0.44472681067 *
                                              SizeConfig.heightMultiplier,
                                          horizontal: 0.97222222222 *
                                              SizeConfig.widthMultiplier),
                                      child: FoodItemCard(
                                        id: sea.searchitems[index].id,
                                      ),
                                    );
                                  }),
                            ),
                    ),
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

class SearchBar extends StatefulWidget {
  const SearchBar({
    required this.allotSearch,
  });

  final Function allotSearch;
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late FocusNode searchFocusNode;
  bool isSearch = false;
  final searchcontorller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    searchFocusNode.dispose();
    searchcontorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var maxH = constraints.maxHeight;
        var maxW = constraints.maxWidth;
        print(
            "shoplist SearchBar h is ${constraints.maxHeight} w is ${constraints.maxWidth}");
        return Row(
          children: [
            Expanded(
              child: isSearch
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(8 * maxH / 37.632),
                          border: Border.all(color: Colors.black)),
                      padding: EdgeInsets.symmetric(
                          vertical: 1 * maxH / 37.632,
                          horizontal: 4 * maxW / 232.368),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  3 * maxW / 232.368, 0, 0, 3 * maxH / 37.632),
                              child: TextField(
                                decoration: InputDecoration(isDense: true),
                                controller: searchcontorller,
                                focusNode: searchFocusNode,
                                style: TextStyle(fontSize: 18 * maxH / 37.632),
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                onSubmitted: (value) {
                                  if (value == "") {
                                    setState(() {
                                      isSearch = false;
                                    });
                                    widget.allotSearch("");
                                  } else {
                                    widget.allotSearch(value);
                                  }
                                },
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                if (searchcontorller.text == "") {
                                  setState(() {
                                    isSearch = false;
                                  });
                                  widget.allotSearch("");
                                } else {
                                  widget.allotSearch(searchcontorller.text);
                                }
                                searchFocusNode.unfocus();
                              },
                              child: Icon(
                                Icons.search,
                                size:
                                    3.33545108005 * SizeConfig.heightMultiplier,
                              ))
                        ],
                      ))
                  : Container(),
            ),
            isSearch
                ? Container(
                    color: Colors.blue,
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        isSearch = !isSearch;
                      });
                      searchFocusNode.requestFocus();
                    },
                    child: Icon(
                      Icons.search,
                      size: 3.33545108005 * SizeConfig.heightMultiplier,
                    ),
                  )
          ],
        );
      },
    );
  }
}

class HorizontalList extends StatelessWidget {
  Map<int, String> category = {
    0: "Gujarati",
    1: "Italian",
    2: "Indian",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0063532402 * SizeConfig.heightMultiplier,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Category(
            image_location: 'assets/images/lunch.jpeg',
            image_caption: category[index].toString(),
          );
        },
        itemCount: category.length,
      ),
    );
  }
}

class Category extends StatefulWidget {
  final String image_location;
  final String image_caption;

  Category({
    required this.image_location,
    required this.image_caption,
  });

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  void _selectPage2(String cate) {
    print("_selectpage c_id is $cate");
    Provider.of<P_Restuarant>(context, listen: false)
        .fetchItemByCategory(sid, widget.image_caption)
        .then((value) {})
        .catchError((onError) {
      print(onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 0.22236340533 * SizeConfig.heightMultiplier,
          horizontal: 0.48611111111 * SizeConfig.widthMultiplier),
      child: InkWell(
        onTap: () {
          _selectPage2(widget.image_caption);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0.22236340533 * SizeConfig.heightMultiplier,
              horizontal: 0.48611111111 * SizeConfig.widthMultiplier),
          child: Container(
            width: 24.3055555556 * SizeConfig.widthMultiplier,
            height: 16.6772554003 * SizeConfig.heightMultiplier,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.asset(
                    widget.image_location,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.image_caption,
                    style: TextStyle(
                        fontSize: 1.77890724269 * SizeConfig.heightMultiplier),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
