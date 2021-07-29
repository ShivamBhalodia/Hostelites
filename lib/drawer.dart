import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Sagar Chovatiya'),
            accountEmail: Text('sagarchovatiya0104.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.red.shade900),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Login'),
              leading: Icon(Icons.login),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Home Page'),
              leading: Icon(Icons.home),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('My Orders'),
              leading: Icon(Icons.shopping_basket),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Favourites'),
              leading: Icon(Icons.favorite),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('About Us'),
              leading: Icon(Icons.info),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Share'),
              leading: Icon(Icons.share),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Rate Us'),
              leading: Icon(Icons.rate_review),
            ),
          ),
          
          Divider(),
        ],
      ),
    );
  }
}
