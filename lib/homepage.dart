import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hostel_app/drawer.dart';
import 'package:hostel_app/products.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final String routename = "/home-page";
  @override
  _HomePageState createState() => _HomePageState();
}

int _current = 0;
int selectIndex = 0;

String cate = "";

class _HomePageState extends State<HomePage> {
  List imgList = [
    'lib/images/907106.jpg',
    'lib/images/bootstrap-carousel-slide-4.jpg',
    'lib/images/food2.jpg',
    'lib/images/FSSAI-Drafts-Regulations-on-Safe-and-Wholesome-Food-for-School-Children.jpg',
    'lib/images/H220546cb02cc4c4da8e6dc437d0986d9f.jpg',
  ];
  SearchBar? searchBar = null;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool initial = true;
  bool isLoading = false;
  bool isLoad = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (initial) {
      setState(() {
        isLoading = true;
      });

      Provider.of<P_Restuarant>(context, listen: false)
          .fetchrestuarant()
          .then((value) {
        setState(() {
          isLoading = false;
        });
        initial = false;
      }).catchError((onerror) {
        print("error is jaisin");
        print(onerror);
        setState(() {
          isLoading = false;
        });

        const errorMessage = 'Something went wrong. Please try again later';
        //return showErrorDialoug(1, errorMessage, context);
      });
    }
  }

  late String search;
  bool isSearch = false;

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

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
              .fetchrestuarant()
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
            .searchShop(_controller.text)
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
  Widget build(BuildContext context) {
    Widget imageCarousel = Container(
      height: 200.0,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 155,
          initialPage: 0,
          enlargeCenterPage: true,
          autoPlay: true,
          reverse: false,
          enableInfiniteScroll: true,
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: Duration(milliseconds: 2000),
          // pauseAutoPlayOnTouch: Duration(seconds: 10),
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, t) {
            setState(() {
              _current = index;
            });
          },
        ),
        //
        items: imgList.map((imgUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: 400,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                    )
                  ],
                ),
                child: ClipRRect(
                  child: Image.asset(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      //drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
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
                      AppDrawer();
                    },
                    child: Icon(
                      Icons.list,
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
          !isSearch
              ? imageCarousel
              : Flexible(
                  child: isLoad
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Consumer<P_Restuarant>(
                          builder: (context, sea, _) => GridView.builder(
                              itemCount: sea.searchitem.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Single_prod(
                                    id: sea.searchitem[index].id,
                                  ),
                                );
                              }),
                        ),
                ),
          !isSearch
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    bottom: 10,
                  ),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Top Picks For You',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              : Container(),
          !isSearch ? HorizontalList() : Container(),
          !isSearch
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Shops',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
              : Container(),
          !isSearch
              ? Flexible(
                  child: Consumer<P_Restuarant>(
                    builder: (context, rest, _) => GridView.builder(
                        itemCount: rest.items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Single_prod(
                              id: rest.items[index].id,
                            ),
                          );
                        }),
                  ),
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            label: 'Near me',
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
        // print(
        //     "shoplist SearchBar h is ${constraints.maxHeight} w is ${constraints.maxWidth}");
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

class HorizontalList extends StatelessWidget {
  Map<int, String> category = {
    0: "Gujarati",
    1: "Pubjabi",
    2: "Indian",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Category(
            image_location: 'assets/images/lunch.jpeg',
            image_caption: category[index].toString(),
            categoryId: index,
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
  final int categoryId;

  Category({
    required this.image_location,
    required this.image_caption,
    required this.categoryId,
  });

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  void _selectPage(String cate) {
    // setState(() {
    //   selectIndex = index;
    // });
    // setState(() {
    //   isLoad = true;
    // });
    // int c_id = Provider.of<P_Restuarant>(context, listen: false)
    //     .items[0]
    //     .category[selectIndex]
    //     .categoryId;
    print("_selectpage c_id is $cate");
    Provider.of<P_Restuarant>(context, listen: false)
        .fetchByCategory(cate)
        .then((value) {
      print("then value in p_shoppage search");
      // setState(() {
      //   isLoad = false;
      // });
    }).catchError((onError) {
      print(onError);
      // setState(() {
      //   isLoad = false;
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          setState(() {
            // selectIndex = widget.categoryId;
            // print(selectIndex);
            _selectPage(widget.image_caption);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: 100.0,
            height: 150.0,
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
                    style: TextStyle(fontSize: 16.0),
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
