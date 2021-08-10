import 'package:flutter/material.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';
import './horizontal_list.dart';
import './food_item_card.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class ItemList extends StatefulWidget {
  //static final String routename = "/item-list";
  int shopid;
  ItemList(this.shopid);
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // the scaffold global key
  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();

  bool initial = true;
  bool isLoading = false;
  bool isLoad = false;

  late String search;
  bool isSearch = false;

  // void onSubmitted(String value) {
  //   setState(() => _scaffoldKey.currentState!
  //       .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  // }

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
    // var targetValue = search.substring(0, 1) + search.substring(1);
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
    final shop = Provider.of<P_Restuarant>(context).findByIdShop(widget.shopid);
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
                      setState(() {
                        isSearch = false;
                      });
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
                      child: SearchBar(
                        allotSearch: allotingserach,
                      )),
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
                  !isSearch
                      ? Center(
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2),
                          ),
                        )
                      : Container(),
                  !isSearch ? HorizontalList() : Container(),
                  SizedBox(height: 10),
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
                      child: isLoad
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : !isSearch
                              ? Consumer<P_Restuarant>(
                                  builder: (context, menu, _) =>
                                      GridView.builder(
                                          itemCount: menu.itemss.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                          ),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return menu.itemss.length == 0
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: FoodItemCard(
                                                      id: menu.itemss[index].id,
                                                    ),
                                                  );
                                          }),
                                )
                              : Consumer<P_Restuarant>(
                                  builder: (context, sea, _) =>
                                      GridView.builder(
                                          itemCount: sea.searchitems.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
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
                                size: 30,
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
                      size: 30,
                    ),
                  )
          ],
        );
      },
    );
  }
}
