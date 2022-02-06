import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Data/timeslot.dart';
import 'package:exye_app/Data/user.dart';
import 'package:exye_app/Pages/Content/p00_landing.dart';
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
      if (snapshot.docs.isEmpty) {
        FirebaseAuth.instance.signOut();
        app.mPage.newPage(const LandingPage());
        return;
      }
      user = UserData(
        id: snapshot.docs[0].id,
        stage: snapshot.docs[0]["stage"],
        invitations: snapshot.docs[0]["invitations"],
        name: snapshot.docs[0]["name"],
        userName: snapshot.docs[0]["userName"],
        phoneNumber: snapshot.docs[0]["phoneNumber"],
        email: snapshot.docs[0]["email"],
        address: snapshot.docs[0]["address"],
        addressDetails: snapshot.docs[0]["addressDetails"],
      );
    }

    await getAppointment();
    await getOrder();
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

  Future<void> getAppointment () async {
    CollectionReference appointmentsRef = FirebaseFirestore.instance.collection('appointments');

    QuerySnapshot snapshot = await appointmentsRef.orderBy('date').where('user', isEqualTo: user!.id).get();
    if (user!.stage == 1) {
      user!.appointment = Appointment(
        id: snapshot.docs[0].id,
        year: int.parse(snapshot.docs[0]["date"].toString().substring(0, 4)),
        month: int.parse(snapshot.docs[0]["date"].toString().substring(4, 6)),
        day: int.parse(snapshot.docs[0]["date"].toString().substring(6, 8)),
        timeslot: snapshot.docs[0]["slot"],
        date: snapshot.docs[0]["day"],
      );
    }
  }

  Future<void> getOrder () async {
    CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');

    QuerySnapshot snapshot = await ordersRef.orderBy('date').where('user', isEqualTo: user!.id).get();
    if (user!.stage == 4) {
      user!.order = Order(
        id: snapshot.docs[0].id,
        year: snapshot.docs[0]["date"].subString(0, 4),
        month: snapshot.docs[0]["date"].subString(4, 6),
        day: snapshot.docs[0]["date"].subString(6, 8),
        timeslot: snapshot.docs[0]["slot"],
        items: snapshot.docs[0]["items"].cast<String>(),
        date: snapshot.docs[0]["day"],
      );
    }
  }

  Future<void> createAppointment (Timeslot day, int slot) async {
    CollectionReference appointmentsRef = FirebaseFirestore.instance.collection('appointments');
    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('timeslots');

    await appointmentsRef.add({
      "date": (day.year * 10000 + day.month * 100 + day.day).toString(),
      "user": user!.id,
      "day": day.id,
      "slot": slot,
    });

    DocumentSnapshot document = await timeslotsRef.doc(day.id).get();
    List<String> slots = document["slots"].cast<String>();
    slots[slot - 10] = user!.id;
    if (slot < 19) {
      slots[slot - 9] = user!.id;
    }
    if (slot > 10) {
      slots[slot - 11] = "Buffer";
    }
    await timeslotsRef.doc(day.id).update({
      "slots": slots,
    });

    await getAppointment();
  }

  Future<void> createOrder (Timeslot day, int slot) async {
    CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');
    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('timeslots');

    List<String> items = [];
    for (int i = 0; i < 3; i++) {
      items.add((chosen!.length > i) ? chosen![i].id : "Mystery");
    }

    await ordersRef.add({
      "date": (day.year * 10000 + day.month * 100 + day.day).toString(),
      "user": user!.id,
      "day": day.id,
      "slot": slot,
      "items": items,
    });

    DocumentSnapshot document = await timeslotsRef.doc(day.id).get();
    List<String> slots = document["slots"].cast<String>();
    slots[slot - 10] = user!.id;
    if (slot < 19) {
      slots[slot - 9] = user!.id;
    }
    if (slot < 18) {
      slots[slot - 8] = "Buffer";
    }
    if (slot > 10) {
      slots[slot - 11] = user!.id;
    }
    if (slot > 11) {
      slots[slot - 12] = "Buffer";
    }
    await timeslotsRef.doc(day.id).update({
      "slots": slots,
    });

    await getOrder();
  }

  Future<void> createInvitation (String number) async {
    CollectionReference invitationsRef = FirebaseFirestore.instance.collection('invitations');

    await invitationsRef.add({
      "user": user!.id,
      "target": number,
      "date": (DateTime.now().year * 10000 + DateTime.now().month * 100 + DateTime.now().day).toString(),
    });
  }

  Future<void> cancelAppointment () async {
    CollectionReference appointmentsRef = FirebaseFirestore.instance.collection('appointments');
    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('timeslots');

    await appointmentsRef.doc(user!.appointment!.id).delete();

    DocumentSnapshot document = await timeslotsRef.doc(user!.appointment!.date).get();
    List<String> slots = document["slots"].cast<String>();
    slots[user!.appointment!.timeslot - 10] = "";
    if (user!.appointment!.timeslot < 19) {
      slots[user!.appointment!.timeslot - 9] = "";
    }
    if (user!.appointment!.timeslot < 18) {
      if (slots[user!.appointment!.timeslot - 8] == "Buffer"){
        slots[user!.appointment!.timeslot - 8] = "";
      }
    }
    if (user!.appointment!.timeslot > 10) {
      slots[user!.appointment!.timeslot - 11] = "";
    }
    if (user!.appointment!.timeslot > 11) {
      if (slots[user!.appointment!.timeslot - 12] == "Buffer"){
        slots[user!.appointment!.timeslot - 12] = "";
      }
    }
    await timeslotsRef.doc(user!.appointment!.date).update({
      "slots": slots,
    });
  }

  Future<void> cancelOrder () async {
    CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');
    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('timeslots');

    await ordersRef.doc(user!.order!.id).delete();

    DocumentSnapshot document = await timeslotsRef.doc(user!.order!.date).get();
    List<String> slots = document["slots"].cast<String>();
    slots[user!.order!.timeslot - 10] = "";
    if (user!.order!.timeslot < 19) {
      slots[user!.order!.timeslot - 9] = "";
    }
    if (user!.order!.timeslot > 10) {
      if (slots[user!.order!.timeslot - 11] == "Buffer"){
        slots[user!.order!.timeslot - 11] = "";
      }
    }
    await timeslotsRef.doc(user!.order!.date).update({
      "slots": slots,
    });
  }

  Future<void> nextStage () async {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    user!.stage++;

    await usersRef.doc(user!.id).update({
      "stage": user!.stage,
    });
  }

  Future<void> prevStage () async {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    user!.stage--;

    await usersRef.doc(user!.id).update({
      "stage": user!.stage,
    });
  }
}