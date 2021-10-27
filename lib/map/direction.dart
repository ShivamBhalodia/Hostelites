import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hostel_app/steps.dart';
import './request.dart';
import '../blocs/application_bloc.dart';
import 'package:provider/provider.dart';

class Direction extends StatefulWidget {
  var source;
  var destination;
  var sourceName;
  var destinationName;
  Direction(
      {this.source, this.destination, this.sourceName, this.destinationName});
  @override
  _DirectionState createState() => _DirectionState();
}

final Set<Polyline> _polyLines = {};
final Set<Marker> _markers = {};
var show = false;

class _DirectionState extends State<Direction> {
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  StreamSubscription locationSubscription;
  @override
  void initState() {
    super.initState();

    // var detail =
    //     ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (widget.source != '' && widget.destination != '') {
      _startAddress = widget.source;
      _destinationAddress = widget.destination;
      startAddressController.text = widget.sourceName;
      destinationAddressController.text = widget.destinationName;
      print('Name Check');
      print(widget.sourceName);
      _goToPlace();
    }

    print(widget.source + widget.destination);
    // (_startAddress != '' &&
    //         _destinationAddress != '')
    //     ? ()  {
    //          _goToPlace();
    //       }:null;
    // if (place != null) {
    //   startAddressController.text = place.name;
    //   _startAddress = place.name;
    //    _goToPlace();
    // } else {
    //   // print("init ni andar");
    //   startAddressController.text = "";
    //   _startAddress = "";
    // }
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(22.3039, 70.8022),
    zoom: 11.5,
  );
  // GoogleMapsServices _googleMapsServices = GoogleMapsServices();

  GoogleMapController _googleMapController;
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  Widget _textField({
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required String label,
    @required String hint,
    @required double width,
    @required Icon prefixIcon,
    Widget suffixIcon,
    @required Function(String, String) locationCallback,
  }) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    print('applicationBloc.searchResults');
    if (applicationBloc.searchResults != null)
      print(applicationBloc.searchResults[0].description);
    return Column(children: [
      Container(
        width: width * 0.8,
        child: TextField(
          onChanged: (value) {
            applicationBloc.searchPlaces(value);
          },
          onTap: () => applicationBloc.clearSelectedLocation(),
          controller: controller,
          focusNode: focusNode,
          decoration: new InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(
                color: Colors.blue.shade300,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.all(15),
            hintText: hint,
          ),
        ),
      ),
      if (applicationBloc.searchResults != null &&
          applicationBloc.searchResults.length != 0 &&
          focusNode.hasFocus)
        // print(applicationBloc.searchResults.length),
        Container(
          height: 300.0,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.6),
              backgroundBlendMode: BlendMode.darken),
          child: ListView.builder(
              itemCount: applicationBloc.searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    applicationBloc.searchResults[index].description,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    // print("ontap");
                    // print(applicationBloc.searchResults[index].placeId);
                    // applicationBloc.setSelectedLocation(
                    //     applicationBloc
                    //         .searchResults[index].placeId);
                    locationCallback(
                        applicationBloc.searchResults[index].placeId,
                        applicationBloc.searchResults[index].description);

                    // startAddressController.text = widget.sourceName;
                    // destinationAddressController.text = widget.destinationName;
                  },
                );
              }),
        ),
      // if (applicationBloc.searchResults != null)
      //   Container(
      //     height: 300.0,
      //     child:
      //   ),
    ]);
  }

  Future<void> _goToPlace() async {
    startAddressFocusNode.unfocus();
    desrinationAddressFocusNode.unfocus();
    await GoogleMapsServices.getRouteCoordinates(
        _startAddress, _destinationAddress);
    _markers.clear();
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId('1'),
          width: 2,
          points: _convertToLatLng(_decodePoly(GoogleMapsServices.route)),
          color: Colors.black));
      _markers.add(
        Marker(
          markerId: const MarkerId('origin'),
          infoWindow: InfoWindow(
              title: 'Origin (Direction Step 1)',
              snippet: GoogleMapsServices.steps[0]["html_instructions"]),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: LatLng(GoogleMapsServices.source_location["lat"],
              GoogleMapsServices.source_location["lng"]),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: LatLng(GoogleMapsServices.destination_location["lat"],
              GoogleMapsServices.destination_location["lng"]),
        ),
      );
      for (var i = 1; i < GoogleMapsServices.steps.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          infoWindow: InfoWindow(
              title: 'Direction Step ${i + 1}     ',
              snippet: '${GoogleMapsServices.steps[i]["html_instructions"]}  '),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: LatLng(GoogleMapsServices.steps[i]["start_location"]["lat"],
              GoogleMapsServices.steps[i]["start_location"]["lng"]),
        ));
      }
      show = true;
    });
    _googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(GoogleMapsServices.bounds["northeast"]["lat"],
              GoogleMapsServices.bounds["northeast"]["lng"]),
          southwest: LatLng(GoogleMapsServices.bounds["southwest"]["lat"],
              GoogleMapsServices.bounds["southwest"]["lng"]),
        ),
        100.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () async {},
          ),
          centerTitle: true,
          title: Text(
            'Direction',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Steps.routeName);
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            // Map View
            GoogleMap(
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              compassEnabled: true,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController controller) => {
                _googleMapController = controller,
              },

              markers: _markers,

              polylines: _polyLines,
              // onLongPress: _addMarker,
            ),

            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Places',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Start',
                              hint: 'Choose starting point',
                              prefixIcon: Icon(Icons.looks_one),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.my_location),
                                onPressed: () {
                                  // startAddressController.text = _currentAddress;
                                  // _startAddress = _currentAddress;
                                },
                              ),
                              controller: startAddressController,
                              focusNode: startAddressFocusNode,
                              width: width,
                              locationCallback: (String value, String name) {
                                setState(() {
                                  _startAddress = value;
                                  startAddressController.text = name;
                                });
                              }),
                          SizedBox(height: 10),
                          _textField(
                              label: 'Destination',
                              hint: 'Choose destination',
                              prefixIcon: Icon(Icons.looks_two),
                              controller: destinationAddressController,
                              focusNode: desrinationAddressFocusNode,
                              width: width,
                              locationCallback: (String value, String name) {
                                setState(() {
                                  _destinationAddress = value;
                                  destinationAddressController.text = name;
                                });
                              }),
                          SizedBox(height: 10),
                          Visibility(
                            visible: show,
                            child: Text(
                              'DISTANCE: ${GoogleMapsServices.distance}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Visibility(
                            visible: show,
                            child: Text(
                              'Duration: ${GoogleMapsServices.duration}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: (_startAddress != '' &&
                                    _destinationAddress != '')
                                ? () async {
                                    await _goToPlace();
                                  }
                                : null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Show Route'.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          // _googleMapController!.animateCamera(
                          //   CameraUpdate.newCameraPosition(
                          //     CameraPosition(
                          //       target: LatLng(
                          //         _currentPosition.latitude,
                          //         _currentPosition.longitude,
                          //       ),
                          //       zoom: 18.0,
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    ),
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

List<LatLng> _convertToLatLng(List points) {
  List<LatLng> result = <LatLng>[];
  for (int i = 0; i < points.length; i++) {
    if (i % 2 != 0) {
      result.add(LatLng(points[i - 1], points[i]));
    }
  }
  return result;
}

List _decodePoly(String poly) {
  var list = poly.codeUnits;
  var lList = [];
  int index = 0;
  int len = poly.length;
  int c = 0;
// repeating until all attributes are decoded
  do {
    var shift = 0;
    int result = 0;

    // for decoding value of one attribute
    do {
      c = list[index] - 63;
      result |= (c & 0x1F) << (shift * 5);
      index++;
      shift++;
    } while (c >= 32);
    /* if value is negetive then bitwise not the value */
    if (result & 1 == 1) {
      result = ~result;
    }
    var result1 = (result >> 1) * 0.00001;
    lList.add(result1);
  } while (index < len);

/*adding to previous value as done in encoding */
  for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

  // print(lList.toString());

  return lList;
}
