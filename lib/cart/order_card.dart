import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 80,
              width: 20,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(50.0),
                        child: Icon(Icons.add_circle_outline,
                            size: 15, color: Color(0xFFD3D3D3))),
                    Text(
                      "0",
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(50.0),
                        child: Icon(Icons.remove_circle_outline,
                            size: 15, color: Color(0xFFD3D3D3))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 5),
              child: Text(
                "X",
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),
            Container(
              height: 80.0,
              width: 80.0,
              margin: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/lunch.jpeg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 5.0,
                        offset: Offset(0.0, 2.0))
                  ]),
            ),
            SizedBox(
              width: 12.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Grilled Chicken",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.orangeAccent,
                    ),
                    SizedBox(width: 5),
                    Text('Burger king'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, left: 5),
                  child: Text(
                    '\$100',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
              ],
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: () {},
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
