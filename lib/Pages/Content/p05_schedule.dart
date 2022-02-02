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

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  PageController control = PageController();
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
          const CustomHeader("Schedule"),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextButton(
                    text: "Schedule Now",
                    style: app.mResource.fonts.bWhite,
                    height: 30,
                    width: 100,
                    function: () async {
                      await app.mData.getCalendarData(DateTime.now().year, DateTime.now().month);
                      next();
                    },
                  ),
                  CustomTextButton(
                    text: "Phonecall",
                    style: app.mResource.fonts.bWhite,
                    height: 30,
                    width: 100,
                    function: () async {
                      await launch("tel:01065809860");
                      app.mPage.prevPage();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPageTwo () {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          CustomHeader(app.mResource.strings.hCalendar),
          Expanded(
            child: CustomCalendar(
              finish: (Timeslot x, int y) {
                setState(() {
                  date = x;
                  slot = y;
                });
                next();
              },
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
                        child: Text(app.mResource.strings.lName),
                      ),
                      Expanded(
                        child: Text((app.mData.user!.lastName ?? "") + (app.mData.user!.firstName ?? "")),
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
            button1: CustomTextButton(
              text: "Prev",
              style: app.mResource.fonts.bWhite,
              height: 30,
              width: 50,
              function: () {
                setState(() {
                  prev();
                });
              },
            ),
            button2: CustomTextButton(
              text: "Next",
              style: app.mResource.fonts.bWhite,
              height: 30,
              width: 50,
              function: () async {
                await app.mData.nextStage();
                await app.mData.createAppointment(date!, slot);
                app.mPage.newPage(const HomePage());
                await app.mApp.buildAlertDialog(context, "Scheduled");
              },
            ),
          ),
        ],
      ),
    );
  }
}
