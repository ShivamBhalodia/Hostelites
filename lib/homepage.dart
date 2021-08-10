import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hostel_app/drawer.dart';
import 'package:hostel_app/itemList/horizontal_list.dart';
import 'package:hostel_app/products.dart';
import 'package:hostel_app/providers/p_resturanat.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final String routename = "/home-page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current = 0;
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

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('Hostel-App'),
      actions: <Widget>[
        searchBar!.getSearchAction(context),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {
            // do something
          },
        )
      ],
    );
  }

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }

  _HomePageState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }
  @override
  Widget build(BuildContext context) {
    Widget image_carousel = Container(
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
      appBar: searchBar!.build(context),
      key: _scaffoldKey,
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          image_carousel,
          Padding(
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
          ),
          HorizontalList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Shops',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Flexible(
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
          ),
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
