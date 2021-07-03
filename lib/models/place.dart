import './geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  final String vicinity;
  final String placeId;
  Place({this.geometry, this.name, this.vicinity, this.placeId});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: Geometry.fromJson(json['geometry']),
      name: json['formatted_address'],
      vicinity: json['vicinity'],
      placeId: json['place_id'],
    );
  }
}
