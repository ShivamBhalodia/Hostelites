import 'package:flutter/material.dart';

class AboutUsCard extends StatelessWidget {
  final String name;
  final String college;
  final String city;
  final String mail;
  final String linkedin;
  AboutUsCard({
    required this.name,
    required this.college,
    required this.city,
    required this.mail,
    required this.linkedin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.only(top: 10, right: 5, left: 5),
        child: Container(
          width: 177,
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.blueAccent,
                  size: 22.0,
                ),
                SizedBox(width: 5),
                Container(
                  width: 150,
                  child: Text(
                    '$name',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 5),
              Row(children: <Widget>[
                Icon(
                  Icons.school,
                  color: Colors.blueAccent,
                  size: 22.0,
                ),
                SizedBox(width: 5),
                Container(
                  width: 150,
                  child: Text(
                    '$college',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 5),
              Row(children: <Widget>[
                Icon(
                  Icons.location_city,
                  color: Colors.blueAccent,
                  size: 22.0,
                ),
                SizedBox(width: 5),
                Container(
                  width: 150,
                  child: Text(
                    '$city',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ]),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Row(children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.email,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.linked_camera_outlined,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {},
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
