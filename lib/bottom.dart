import 'package:flutter/material.dart';
import 'package:map/src/screens/home_screen.dart';
import '../src/screens/home_screen.dart';
import './direction.dart';

class Bottom extends StatelessWidget {
  const Bottom({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget();
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int currentTab = 0;
  HomeScreen homeScreen;
  Direction directionScreen;

  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    homeScreen = HomeScreen();
    directionScreen = Direction(
      source: '',
      destination: '',
      sourceName: '',
      destinationName: '',
    );

    pages = [homeScreen, directionScreen];

    currentPage = homeScreen;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      currentTab = index;
      currentPage = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            label: 'Go To',
          ),
        ],
        currentIndex: currentTab,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
