import 'package:exye_app/Data/timeslot.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({Key? key}) : super(key: key);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  PageController control = PageController();
  Timeslot? date;
  int slot = 0;

  void next () {
    control.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void prev () {
    control.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width - 20,
      width: MediaQuery.of(context).size.width - 60,
      child: PageView(
        controller: control,
        physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
          buildDatePicker(),
          buildSlotPicker(),
        ],
      ),
    );
  }

  Widget buildDatePicker () {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextButton(
              text: app.mResource.strings.bPrev,
              style: app.mResource.fonts.base,
              height: 20,
              width: 45,
              function: () async {
                await app.mData.getCalendarData(app.mData.calendar!.prev!.year, app.mData.calendar!.prev!.month);
                setState(()  {});
              },
            ),
            Text(app.mResource.strings.months[app.mData.calendar!.current!.month - 1] + " " + app.mData.calendar!.current!.year.toString()),
            CustomTextButton(
              text: app.mResource.strings.bNext,
              style: app.mResource.fonts.base,
              height: 20,
              width: 45,
              function: () async {
                await app.mData.getCalendarData(app.mData.calendar!.next!.year, app.mData.calendar!.next!.month);
                setState(() {});
              },
            ),
          ],
        ),
        Expanded(
          child: buildGrid(),
        ),
      ],
    );
  }

  Widget buildSlotPicker () {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextButton(
          text: app.mResource.strings.cSlot1,
          style: app.mResource.fonts.base,
          height: 30,
          width: 100,
          function: () async {
            app.mOverlay.overlayOff();
            await app.mApp.buildAlertDialog(context, date!.year.toString() + "/" + date!.month.toString() + "/" + date!.day.toString() + " " + app.mResource.strings.cSlot1);
            prev();
          },
        ),
        CustomTextButton(
          text: app.mResource.strings.cSlot2,
          style: app.mResource.fonts.base,
          height: 30,
          width: 100,
          function: () async {
            app.mOverlay.overlayOff();
            await app.mApp.buildAlertDialog(context, date!.year.toString() + "/" + date!.month.toString() + "/" + date!.day.toString() + " " + app.mResource.strings.cSlot2);
            prev();
          },
        ),
      ],
    );
  }

  Widget buildGrid () {
    int dayOneIndex = (app.mData.calendar!.current!.days[0].weekday == 0) ? 7 : app.mData.calendar!.current!.days[0].weekday;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisExtent: MediaQuery.of(context).size.width / 7,
      ),
      itemCount: 42,
      itemBuilder: (BuildContext context, int index) {
        if (index < dayOneIndex) {
          return CustomTextButton(
            text: app.mData.calendar!.prev!.days[app.mData.calendar!.prev!.days.length - (dayOneIndex - index)].day.toString(),
            style: app.mResource.fonts.inactive,
            height: 20,
            width: 20,
            function: () {
              date = app.mData.calendar!.prev!.days[app.mData.calendar!.prev!.days.length - (dayOneIndex - index)];
              next();
            },
            colourUnpressed: app.mResource.colours.otherMonth,
            active: false,
          );
        }
        if (index >= dayOneIndex + app.mData.calendar!.current!.days.length) {
          return CustomTextButton(
            text: app.mData.calendar!.next!.days[index - (dayOneIndex + app.mData.calendar!.current!.days.length)].day.toString(),
            style: app.mResource.fonts.inactive,
            height: 20,
            width: 20,
            function: () {
              date = app.mData.calendar!.next!.days[index - (dayOneIndex + app.mData.calendar!.current!.days.length)];
              next();
            },
            colourUnpressed: app.mResource.colours.otherMonth,
            active: false,
          );
        }
        return CustomTextButton(
          text: app.mData.calendar!.current!.days[index - dayOneIndex].day.toString(),
          style: app.mResource.fonts.base,
          height: 20,
          width: 20,
          function: () {
            date = app.mData.calendar!.current!.days[index - dayOneIndex];
            next();
          },
          colourUnpressed: (app.mData.calendar!.current!.days[index - dayOneIndex].available > 0) ? app.mResource.colours.activeDateUnpressed : app.mResource.colours.inactiveDate,
          colourPressed: app.mResource.colours.activeDatePressed,
          active: (app.mData.calendar!.current!.days[index - dayOneIndex].available > 0),
        );
      },
    );
  }
}

