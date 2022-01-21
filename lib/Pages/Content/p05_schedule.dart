import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_calendar.dart';
import 'package:exye_app/Widgets/custom_header.dart';
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
          const Expanded(
            child: CustomCalendar(),
          ),
          Container(),
        ],
      ),
    );
  }
}
