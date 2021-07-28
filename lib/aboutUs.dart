import 'package:flutter/material.dart';
import './aboutUsCard.dart';

class AboutUs extends StatelessWidget {
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
            onPressed: () {},
          ),
          centerTitle: true,
          title: Text(
            'About Us',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry,Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Our team',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  children: [
                    AboutUsCard(
                      name: 'Jainam Sanghavi',
                      college: 'CSE, Nirma University',
                      city: 'Surat, Gujarat',
                      mail: '',
                      linkedin: '',
                    ),
                    AboutUsCard(
                      name: 'Rahin Vadsariya',
                      college: 'CSE, IIIT Vadodara',
                      city: 'Bharuch, Gujarat',
                      mail: '',
                      linkedin: '',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    AboutUsCard(
                      name: 'Shivam Bhalodia',
                      college: 'CSE, Nirma University',
                      city: 'Rajkot, Gujarat',
                      mail: '',
                      linkedin: '',
                    ),
                    AboutUsCard(
                      name: 'Sagar Chovatiya',
                      college: 'CSE, Nirma University',
                      city: 'Surat, Gujarat',
                      mail: '',
                      linkedin: '',
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Why Us?',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: <Widget>[
                      Icon(
                        Icons.login,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 195,
                        child: Text(
                          'Separate modules for Shop and User',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Row(
                        children: [
                          Icon(
                            Icons.chat,
                            color: Colors.blueAccent,
                            size: 30.0,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.location_on,
                            color: Colors.blueAccent,
                            size: 30.0,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 195,
                        child: Text(
                          'Enrich with features like chat and map',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
                SizedBox(height: 15),
                Column(children: <Widget>[
                  Icon(
                    Icons.mobile_friendly,
                    color: Colors.blueAccent,
                    size: 30.0,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'User Friendly UI',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.blueAccent,
                    size: 30.0,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'xyz@gmail.com',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}
