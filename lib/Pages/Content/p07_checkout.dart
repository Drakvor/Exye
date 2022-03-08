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

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
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
          CustomHeader(app.mResource.strings.hSchedule1),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(),
                  ),
                  CustomHybridButton(
                    image: app.mResource.images.bSchedule,
                    text: app.mResource.strings.bScheduleApp,
                    style: app.mResource.fonts.bold,
                    height: 40,
                    width: 180,
                    function: () async {
                      await app.mData.getCalendarData(DateTime.now().year, DateTime.now().month);
                      next();
                    },
                    colourUnpressed: app.mResource.colours.buttonLight,
                    colourPressed: app.mResource.colours.buttonLight,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  CustomHybridButton(
                    image: app.mResource.images.bCall,
                    text: app.mResource.strings.bScheduleCall,
                    style: app.mResource.fonts.bold,
                    height: 40,
                    width: 180,
                    function: () async {
                      await launch("tel:01065809860");
                      app.mPage.prevPage();
                    },
                    colourUnpressed: app.mResource.colours.buttonLight,
                    colourPressed: app.mResource.colours.buttonLight,
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(),
                  ),
                  const CustomFooter(),
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
              type: 1,
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
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(app.mResource.strings.lDate, style: app.mResource.fonts.base,),
                        ),
                        Expanded(
                          child: Text((date?.month.toString() ?? "_") + app.mResource.strings.cMonth + " " + (date?.day.toString() ?? "_") + app.mResource.strings.cDay, style: app.mResource.fonts.bold,),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(app.mResource.strings.lTime, style: app.mResource.fonts.base,),
                        ),
                        Expanded(
                          child: Text(slot.toString() + " " + app.mResource.strings.cTime, style: app.mResource.fonts.bold,),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(app.mResource.strings.lAddress, style: app.mResource.fonts.base,),
                        ),
                        Expanded(
                          child: Text(app.mData.user!.address!, style: app.mResource.fonts.bold,),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(app.mResource.strings.lName, style: app.mResource.fonts.base,),
                        ),
                        Expanded(
                          child: Text(app.mData.user!.name ?? "", style: app.mResource.fonts.bold,),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 75,
                          child: Text(app.mResource.strings.lPhoneNumber, style: app.mResource.fonts.base,),
                        ),
                        Expanded(
                          child: Text(app.mData.user!.phoneNumber ?? "", style: app.mResource.fonts.bold,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: CustomFooter(
              button1: CustomTextButton(
                text: app.mResource.strings.bPrev,
                style: app.mResource.fonts.bold,
                height: 40,
                width: 80,
                function: () {
                  setState(() {
                    prev();
                  });
                },
                colourUnpressed: app.mResource.colours.buttonLight,
                colourPressed: app.mResource.colours.buttonLight,
              ),
              button2: CustomTextButton(
                text: app.mResource.strings.bBook,
                style: app.mResource.fonts.bWhite,
                height: 40,
                width: 80,
                function: () async {
                  await app.mData.nextStage();
                  await app.mData.createOrder(date!, slot);
                  app.mPage.newPage(const HomePage());
                  await app.mApp.buildAlertDialog(context, app.mResource.strings.aOrdered);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
