import 'package:flutter/material.dart';
import './stepsCard.dart';
import './request.dart';

class Steps extends StatelessWidget {
  // const Steps({ Key? key }) : super(key: key);
  static const routeName = '/steps';
  // print("Hi");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Direction Steps',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.grey,
              ),
            ),
            Text(
              '${GoogleMapsServices.source} -> ${GoogleMapsServices.destination}',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.grey,
              ),
            ),
            Text(
              '${GoogleMapsServices.duration} (${GoogleMapsServices.distance})',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount: GoogleMapsServices.steps.length,
                  itemBuilder: (ctx, i) => StepsCard(
                    index: i + 1,
                    distance: GoogleMapsServices.steps[i]["distance"]["text"],
                    duration: GoogleMapsServices.steps[i]["duration"]["text"],
                    html_instructions: GoogleMapsServices.steps[i]
                        ["html_instructions"],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
