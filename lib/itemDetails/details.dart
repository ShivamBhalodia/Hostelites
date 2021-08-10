import 'package:flutter/material.dart';
import 'package:hostel_app/utils/size_config.dart';

class MealDetailScreen extends StatefulWidget {
  MealDetailScreen();

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.assistant_direction_sharp,
            color: Colors.white,
          ),
          onPressed: () {},
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
      body: Column(
        children: <Widget>[
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset("assets/images/lunch.jpeg",
                fit: BoxFit.cover,
                width: 89.9305555556 * SizeConfig.widthMultiplier,
                height: 31.9989834816 * SizeConfig.heightMultiplier),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  4.44726810673 * SizeConfig.heightMultiplier),
            ),
            elevation: 6,
            margin: EdgeInsets.symmetric(
                horizontal: 4.86111111111 * SizeConfig.widthMultiplier,
                vertical: 1.66772554003 * SizeConfig.heightMultiplier),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 4.86111111111 * SizeConfig.widthMultiplier),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 1.45833333333 * SizeConfig.widthMultiplier),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Piza',
                        style: TextStyle(
                            fontSize:
                                2.22363405337 * SizeConfig.heightMultiplier,
                            color: Color(0xFF3a3a3b),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\$100',
                        style: TextStyle(
                            fontSize:
                                2.22363405337 * SizeConfig.heightMultiplier,
                            color: Color(0xFF3a3a3b),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.55590851334 * SizeConfig.heightMultiplier,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: Colors.yellow,
                    ),
                    SizedBox(width: 2.43055555556 * SizeConfig.widthMultiplier),
                    Text('Burger king'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 2.22363405337 * SizeConfig.heightMultiplier),
                  child: Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 2.22363405337 * SizeConfig.heightMultiplier,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 4.86111111111 * SizeConfig.widthMultiplier,
                      vertical: 1.11181702668 * SizeConfig.heightMultiplier),
                  child: SingleChildScrollView(
                      child: Text(
                          'What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has? What is Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry Lorem Ipsum has been the industry standard dummy text ever since the 1500s when an unknown printer took a galley of type and scrambled it to make a type specimen book it has?')))),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 4.86111111111 * SizeConfig.widthMultiplier,
                vertical: 1.11181702668 * SizeConfig.heightMultiplier),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove),
                      color: Colors.red,
                      iconSize: 2.22363405337 * SizeConfig.heightMultiplier,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 12.1527777778 * SizeConfig.widthMultiplier,
                        height: 3.33545108005 * SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(
                              1.11181702668 * SizeConfig.heightMultiplier),
                        ),
                        child: Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize:
                                    2.00127064803 * SizeConfig.heightMultiplier,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      color: Colors.red,
                      iconSize: 2.22363405337 * SizeConfig.heightMultiplier,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.bookmark_add_outlined),
                  color: Color(0xFFfd2c2c),
                  iconSize: 3.33545108005 * SizeConfig.heightMultiplier,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
