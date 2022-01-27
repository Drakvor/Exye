import 'dart:io';

class Product {
  String id;
  String name;
  String brand;
  int priceOld;
  int price;
  List<String> details;
  List<String> more;
  List<String> images;
  List<File>? files;
  Product({required this.id, required this.name, required this.brand, required this.priceOld, required this.price, required this.details, required this.more, required this.images});

  void addFiles (List<File> input) {
    files = input;
  }
}