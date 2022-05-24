import 'dart:io';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  String brand;
  String gender;
  String category;
  int priceOld;
  int price;
  List<String> details;
  List<String> images;
  List<String> links;
  String thumbnail;
  List<String> sizes;
  List<int>? stock;
  int selected = -1;
  Product({required this.id, required this.name, required this.brand, required this.gender, required this.category, required this.thumbnail, required this.priceOld, required this.price, required this.details, required this.images, required this.sizes, required this.links});

  void getStock () {
    stock = [];
    for (int i = 0; i < sizes.length; i++) {
      int index = app.mData.stock.indexWhere((element) => (element["PROD_CD"] == (id + "_" + sizes[i])));
      if (index == -1) {
        stock!.add(0);
        //stock!.add(1);
      }
      else {
        stock!.add(app.mData.stock[index]["BAL_QTY"]);
      }
    }
  }
}