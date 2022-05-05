import 'package:flutter/material.dart';

class Data {
  String url;
  String title;
  String option;
  double lat;
  double lon;
  int id;
  int area;
  double density;
  String category;
  final String t_title;
  final IconData icon;
  final String temp;
  final String wifi;
  final Color color;
  final String city;

  final String image;
  final String cold;
  final String? costvalue;
  final String? fun;
  final String? allvalue;

  Data(
      {required this.url,
        required this.title,
        required this.option,
        required this.id,
        required this.lat,
        required this.lon,
        required this.area,
        required this.density,
        required this.category,
        required this.t_title,
        required this.icon,
        required this.temp,
        required this.wifi,
        required this.color,
        required this.city,
        required this.image,
        required this.cold,
        required this.costvalue,
        required this.fun,
        required this.allvalue,});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "url": url,
      "option": option,
      "lat": lat,
      "lon": lon,
      "area": area,
      "density": density,
      "category": category,
      "t_title" : t_title,
      "icon" : icon,
      "temp" : temp,
      "wifi" :wifi,
      "color" : color,
      "city" : city,
      "image" : image,
      "cold" : cold,
      "costvalue" : costvalue,
      "fun" : fun,
      "allvalue" : allvalue

    };
  }
}