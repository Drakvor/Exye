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
    stock = [];
    for (int i = 0; i < sizes.length; i++) {
      int index = app.mData.stock.indexWhere((element) => (element["PRD_CODE"] == id));
      if (index == -1) {
        stock!.add(1);
      }
      else {
        stock!.add(1);
        //stock!.add(app.mData.stock[index]["BAL_QTY"]);
      }
    }
  }
}