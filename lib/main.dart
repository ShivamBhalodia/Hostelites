import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hostel_app/drawer.dart';
import 'package:hostel_app/horizontal_list.dart';
import 'package:hostel_app/images/add_products.dart';
import 'package:hostel_app/order_screen.dart';
import 'package:hostel_app/products.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  _MyHomePageState() {
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
      height: 220.0,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 175,
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
                // color: Colors.green,
                // margin: EdgeInsets.symmetric(horizontal: 0.02777*constraints.maxWidth),
                decoration: BoxDecoration(
                  // color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      // blurRadius: 0.01 * constraints.maxHeight,
                    )
                  ],
                  // borderRadius:
                  //     BorderRadius.circular(0.035 * constraints.maxWidth),
                ),
                child: ClipRRect(
                  // borderRadius:
                  //     BorderRadius.circular(0.035 * constraints.maxWidth),
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
                'Categories',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          HorizontalList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Products',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Flexible(child: Products()),
        ],
      ),
    );
  }
}
