import 'package:flutter/material.dart';
import 'package:map/direction.dart';
import 'package:map/directionScreen.dart';
import './direction.dart';

class HorizontalList extends StatelessWidget {
  String image_location;
  String image_caption;
  String image_vicinity;
  String user_total_rating;
  String rating;
  String source;
  String destination;
  String sourceName;

  HorizontalList({
    this.image_location,
    this.image_caption,
    this.image_vicinity,
    this.rating,
    this.user_total_rating,
    this.source,
    this.destination,
    this.sourceName,
  });
  @override
  Widget build(BuildContext context) {
    print("aama ghusne bhai");
    print(image_location);
    print(image_caption);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: 380,
              height: 270.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                        width: 100,
                        height: 100,
                        child: Image.network(
                          image_location,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text("Rating: $rating($user_total_rating)"),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FittedBox(
                        child: Container(
                          width: 260,
                          padding: EdgeInsets.only(top: 5),
                          alignment: Alignment.topCenter,
                          child: Text(
                            image_caption,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Container(
                          width: 260,
                          alignment: Alignment.topCenter,
                          child: Text(
                            image_vicinity,
                            style: TextStyle(fontSize: 16.0),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 60, bottom: 5),
                        child: InkWell(
                          onTap: () {
                            // print('HIIIIII');
                            // print(source);
                            // print(sourceName);
                            Navigator.of(context).pushNamed(
                                DirectionScreen.routeName,
                                arguments: {
                                  "source": source,
                                  "destination": destination,
                                  "sourceName": sourceName,
                                  "destinationName": image_caption,
                                });
                          },
                          child: Container(
                            // margin: EdgeInsets.all(2
                            // 0),
                            height: 40,
                            width: 130,

                            decoration: new BoxDecoration(
                                color: Colors.blueAccent,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Row(children: <Widget>[
                              Text(
                                'Directions',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.directions,
                                color: Colors.white,
                                size: 25.0,
                              ),
                            ]),
                            // child: FlatButton(
                            //   child: Text('Direction'),
                            //   color: Colors.blueAccent,
                            //   textColor: Colors.white,
                            //   onPressed: () {},
                            // ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // ListTile(
              //   title: Image.asset(
              //     image_location,
              //     fit: BoxFit.cover,
              //   ),
              //   subtitle: Container(
              //     alignment: Alignment.topCenter,
              //     child: Text(image_caption, style:TextStyle(fontSize: 16.0),),
              //   )
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
