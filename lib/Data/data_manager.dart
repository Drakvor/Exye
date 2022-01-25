import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Data/timeslot.dart';
import 'package:exye_app/Data/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataManager {
  UserData? user;
  List<Product>? products;
  CalendarData? calendar;

  Future<void> getUserData () async {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    if (FirebaseAuth.instance.currentUser != null) {
      QuerySnapshot snapshot = await usersRef.where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      user = UserData(
        id: snapshot.docs[0].id,
        stage: snapshot.docs[0]["stage"],
        invitations: snapshot.docs[0]["invitations"],
        firstName: snapshot.docs[0]["firstName"],
        lastName: snapshot.docs[0]["lastName"],
        userName: snapshot.docs[0]["userName"],
        phoneNumber: snapshot.docs[0]["phoneNumber"],
        email: snapshot.docs[0]["email"],
        address: snapshot.docs[0]["address"],
      );
    }
  }

  Future<void> getCalendarData (int y, int m) async {
    calendar = CalendarData(m);

    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('timeslots');

    QuerySnapshot snapshot = await timeslotsRef.where('year', isEqualTo: (m == 1) ? y - 1 : y).where('month', isEqualTo: (m == 1) ? 12 : (m - 1)).orderBy("day").get();
    Month month = Month(
      year: (m == 1) ? y - 1 : y,
      month: (m == 1) ? 12 : (m - 1),
    );
    List<Timeslot> listDays = [];
    for (int i = 0; i < snapshot.docs.length; i++) {
      listDays.add(
        Timeslot(
          year: (m == 1) ? y - 1 : y,
          month: (m == 1) ? 12 : (m - 1),
          day: snapshot.docs[i]["day"],
          weekday: snapshot.docs[i]["weekday"],
          available: snapshot.docs[i]["available"],
          user: snapshot.docs[i]["user"].cast<String>(),
        ),
      );
    }
    month.setDays(listDays);
    calendar!.setPrev(month);

    snapshot = await timeslotsRef.where('year', isEqualTo: y).where('month', isEqualTo: m).orderBy("day").get();
    month = Month(
      year: y,
      month: m,
    );
    listDays = [];
    for (int i = 0; i < snapshot.docs.length; i++) {
      listDays.add(
        Timeslot(
          year: y,
          month: m,
          day: snapshot.docs[i]["day"],
          weekday: snapshot.docs[i]["weekday"],
          available: snapshot.docs[i]["available"],
          user: snapshot.docs[i]["user"].cast<String>(),
        ),
      );
    }
    month.setDays(listDays);
    calendar!.setCurrent(month);

    snapshot = await timeslotsRef.where('year', isEqualTo: (m == 12) ? y + 1 : y).where('month', isEqualTo: (m == 12) ? 1 : (m + 1)).orderBy("day").get();
    month = Month(
      year: (m == 12) ? y + 1 : y,
      month: (m == 12) ? 1 : (m + 1),
    );
    listDays = [];
    for (int i = 0; i < snapshot.docs.length; i++) {
      listDays.add(
        Timeslot(
          year: (m == 12) ? y + 1 : y,
          month: (m == 12) ? 1 : (m + 1),
          day: snapshot.docs[i]["day"],
          weekday: snapshot.docs[i]["weekday"],
          available: snapshot.docs[i]["available"],
          user: snapshot.docs[i]["user"].cast<String>(),
        ),
      );
    }
    month.setDays(listDays);
    calendar!.setNext(month);
  }

  Future<void> createInvitation (String number) async {
    CollectionReference invitationsRef = FirebaseFirestore.instance.collection('invitations');

    await invitationsRef.add({
      "user": user!.id,
      "target": number,
      "date": (DateTime.now().year * 10000 + DateTime.now().month * 100 + DateTime.now().day).toString(),
    });
  }
}