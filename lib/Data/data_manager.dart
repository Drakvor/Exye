import 'dart:io';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:flutter/material.dart';
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
  List<String>? productIds;
  List<Product>? products;
  List<Product>? chosen;
  CalendarData? calendar;

  Future<void> getUserData (BuildContext context) async {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    user = UserData(
      id: "",
      stage: 0,
      invitations: 0,
      name: "User",
      userName: "",
      phoneNumber: "",
      email: "",
      address: "",
      addressDetails: "",
    );

    if (FirebaseAuth.instance.currentUser != null) {
      QuerySnapshot snapshot = await usersRef.where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      if (snapshot.docs.isEmpty) {
        await app.mApp.buildErrorDialog(context, app.mResource.strings.eHomeCheckInternet);
        app.mPage.prevPage();
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
        cart: Cart(itemIds: snapshot.docs[0]["cart"].cast<String>(), sizes: snapshot.docs[0]["cartSizes"].cast<int>()),
      );
    }

    await getAppointment();
    await getOrder();
  }

  Future<void> updateAddress () async {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    await usersRef.doc(user!.id).update(
        {
          "address": user!.address,
          "addressDetails": user!.addressDetails,
        }
    );
  }

  Future<void> updateCart () async {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    user!.cart!.itemIds = [];
    user!.cart!.sizes = [];
    for (int i = 0; i < user!.cart!.items!.length; i++) {
      user!.cart!.itemIds!.add(user!.cart!.items![i].id);
      user!.cart!.sizes!.add(user!.cart!.items![i].selected);
    }

    await usersRef.doc(user!.id).update(
      {
        "cart": user!.cart!.itemIds!,
        "cartSizes": user!.cart!.sizes!,
      }
    );

  }

  Future<void> getCalendarData (int y, int m) async {
    calendar = CalendarData(m);

    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('dates');

    DocumentSnapshot document = await timeslotsRef.doc("${y * 100 + m}").get();
    Month month = Month(
      year: (m == 1) ? y - 1 : y,
      month: (m == 1) ? 12 : m - 1,
    );
    List<Timeslot> listDays = [];
    calendar!.setPrev(month);

    month = Month(
      year: y,
      month: m,
    );
    listDays = [];
    for (int i = 1; i < document["slots"].length + 1; i++) {
      listDays.add(
        Timeslot(
          year: y,
          month: m,
          day: i,
          weekday: (((i + document["start"] - 2) % 7) + 1).toInt(),
          available: document["available"][i.toString()],
          slots: document["slots"][i.toString()].cast<String>(),
        ),
      );
    }
    month.setDays(listDays);
    calendar!.setCurrent(month);

    month = Month(
      year: (m == 12) ? y + 1 : y,
      month: (m == 12) ? 1 : (m + 1),
    );
    calendar!.setNext(month);
  }

  Future<void> getProductData () async {
    CollectionReference productsRef = FirebaseFirestore.instance.collection('products');

    DocumentSnapshot doc = await productsRef.doc("!index").get();
    productIds = [...user!.cart!.itemIds!];
    List temp = doc["ids"].cast<String>();
    for (int i = 0; i < temp.length; i++) {
      if (!productIds!.contains(temp[i])){
        productIds!.add(temp[i]);
      }
    }
    products = [];
    user!.cart!.items = [];
    for (int i = 0; i < user!.cart!.itemIds!.length; i++) {
      DocumentSnapshot document = await productsRef.doc(user!.cart!.itemIds![i]).get();
      Product product = Product(
        id: document.id,
        name: document["name"],
        brand: document["brand"],
        size: document["size"],
        priceOld: document["priceOld"],
        price: document["price"],
        details: document["details"].cast<String>(),
        more: document["more"].cast<String>(),
        images: document["images"].cast<String>(),
        sizes: ["22", "33", "44", "55", "66",],
      );
      product.selected = user!.cart!.sizes![i];
      await product.getStock();
      product.images.add(app.mResource.strings.lDetails);
      product.images.add(app.mResource.strings.lMore);

      Directory appImgDir = await getApplicationDocumentsDirectory();

      List<File> files = [];
      ListResult results = await FirebaseStorage.instance.ref().child("productImages").child(product.id).listAll();
      for (int j = 0; j < results.items.length; j++) {
        File image = File('${appImgDir.path}/' + product.id + results.items[j].name);
        if (!image.existsSync()) {
          await FirebaseStorage.instance
              .ref(results.items[j].fullPath)
              .writeToFile(image);
        }
        files.add(image);
      }
      product.addFiles(files);
      products!.add(
        product
      );
      user!.cart!.items!.add(
        product
      );
    }

    return;
    //old stuff
    /*Directory appImgDir = await getApplicationDocumentsDirectory();

    QuerySnapshot snapshot = await productsRef.get();

    products = [];
    for (int i = 0; i < snapshot.docs.length; i++) {
      products!.add(
        Product(
          id: snapshot.docs[i].id,
          name: snapshot.docs[i]["name"],
          brand: snapshot.docs[i]["brand"],
          size: snapshot.docs[i]["size"],
          priceOld: snapshot.docs[i]["priceOld"],
          price: snapshot.docs[i]["price"],
          details: snapshot.docs[i]["details"].cast<String>(),
          more: snapshot.docs[i]["more"].cast<String>(),
          images: snapshot.docs[i]["images"].cast<String>(),
        ),
      );
      products![i].images.add(app.mResource.strings.lDetails);
      products![i].images.add(app.mResource.strings.lMore);
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
    chosen = [];*/
  }

  Future<Product> getProduct (int index) async {
    CollectionReference productsRef = FirebaseFirestore.instance.collection('products');

    DocumentSnapshot doc = await productsRef.doc(productIds![index]).get();
    Product product = Product(
      id: doc.id,
      name: doc["name"],
      brand: doc["brand"],
      size: doc["size"],
      priceOld: doc["priceOld"],
      price: doc["price"],
      details: doc["details"].cast<String>(),
      more: doc["more"].cast<String>(),
      images: doc["images"].cast<String>(),
      sizes: ["22", "33", "44", "55", "66",],
    );
    await product.getStock();
    product.images.add(app.mResource.strings.lDetails);
    product.images.add(app.mResource.strings.lMore);

    Directory appImgDir = await getApplicationDocumentsDirectory();

    List<File> files = [];
    ListResult results = await FirebaseStorage.instance.ref().child("productImages").child(product.id).listAll();
    for (int j = 0; j < results.items.length; j++) {
      File image = File('${appImgDir.path}/' + product.id + results.items[j].name);
      if (!image.existsSync()) {
        await FirebaseStorage.instance
            .ref(results.items[j].fullPath)
            .writeToFile(image);
      }
      files.add(image);
    }
    product.addFiles(files);

    products!.add(product);

    return product;
  }

  Future<void> getOrderItemData () async {
    CollectionReference selectionsRef = FirebaseFirestore.instance.collection('orders');
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
          sizes: ["22", "33", "44", "55", "66",],
        ),
      );
      products![i].images.add(app.mResource.strings.lDetails);
      products![i].images.add(app.mResource.strings.lMore);
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
    if (user!.stage == -1) {
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
    if (user!.stage > 0) {
      CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');

      QuerySnapshot snapshot = await ordersRef.orderBy('date').where('user', isEqualTo: user!.id).get();
      user!.order = Order(
        id: snapshot.docs[0].id,
        year: int.parse(snapshot.docs[0]["date"].toString().substring(0, 4)),
        month: int.parse(snapshot.docs[0]["date"].toString().substring(4, 6)),
        day: int.parse(snapshot.docs[0]["date"].toString().substring(6, 8)),
        timeslot: snapshot.docs[0]["slot"],
        items: snapshot.docs[0]["items"].cast<String>(),
      );
    }
  }

  Future<void> createReceipt (int price) async {
    CollectionReference receiptsRef = FirebaseFirestore.instance.collection('receipts');

    List<String> items = [];
    for (int i = 0; i < user!.cart!.items!.length; i++) {
      items.add(user!.cart!.items![i].id);
    }
    DateTime day = DateTime.now();

    await receiptsRef.add({
      "user": user!.id,
      "items": items,
      "date": (day.year * 10000 + day.month * 100 + day.day),
      "price": price,
    });
  }

  Future<void> createOrder (Timeslot day, int slot) async {
    CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');
    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('dates');

    List<String> items = [];
    for (int i = 0; i < user!.cart!.items!.length; i++) {
      items.add(user!.cart!.items![i].id);
    }

    await ordersRef.doc(app.mData.user!.id).set({
      "date": (day.year * 10000 + day.month * 100 + day.day),
      "user": user!.id,
      "slot": slot,
      "items": items,
    });

    DocumentSnapshot document = await timeslotsRef.doc("${day.year * 100 + day.month}").get();
    Map<dynamic, dynamic> available = document["available"];
    available[day.day.toString()] = available[day.day.toString()] + 1;
    Map<dynamic, dynamic> schedule = document["slots"];
    List<String> slots = schedule[day.day.toString()].cast<String>();
    slots[slot - 10] = user!.id;
    if (slot < 19) {
      slots[slot - 9] = user!.id;
    }
    if (slot < 18) {
      if (slots[slot - 9] == "") {
        slots[slot - 8] = "Buffer";
      }
    }
    if (slot > 10) {
      slots[slot - 11] = user!.id;
    }
    if (slot > 11) {
      if (slots[slot - 12] == "") {
        slots[slot - 12] = "Buffer";
      }
    }
    schedule[day.day.toString()] = slots;
    await timeslotsRef.doc("${day.year * 100 + day.month}").update({
      "slots": schedule,
      "available": available,
    });

    await getOrder();
  }

  Future<void> changeOrder (Timeslot day, int slot) async {
    await cancelOrder();
    await createOrder(day, slot);
  }

  Future<void> createInvitation (String number) async {
    CollectionReference invitationsRef = FirebaseFirestore.instance.collection('invitations');
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    await invitationsRef.add({
      "user": user!.id,
      "target": number,
      "date": (DateTime.now().year * 10000 + DateTime.now().month * 100 + DateTime.now().day).toString(),
    });

    app.mData.user!.invitations -= 1;

    await usersRef.doc(app.mData.user!.id).update({
      "invitations": app.mData.user!.invitations,
    });
  }

  Future<void> cancelOrder () async {
    CollectionReference ordersRef = FirebaseFirestore.instance.collection('orders');
    CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('dates');

    await ordersRef.doc(user!.order!.id).delete();

    DocumentSnapshot document = await timeslotsRef.doc("${user!.order!.year * 100 + user!.order!.month}").get();
    Map<dynamic, dynamic> schedule = document["slots"];
    List<String> slots = schedule[user!.order!.day.toString()].cast<String>();
    slots[user!.order!.timeslot - 10] = "";
    if (user!.order!.timeslot < 19) {
      slots[user!.order!.timeslot - 9] = "";
    }
    if (user!.order!.timeslot > 10) {
      slots[user!.order!.timeslot - 11] = "";
    }
    if (user!.order!.timeslot > 11) {
      if (slots[user!.order!.timeslot - 12] == "Buffer"){
        slots[user!.order!.timeslot - 12] = "";
      }
    }
    if (user!.order!.timeslot < 18) {
      if (slots[user!.order!.timeslot - 8] == "Buffer"){
        slots[user!.order!.timeslot - 8] = "";
      }
    }
    schedule[user!.order!.day.toString()] = slots;
    Map<dynamic, dynamic> available = document["available"];
    available[user!.order!.day.toString()] = available[user!.order!.day.toString()] - 1;
    await timeslotsRef.doc("${user!.order!.year * 100 + user!.order!.month}").update({
      "slots": schedule,
      "available": available,
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