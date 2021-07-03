import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "AIzaSyARl4-bejEhfIUJb7aypDljMwvUeBmZxOo";

class GoogleMapsServices {
  static String route = "";
  static List<dynamic> steps = [];
  static String source = "";
  static String destination = "";
  static String distance = "";
  static String duration = "";
  static Map bounds = {};
  static Map source_location = {};
  static Map destination_location = {};
  static Future<void> getRouteCoordinates(
      String start, String destination) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=place_id:$start&destination=place_id:$destination&key=$apiKey";
    http.Response response = await http.get(Uri.parse(url));

    Map values = jsonDecode(response.body);
    route = values["routes"][0]["overview_polyline"]["points"];
    steps = values["routes"][0]["legs"][0]["steps"];
    source = values["routes"][0]["legs"][0]["start_address"];
    destination = values["routes"][0]["legs"][0]["end_address"];
    distance = values["routes"][0]["legs"][0]["distance"]["text"];
    duration = values["routes"][0]["legs"][0]["duration"]["text"];
    source_location = values["routes"][0]["legs"][0]["start_location"];
    destination_location = values["routes"][0]["legs"][0]["end_location"];
    bounds = values["routes"][0]["bounds"];
    print(steps[0]["html_instructions"]);
  }
}
