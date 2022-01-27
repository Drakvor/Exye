import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Data/timeslot.dart';
import 'package:exye_app/Data/user.dart';
import 'package:exye_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class DataManager {
  UserData? user;
  List<Product>? products;
  List<Product>? chosen;
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
          id: snapshot.docs[i].id,
          year: (m == 1) ? y - 1 : y,
          month: (m == 1) ? 12 : (m - 1),
          day: snapshot.docs[i]["day"],
          weekday: snapshot.docs[i]["weekday"],
          available: snapshot.docs[i]["available"],
          slots: snapshot.docs[i]["slots"].cast<String>(),
          deliveries: snapshot.docs[i]["deliveries"].cast<String>(),
          deliverCount: snapshot.docs[i]["deliverCount"],
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
          id: snapshot.docs[i].id,
          year: y,
          month: m,
          day: snapshot.docs[i]["day"],
          weekday: snapshot.docs[i]["weekday"],
          available: snapshot.docs[i]["available"],
          slots: snapshot.docs[i]["slots"].cast<String>(),
          deliveries: snapshot.docs[i]["deliveries"].cast<String>(),
          deliverCount: snapshot.docs[i]["deliverCount"],
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
          id: snapshot.docs[i].id,
          year: (m == 12) ? y + 1 : y,
          month: (m == 12) ? 1 : (m + 1),
          day: snapshot.docs[i]["day"],
          weekday: snapshot.docs[i]["weekday"],
          available: snapshot.docs[i]["available"],
          slots: snapshot.docs[i]["slots"].cast<String>(),
          deliveries: snapshot.docs[i]["deliveries"].cast<String>(),
          deliverCount: snapshot.docs[i]["deliverCount"],
        ),
      );
    }
    month.setDays(listDays);
    calendar!.setNext(month);
  }

  Future<void> getProductData () async {
    CollectionReference selectionsRef = FirebaseFirestore.instance.collection('selections');
    CollectionReference productsRef = FirebaseFirestore.instance.collection('products');
    Directory appImgDir = await getApplicationDocumentsDirectory();

    DocumentSnapshot document = await selectionsRef.doc(app.mData.user!.id).get();
    List<DocumentSnapshot> listProducts = [];
    for (int i = 0; i < document["items"].length; i++) {
      listProducts.add(await productsRef.doc(document["items"][i]).get());
    }

    products = [];
    for (int i = 0; i < listProducts.length; i++) {
      products!.add(
        Product(
          id: listProducts[i].id,
          name: listProducts[i]["name"],
          brand: listProducts[i]["brand"],
          size: listProducts[i]["size"],
          priceOld: listProducts[i]["priceOld"],
          price: listProducts[i]["price"],
          details: listProducts[i]["details"].cast<String>(),
          more: listProducts[i]["more"].cast<String>(),
          images: listProducts[i]["images"].cast<String>(),
        ),
      );
    }

    for (int i = 0; i < products!.length; i++) {
      List<File> files = [];
      ListResult results = await FirebaseStorage.instance.ref().child("productImages").child(products![i].id).listAll();
      for (int j = 0; j < results.items.length; j++) {
        File image = File('${appImgDir.path}/' + products![i].id + results.items[j].name);
        if (!image.existsSync()) {
          await FirebaseStorage.instance
              .ref(results.items[j].fullPath)
              .writeToFile(image);
        }
        files.add(image);
      }
      products![i].addFiles(files);
    }
    chosen = [];
  }

  Future<void> createAppointment (String day, int slot) async {
    CollectionReference appointmentsRef = FirebaseFirestore.instance.collection('appointments');
    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('timeslots');

    await appointmentsRef.add({
      "user": user!.id,
      "day": day,
      "slot": slot,
    });

    DocumentSnapshot document = await timeslotsRef.doc(day).get();
    List<String> slots = document["slots"].cast<String>();
    slots[slot - 10] = user!.id;
    if (slot < 19) {
      slots[slot - 9] = user!.id;
    }
    if (slot > 10) {
      slots[slot - 11] = "Buffer";
    }
    await timeslotsRef.doc(day).update({
      "slots": slots,
    });
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