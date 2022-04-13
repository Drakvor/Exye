import 'package:exye_app/Data/timeslot.dart';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_calendar.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_textbox.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class EditOrdersPage extends StatefulWidget {
  const EditOrdersPage({Key? key}) : super(key: key);

  @override
  _EditOrdersPageState createState() => _EditOrdersPageState();
}

class _EditOrdersPageState extends State<EditOrdersPage> {
  PageController control = PageController();
  PageController calendarControl = PageController();
  Timeslot? date;
  int slot = 0;

  void next () {
    control.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void prev () {
    control.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: control,
      physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      allowImplicitScrolling: true,
      children: [
        buildPageOne(),
        buildPageTwo(),
        buildPageThree(),
      ],
    );
  }

  Widget buildPageOne () {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          CustomHeader(app.mResource.strings.hEditAppointment),
          Expanded(
            flex: 5,
            child: Container(),
          ),
          CustomHybridButton(
            image: app.mResource.images.bSchedule,
            text: app.mResource.strings.bEditApp,
            style: app.mResource.fonts.bold16,
            height: 60,
            width: 180,
            function: () async {
              next();
            },
            colourPressed: app.mResource.colours.buttonLight,
            colourUnpressed: app.mResource.colours.buttonLight,
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          CustomHybridButton(
            image: app.mResource.images.bCall,
            text: app.mResource.strings.bEditCall,
            style: app.mResource.fonts.bold16,
            height: 50,
            width: 180,
            function: () async {
              await launch("tel:01065809860");
              app.mPage.prevPage();
            },
            colourPressed: app.mResource.colours.buttonLight,
            colourUnpressed: app.mResource.colours.buttonLight,
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          CustomHybridButton(
            image: app.mResource.images.bScheduleCancel,
            text: app.mResource.strings.bEditCancel,
            style: app.mResource.fonts.bold16,
            height: 50,
            width: 180,
            function: () async {
              await app.mApp.buildActionDialog(
                context,
                app.mData.user!.order!.year.toString() + app.mResource.strings.cYear + " " + app.mData.user!.order!.month.toString() + app.mResource.strings.cMonth + " " + app.mData.user!.order!.day.toString() + app.mResource.strings.cDay + " " + app.mData.user!.order!.timeslot.toString() + app.mResource.strings.cTime,
                app.mResource.strings.aConfirmCancel,
                action: () async {
                  await app.mData.cancelOrder();
                  await app.mData.prevStage();
                  app.mPage.newPage(const HomePage());
                  await app.mApp.buildAlertDialog(context, app.mResource.strings.aCancelled, app.mResource.strings.apCancelled);
                },
              );
            },
            colourPressed: app.mResource.colours.buttonLight,
            colourUnpressed: app.mResource.colours.buttonLight,
          ),
          Expanded(
            flex: 5,
            child: Container(),
          ),
          const CustomFooter(),
        ],
      ),
    );
  }

  Widget buildPageTwo () {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
            child: CustomCalendar(
              control: calendarControl,
              back: () {
                prev();
              },
              finish: (Timeslot x, int y) {
                setState(() {
                  date = x;
                  slot = y;
                });
                next();
              },
              type: 1,
              oldSlot: app.mData.user!.order!.timeslot,
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  Widget buildPageThree () {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          CustomHeader(app.mResource.strings.hSchedule3),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: CustomBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(app.mResource.strings.lDate),
                      ),
                      Expanded(
                        child: Text((date?.month.toString() ?? "_") + app.mResource.strings.cMonth + " " + (date?.day.toString() ?? "_") + app.mResource.strings.cDay),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(app.mResource.strings.lTime),
                      ),
                      Expanded(
                        child: Text(slot.toString() + " " + app.mResource.strings.cTime),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(app.mResource.strings.lAddress),
                      ),
                      Expanded(
                        child: Text(app.mData.user!.address!),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(app.mResource.strings.lName),
                      ),
                      Expanded(
                        child: Text(app.mData.user!.name ?? ""),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(app.mResource.strings.lPhoneNumber),
                      ),
                      Expanded(
                        child: Text(app.mData.user!.phoneNumber ?? ""),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          CustomFooter(
            button1: CustomHybridButton(
              image: app.mResource.images.bPrev,
              text: app.mResource.strings.bPrev,
              style: app.mResource.fonts.bold16,
              height: 50,
              width: 90,
              function: () {
                prev();
              },
              colourPressed: app.mResource.colours.buttonLight,
              colourUnpressed: app.mResource.colours.buttonLight,
            ),
            button2: CustomTextButton(
              text: app.mResource.strings.bChangeDate,
              style: app.mResource.fonts.bold16,
              height: 50,
              width: 90,
              function: () async {
                await app.mData.changeOrder(date!, slot);
                app.mPage.newPage(const HomePage());
                await app.mApp.buildAlertDialog(context, app.mData.user!.order!.year.toString() + app.mResource.strings.cYear + " " + app.mData.user!.order!.month.toString() + app.mResource.strings.cMonth + " " + app.mData.user!.order!.day.toString() + app.mResource.strings.cDay + " " + app.mData.user!.order!.timeslot.toString() + app.mResource.strings.cTime, app.mResource.strings.apEdited);
              },
              colourUnpressed: app.mResource.colours.buttonOrange,
              colourPressed: app.mResource.colours.buttonOrange,
            ),
          ),
        ],
      ),
    );
  }
}

