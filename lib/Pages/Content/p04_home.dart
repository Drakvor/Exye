import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Data/timeslot.dart';
import 'package:exye_app/Data/user.dart';
import 'package:exye_app/Pages/Content/p00_landing.dart';
import 'package:exye_app/Pages/Content/p05_schedule.dart';
import 'package:exye_app/Pages/Content/p06_listing.dart';
import 'package:exye_app/Pages/Content/p08_appointments.dart';
import 'package:exye_app/Pages/Content/p09_invitations.dart';
import 'package:exye_app/Pages/Content/p10_services.dart';
import 'package:exye_app/Pages/Content/p11_confirm.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_divider.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    init = app.mData.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
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
        CustomHeader(app.mData.user!.name! + app.mResource.strings.hHome),
        buildStageTracker(),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: const CustomHeaderDivider(),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              getMainButton(),
              CustomHybridButton(
                image: app.mResource.images.bInvite,
                text: app.mResource.strings.bInvite + " (" + app.mData.user!.invitations.toString() + ")",
                style: app.mResource.fonts.bold,
                height: 40,
                width: 300,
                function: () async {
                  //await generateData();
                  //print("Done");
                  app.mPage.nextPage(const InvitationsPage());
                },
                colourPressed: app.mResource.colours.buttonLight,
                colourUnpressed: app.mResource.colours.buttonLight,
              ),
              CustomHybridButton(
                image: app.mResource.images.bLogOut,
                text: app.mResource.strings.bAbout,
                style: app.mResource.fonts.bold,
                height: 40,
                width: 300,
                function: () async {
                  //await generateData();
                  //print("Done");
                  app.mPage.nextPage(const ServicesPage());
                },
                colourPressed: app.mResource.colours.buttonLight,
                colourUnpressed: app.mResource.colours.buttonLight,
              ),
              CustomHybridButton(
                image: app.mResource.images.bLogOut,
                text: app.mResource.strings.bLogOut,
                style: app.mResource.fonts.bold,
                height: 40,
                width: 300,
                function: () async {
                  await app.mApp.buildActionDialog(
                    context,
                    app.mResource.strings.pLogOut,
                    action2: () {
                      FirebaseAuth.instance.signOut();
                      app.mPage.newPage(const LandingPage());
                    },
                  );
                },
                colourPressed: app.mResource.colours.buttonLight,
                colourUnpressed: app.mResource.colours.buttonLight,
              ),
            ],
          ),
        ),
        Container(),
      ],
    );
  }

  Widget getMainButton () {
    if (app.mData.user!.stage == 0) {
      return CustomHybridButton(
        image: app.mResource.images.bSchedule,
        text: app.mResource.strings.bMainButton[0],
        style: app.mResource.fonts.bold,
        height: 40,
        width: 300,
        function: () async {
          await app.mData.getProductData();
          app.mPage.nextPage(const ListingsPage());
        },
        colourUnpressed: app.mResource.colours.buttonOrange,
        colourPressed: app.mResource.colours.buttonOrange,
      );
    }

    if (app.mData.user!.stage == 1) {
      if ((app.mData.user!.order!.year * 10000 + app.mData.user!.order!.month * 100 + app.mData.user!.order!.day) == (DateTime.now().year * 1000 + DateTime.now().month * 100 + DateTime.now().day)) {
        return Container(
          height: 40,
        );
      }
      else {
        return CustomHybridButton(
          image: app.mResource.images.bSchedule,
          text: app.mResource.strings.bMainButton[1],
          style: app.mResource.fonts.bold,
          height: 40,
          width: 300,
          function: () async {
            app.mPage.nextPage(const EditOrdersPage());
          },
          colourUnpressed: app.mResource.colours.buttonOrange,
          colourPressed: app.mResource.colours.buttonOrange,
        );
      }
    }
    if (app.mData.user!.stage == 2) {
      return CustomHybridButton(
        image: app.mResource.images.bShopping,
        text: app.mResource.strings.bMainButton[2],
        style: app.mResource.fonts.bold,
        height: 40,
        width: 300,
        function: () async {
          await app.mData.getOrderItemData();
          app.mPage.nextPage(const ConfirmPage());
        },
        colourUnpressed: app.mResource.colours.buttonOrange,
        colourPressed: app.mResource.colours.buttonOrange,
      );
    }
    else {
      return Container(
        height: 40,
      );
    }
  }

  Widget buildStageTracker () {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(app.mResource.strings.hShoppingStage, style: app.mResource.fonts.headerLight,),
          Container(
            height: 10,
          ),
          Text(getStageText(app.mData.user!.stage), style: app.mResource.fonts.base,),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

  String getStageText (int index) {
    if (index == 0) {
      return app.mResource.strings.pShoppingStage(0);
    }
    if (index == 1) {
      Order order = app.mData.user!.order!;
      if (DateTime.now().year == order.year &&
          DateTime.now().month == order.month &&
          DateTime.now().day == order.day) {
        return app.mResource.strings.pShoppingStage(2);
      }
      else {
        String dateString = order.year.toString() + app.mResource.strings.cYear + " " + order.month.toString() + app.mResource.strings.cMonth + " " + order.day.toString() + app.mResource.strings.cDay;
        String phoneNumberString = app.mData.user!.phoneNumber!.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{4})+(?!\d))'), (Match m) => '${m[1]}-');
        return app.mResource.strings.pShoppingStage(1, param1: dateString, param2: phoneNumberString);
      }
    }
    if (index == 2) {
      return app.mResource.strings.pShoppingStage(3);
    }
    return "";
  }

  Widget buildStage (int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
      width: 100,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: (app.mData.user!.stage >= index) ? app.mResource.colours.black : app.mResource.colours.transparent,
              border: Border.all(color: (app.mData.user!.stage >= index) ? app.mResource.colours.black : app.mResource.colours.inactiveDate),
            ),
            child: Text((index + 1).toString(), style: TextStyle(color: (app.mData.user!.stage >= index) ? app.mResource.colours.fontWhite : app.mResource.colours.inactiveDate),),
          ),
          Container(
            height: 5,
          ),
          Text(app.mResource.strings.lShoppingStage[index], style: (app.mData.user!.stage >= index) ? app.mResource.fonts.small : app.mResource.fonts.smallInactive,),
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
      "deliveries": ["", "", "", "", "", "", "", "", "", "",],
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
