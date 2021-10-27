import "package:flutter/material.dart";

class StepsCard extends StatelessWidget {
  final String distance;
  final String duration;
  final String html_instructions;
  final int index;
  StepsCard(
      {@required this.distance,
      @required this.duration,
      @required this.html_instructions,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '$index',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {}),
                        InkWell(
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Icon(
                                        Icons.directions_car_rounded,
                                        color: Colors.grey,
                                        size: 25.0,
                                      ),
                                      Text(
                                        'Distance',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ]),
                                    Text(
                                      '$distance',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {}),
                        InkWell(
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Icon(
                                        Icons.timer,
                                        color: Colors.grey,
                                        size: 25.0,
                                      ),
                                      Text(
                                        'Duration',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ]),
                                    Text(
                                      '$duration',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {}),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: 270,
                  child: Text(
                    '$html_instructions',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF3a3a3b),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
