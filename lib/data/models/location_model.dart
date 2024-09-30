import 'package:hive/hive.dart';
import 'dart:convert';

part 'location_model.g.dart';

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  int count;
  List<LocationElement> locations;

  Location({
    required this.count,
    required this.locations,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    count: json["count"],
    locations: List<LocationElement>.from(json["locations"].map((x) => LocationElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 5)
class LocationElement {
  @HiveField(1)
  String id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String info;
  @HiveField(4)
  double latitude;
  @HiveField(5)
  double longitude;
  @HiveField(6)
  String image;
  @HiveField(7)
  String createdAt;
  @HiveField(8)
  String? opensAt;
  @HiveField(9)
  String? closesAt;

  LocationElement({
    required this.id,
    required this.name,
    required this.info,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.createdAt,
    required this.opensAt,
    required this.closesAt,
  });

  factory LocationElement.fromJson(Map<String, dynamic> json) => LocationElement(
    id: json["id"],
    name: json["name"],
    info: json["info"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    image: json["image"],
    createdAt: json["created_at"],
    opensAt: json["opens_at"],
    closesAt: json["closes_at"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "info": info,
    "latitude": latitude,
    "longitude": longitude,
    "image": image,
    "created_at": createdAt,
    "opens_at": opensAt,
    "closes_at": closesAt
  };
}
