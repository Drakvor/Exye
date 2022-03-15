import 'package:exye_app/Data/timeslot.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_textbox.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomCalendar extends StatefulWidget {
  final Function finish;
  final int type;
  const CustomCalendar({required this.finish, required this.type, Key? key}) : super(key: key);

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
      width: MediaQuery.of(context).size.width,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              (date == null) ? app.mResource.strings.pChooseDate : date!.month.toString() + app.mResource.strings.cMonth + " " + date!.day.toString() + app.mResource.strings.cDay,
              style: app.mResource.fonts.headerLight,
            ),
        ),
        Container(
          height: 10,
        ),
        CustomBox(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width - 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImageButton(
                      image: app.mResource.images.bPrev,
                      height: 25,
                      width: 25,
                      function: () async {
                        await app.mData.getCalendarData(app.mData.calendar!.prev!.year, app.mData.calendar!.prev!.month);
                        setState(()  {});
                      },
                    ),
                    Text(app.mData.calendar!.current!.month.toString() + app.mResource.strings.cMonth, style: app.mResource.fonts.header,),
                    CustomImageButton(
                      image: app.mResource.images.bNext,
                      height: 25,
                      width: 25,
                      function: () async {
                        await app.mData.getCalendarData(app.mData.calendar!.next!.year, app.mData.calendar!.next!.month);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: buildGrid(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooter(
            button2: CustomTextButton(
              text: app.mResource.strings.bNext,
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 80,
              function: () {
                if (date == null) {
                  app.mApp.buildAlertDialog(context, app.mResource.strings.eNoDate);
                }
                else {
                  setState(() {
                    next();
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSlotPicker () {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          alignment: Alignment.centerLeft,
          child: Text(
            (date == null) ? app.mResource.strings.pChooseDate : date!.month.toString() + app.mResource.strings.cMonth + " " + date!.day.toString() + app.mResource.strings.cDay + " " + slot.toString() + app.mResource.strings.cTime,
            style: app.mResource.fonts.headerLight,
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return CustomTimeslotButton(
                text: (index + 10).toString(),
                height: (MediaQuery.of(context).size.width - 120) / 7,
                width: (MediaQuery.of(context).size.width - 120) / 7,
                function: () {
                  setState(() {
                    slot = index + 10;
                  });
                },
                active: (date!.slots![index] == ""),
                slot: index + 10,
                chosen: slot,
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooter(
            button1: CustomTextButton(
              text: app.mResource.strings.bPrev,
              style: app.mResource.fonts.bold,
              height: 40,
              width: 80,
              function: () {
                setState(() {
                  slot = 0;
                  prev();
                });
              },
              colourUnpressed: app.mResource.colours.buttonLight,
              colourPressed: app.mResource.colours.buttonLight,
            ),
            button2: CustomTextButton(
              text: app.mResource.strings.bNext,
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 80,
              function: () async {
                if (slot == 0) {
                  app.mApp.buildAlertDialog(context, app.mResource.strings.eNoTime);
                }
                else {
                  widget.finish(date, slot);
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGrid () {
    int dayOneIndex = (app.mData.calendar!.current!.days[0].weekday == 0) ? 7 : app.mData.calendar!.current!.days[0].weekday;
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 1,
      ),
      itemCount: 49,
      itemBuilder: (BuildContext context, int index) {
        if (index < 7) {
          return Align(
            alignment: Alignment.center,
            child: Text(app.mResource.strings.weekdaysShort[index + 1], style: app.mResource.fonts.bold,),
          );
        }
        if ((index - 7) < dayOneIndex) {
          return Container();
        }
        if ((index - 7) >= dayOneIndex + app.mData.calendar!.current!.days.length) {
          return Container();
        }
        return CustomCalendarButton(
          height: (MediaQuery.of(context).size.width - 120) / 7,
          width: (MediaQuery.of(context).size.width - 120) / 7,
          function: () {
            setState(() {
              date = app.mData.calendar!.current!.days[(index - 7) - dayOneIndex];
            });
          },
          date: app.mData.calendar!.current!.days[(index - 7) - dayOneIndex],
          chosen: date,
          type: widget.type,
        );
      },
    );
  }
}

class CustomCalendarButton extends StatefulWidget {
  final Timeslot date;
  final Timeslot? chosen;
  final Function function;
  final double height;
  final double width;
  final int type;
  const CustomCalendarButton({required this.function, required this.date, required this.chosen, required this.height, required this.width, required this.type, Key? key}) : super(key: key);

  @override
  _CustomCalendarButtonState createState() => _CustomCalendarButtonState();
}

class _CustomCalendarButtonState extends State<CustomCalendarButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.function();
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.height / 2),
            border: (widget.date.isValid(widget.type) < 1) ? null : Border.all(width: 2, color: app.mResource.colours.black),
            color: (widget.date.isValid(widget.type) < 1) ? app.mResource.colours.transparent : ((widget.date == widget.chosen) ? app.mResource.colours.buttonPressed : app.mResource.colours.greyBackground),
          ),
          child: Text(
            widget.date.day.toString(),
            style: (widget.date.isValid(widget.type) < 1) ? app.mResource.fonts.inactive : app.mResource.fonts.bold,
          ),
        ),
      ),
    );
  }
}

class CustomTimeslotButton extends StatefulWidget {
  final String text;
  final double height;
  final double width;
  final Function function;
  final bool active;
  final int slot;
  final int chosen;
  const CustomTimeslotButton({required this.text, required this.height, required this.width, required this.function, required this.active, required this.slot, required this.chosen, Key? key}) : super(key: key);

  @override
  _CustomTimeslotButtonState createState() => _CustomTimeslotButtonState();
}

class _CustomTimeslotButtonState extends State<CustomTimeslotButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.function();
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: widget.height,
          width: widget.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.height / 2),
            border: !(widget.active) ? null : Border.all(width: 2, color: app.mResource.colours.black),
            color: !(widget.active) ? app.mResource.colours.transparent : ((widget.slot == widget.chosen) ? app.mResource.colours.buttonPressed : app.mResource.colours.greyBackground),
          ),
          child: Text(
            widget.slot.toString(),
            style: !(widget.active) ? app.mResource.fonts.inactive : app.mResource.fonts.bold,
          ),
        ),
      ),
    );
  }
}




