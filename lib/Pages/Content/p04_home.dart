import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_calendar.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return buildColumn();
  }

  Widget buildColumn () {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Home Page"),
        CustomTextButton(
          text: "Address Test",
          style: app.mResource.fonts.base,
          height: 30,
          width: 100,
          function: () async {
            app.mPage.nextPage(KpostalView(
              callback: (Kpostal result) {
                app.mApp.buildAlertDialog(context, result.address);
              },
            ));
          },
        ),
        CustomTextButton(
          text: "Phone Test",
          style: app.mResource.fonts.base,
          height: 30,
          width: 100,
          function: () async {
            await launch("tel:+82 01065809860");
          },
        ),
        CustomTextButton(
          text: "Calendar Test",
          style: app.mResource.fonts.base,
          height: 30,
          width: 100,
          function: () async {
            await app.mData.getCalendarData(DateTime.now().year, DateTime.now().month);
            app.mOverlay.loadOverlay(CustomCalendar(key: UniqueKey(),), 400);
            await Future.delayed(const Duration(milliseconds: 200));
            await app.mOverlay.overlayOn();
          },
        ),
      ],
    );
  }
}

void generateData () {
  CollectionReference timeslotsRef = FirebaseFirestore.instance.collection('timeslots');
  for (int i = 0; i < 500; i++) {
    DateTime tmp = DateTime.now().subtract(const Duration(days: 50)).add(Duration(days: i));
    timeslotsRef.add({
      "year": tmp.year,
      "month": tmp.month,
      "day": tmp.day,
      "weekday": tmp.weekday - 1,
      "available": (tmp.weekday > 5) ? 0 : 3,
      "user": ["", ""],
    });
  }
}
