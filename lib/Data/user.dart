import 'package:exye_app/Data/product.dart';

class UserData {
  String id;
  String? name;
  String? userName;
  String? phoneNumber;
  String? email;
  String? address;
  String? addressDetails;
  int stage; // 0 - idle, 1 - scheduled shopping in place, 2 - shopping available, 3 - scheduled try on,
  int invitations;
  Order? order;
  Appointment? appointment;
  Cart? cart;
  UserData({required this.id, required this.stage, required this.invitations, this.name, this.userName, this.phoneNumber, this.email, this.address, this.addressDetails, this.cart});
}

class Cart {
  List<String>? itemIds;
  List<int>? sizes;
  List<Product>? items;
  Cart({required this.itemIds, required this.sizes});
}

class Appointment {
  String id;
  int timeslot;
  int year;
  int month;
  int day;
  String date;
  Appointment({required this.id, required this.timeslot, required this.year, required this.month, required this.day, required this.date,});
}

class Order {
  String id;
  int timeslot;
  int year;
  int month;
  int day;
  List<String> items;
  String date;
  Order({required this.id, required this.timeslot, required this.year, required this.month, required this.day, required this.items, required this.date});
}