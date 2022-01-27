import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Pages/Content/p00_landing.dart';
import 'package:exye_app/Pages/Content/p05_schedule.dart';
import 'package:exye_app/Pages/Content/p06_listing.dart';
import 'package:exye_app/Pages/Content/p09_invitations.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_calendar.dart';
import 'package:exye_app/Widgets/custom_divider.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future init;

  @override
  void initState () {
    super.initState();
    init = app.mData.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildColumn();
        }
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildColumn () {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomHeader(app.mResource.strings.hHome),
        buildStageTracker(),
        CustomTextButton(
          text: app.mResource.strings.bMainButton[app.mData.user!.stage],
          style: app.mResource.fonts.bWhite,
          height: 30,
          width: 100,
          function: () async {
            if (app.mData.user!.stage == 0) {
              app.mPage.nextPage(const SchedulePage());
            }
            setState(() {
              //app.mData.user!.stage++;
            });
          },
        ),
        CustomTextButton(
          text: "Listings",
          style: app.mResource.fonts.bWhite,
          height: 30,
          width: 100,
          function: () async {
            await app.mData.getProductData();
            if (app.mData.user!.stage == 0) {
              app.mPage.nextPage(const ListingsPage());
            }
            setState(() {
              //app.mData.user!.stage++;
            });
          },
        ),
        CustomTextButton(
          text: "Invite",
          style: app.mResource.fonts.bWhite,
          height: 30,
          width: 100,
          function: () async {
            //await generateData();
            //print("Done");
            app.mPage.nextPage(const InvitationsPage());
          },
        ),
        CustomTextButton(
          text: "Log Out",
          style: app.mResource.fonts.bWhite,
          height: 30,
          width: 100,
          function: () async {
            FirebaseAuth.instance.signOut();
            app.mPage.newPage(const LandingPage());
          },
        ),
        Container(),
      ],
    );
  }

  Widget buildStageTracker () {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Stage"),
          const Text("Hi, this is words"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildStage(0),
              buildStage(1),
              buildStage(2),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStage (int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: (app.mData.user!.stage > index) ? app.mResource.colours.black : app.mResource.colours.white,
              border: Border.all(color: app.mResource.colours.black),
            ),
            child: Text((index + 1).toString(), style: TextStyle(color: (app.mData.user!.stage > index) ? app.mResource.colours.fontWhite : app.mResource.colours.fontBlack),),
          ),
          Container(
            height: 5,
          ),
          CustomSizedDivider(75, thickness: (app.mData.user!.stage > index) ? 3 : 1),
        ],
      ),
    );
  }
}

Future<void> generateData () async {
  CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('timeslots');
  for (int i = 0; i < 500; i++) {
    DateTime tmp = DateTime.now().subtract(const Duration(days: 50)).add(Duration(days: i));
    await timeslotsRef.add({
      "year": tmp.year,
      "month": tmp.month,
      "day": tmp.day,
      "weekday": tmp.weekday - 1,
      "available": (tmp.weekday > 5) ? 0 : 1,
      "slots": ["", "", "", "", "", "", "", "", "", "",],
      "deliveries": [],
      "deliverCount": 0,
    });
  }
}

Future<void> generateData2 () async {
  CollectionReference productsRef = FirebaseFirestore.instance.collection('products');
  for (int i = 0; i < 10; i++) {
    await productsRef.add({
      "brand": "Gucci",
      "name": "Abney Jet Recycled Neps Henley Jean",
      "priceOld": 4833000,
      "price": 2900000,
      "details": ["Hey", "No", "Good Afternoon",],
      "more": ["Great", "No thanks",],
      "images": ["Front", "Back", "Close Up"],
    });
  }
}
