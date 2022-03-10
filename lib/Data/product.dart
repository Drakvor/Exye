import 'dart:io';
import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  String brand;
  String size;
  int priceOld;
  int price;
  List<String> details;
  List<String> more;
  List<String> images;
  List<File>? files;
  Product({required this.id, required this.name, required this.size, required this.brand, required this.priceOld, required this.price, required this.details, required this.more, required this.images});

  void addFiles (List<File> input) {
    files = input;
  }
}