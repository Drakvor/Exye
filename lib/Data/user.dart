class UserData {
  String id;
  String? firstName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? email;
  String? address;
  int stage; // 0 - idle, 1 - scheduled shopping in place, 2 - shopping available, 3 - scheduled try on,
  int invitations;
  Order? order;
  Appointment? appointment;
  UserData({required this.id, required this.stage, required this.invitations, this.firstName, this.lastName, this.userName, this.phoneNumber, this.email, this.address});
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