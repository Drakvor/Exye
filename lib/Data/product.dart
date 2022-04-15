import 'dart:io';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

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
  List<String> sizes;
  List<int>? stock;
  int selected = -1;
  Product({required this.id, required this.name, required this.brand, required this.priceOld, required this.price, required this.details, required this.more, required this.images, required this.sizes});

  void addFiles (List<File> input) {
    files = input;
  }

  Future<void> getStock () async {
    //await app.mData.accessApi();
    stock = [];
    for (int i = 0; i < sizes.length; i++) {
      stock!.add(i);
      //get from ecount
      //app.mData.getStock("${id}_${sizes[i]}");
    }
  }
}