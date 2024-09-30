// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

part 'register_model.g.dart';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

@HiveType(typeId: 10)
class Register {
  @HiveField(1)
  String id;
  @HiveField(2)
  String name;
  @HiveField(3)
  String surname;
  @HiveField(4)
  String phoneNumber;
  @HiveField(5)
  DateTime birthday;
  @HiveField(6)
  String gender;
  @HiveField(7)
  DateTime createdAt;

  Register({
    required this.id,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.birthday,
    required this.gender,
    required this.createdAt,
  });

  Register copyWith({
    String? id,
    String? name,
    String? surname,
    String? phoneNumber,
    DateTime? birthday,
    String? gender,
    DateTime? createdAt,
  }) =>
      Register(
        id: id ?? this.id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        birthday: birthday ?? this.birthday,
        gender: gender ?? this.gender,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    phoneNumber: json["phone_number"],
    birthday: DateTime.parse(json["birthday"]),
    gender: json["gender"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "phone_number": phoneNumber,
    "birthday": birthday.toIso8601String(),
    "gender": gender,
    "created_at": createdAt.toIso8601String(),
  };
}
