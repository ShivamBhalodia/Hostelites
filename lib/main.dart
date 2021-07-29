import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hostel_app/images/add_products.dart';
import 'package:hostel_app/order_screen.dart';
import 'package:hostel_app/products.dart';

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
      home: AddProductScreen(),
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
      // Carousel(
      //   boxFit: BoxFit.cover,
      //   images: [
      //     AssetImage('lib/images/907106.jpg'),
      //     AssetImage('lib/images/bootstrap-carousel-slide-4.jpg'),
      //     AssetImage('lib/images/food2.jpg'),
      //     AssetImage('lib/images/FSSAI-Drafts-Regulations-on-Safe-and-Wholesome-Food-for-School-Children.jpg'),
      //     AssetImage('lib/images/H220546cb02cc4c4da8e6dc437d0986d9f.jpg'),
      //   ],
      //   autoplay: false,
      //   dotSize: 4.0,
      //   indicatorBgPadding: 4.0,
      //   dotColor: Colors.white,
      // ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          image_carousel,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Products',
            ),
          ),
          Flexible(child: Products()),
        ],
      ),
    );
  }
}
