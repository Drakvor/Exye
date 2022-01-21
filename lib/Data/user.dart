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
  UserData({required this.id, required this.stage, required this.invitations, this.firstName, this.lastName, this.userName, this.phoneNumber, this.email, this.address});
}