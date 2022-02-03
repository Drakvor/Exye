import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_textfield.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomSurvey extends StatefulWidget {
  final CustomSurveyState state;
  const CustomSurvey(this.state, {Key? key}) : super(key: key);

  @override
  _CustomSurveyState createState() => _CustomSurveyState();
}

class _CustomSurveyState extends State<CustomSurvey> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(app.mResource.strings.lName),
              ),
              Expanded(
                child: CustomAddressField(
                  control: app.mApp.input.controls[0],
                  node: app.mApp.node,
                  index: 0,
                  text: app.mResource.strings.lName,
                ),
              ),
            ],
          ),
          buildGenderChoices(),
          buildAgeChoices(),
        ],
      ),
    );
  }

  Widget buildGenderChoices () {
    return Row(
      children: [
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Text(app.mResource.strings.lGender),
        ),
        CustomTextToggle(
          key: UniqueKey(),
          text: app.mResource.strings.lMale,
          style: app.mResource.fonts.base,
          function: () {
            setState(() {
              widget.state.gender = "Male";
            });
          },
          height: 30,
          width: 50,
          initial: (widget.state.gender == "Male"),
        ),
        Expanded(
          child: Container(),
        ),
        CustomTextToggle(
          key: UniqueKey(),
          text: app.mResource.strings.lMale,
          style: app.mResource.fonts.base,
          function: () {
            setState(() {
              widget.state.gender = "Female";
            });
          },
          height: 30,
          width: 50,
          initial: (widget.state.gender == "Female"),
        ),
      ],
    );
  }

  Widget buildAgeChoices () {
    return Row(
      children: [
        Container(
          width: 50,
          alignment: Alignment.center,
          child: Text(app.mResource.strings.lAge),
        ),
        CustomTextToggle(
          key: UniqueKey(),
          text: app.mResource.strings.lAge0,
          style: app.mResource.fonts.base,
          function: () {
            setState(() {
              widget.state.age = 0;
            });
          },
          height: 30,
          width: 50,
          initial: (widget.state.age == 0),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        CustomTextToggle(
          key: UniqueKey(),
          text: app.mResource.strings.lAge1,
          style: app.mResource.fonts.base,
          function: () {
            setState(() {
              widget.state.age = 1;
            });
          },
          height: 30,
          width: 50,
          initial: (widget.state.age == 1),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        CustomTextToggle(
          key: UniqueKey(),
          text: app.mResource.strings.lAge2,
          style: app.mResource.fonts.base,
          function: () {
            setState(() {
              widget.state.age = 2;
            });
          },
          height: 30,
          width: 50,
          initial: (widget.state.age == 2),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        CustomTextToggle(
          key: UniqueKey(),
          text: app.mResource.strings.lAge3,
          style: app.mResource.fonts.base,
          function: () {
            setState(() {
              widget.state.age = 3;
            });
          },
          height: 30,
          width: 50,
          initial: (widget.state.age == 3),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        CustomTextToggle(
          key: UniqueKey(),
          text: app.mResource.strings.lAge4,
          style: app.mResource.fonts.base,
          function: () {
            setState(() {
              widget.state.age = 4;
            });
          },
          height: 30,
          width: 50,
          initial: (widget.state.age == 4),
        ),
      ],
    );
  }
}

class CustomAddressSurvey extends StatefulWidget {
  final CustomSurveyState state;
  const CustomAddressSurvey(this.state, {Key? key}) : super(key: key);

  @override
  _CustomAddressSurveyState createState() => _CustomAddressSurveyState();
}

class _CustomAddressSurveyState extends State<CustomAddressSurvey> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(app.mResource.strings.lAddress),
              ),
              Expanded(
                child: CustomAddressSearch(
                  control: app.mApp.input.controls[1],
                  index: 1,
                  text: app.mResource.strings.lAddress,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(app.mResource.strings.lAddressDetails),
              ),
              Expanded(
                child: CustomAddressField(
                  control: app.mApp.input.controls[2],
                  node: app.mApp.node,
                  index: 2,
                  text: app.mResource.strings.lAddressDetails,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomBodySurvey extends StatefulWidget {
  final CustomSurveyState state;
  const CustomBodySurvey(this.state, {Key? key}) : super(key: key);

  @override
  _CustomBodySurveyState createState() => _CustomBodySurveyState();
}

class _CustomBodySurveyState extends State<CustomBodySurvey> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(app.mResource.strings.lHeight),
              ),
              Expanded(
                child: CustomNumberField(
                  control: app.mApp.input.controls[1],
                  index: 1,
                  node: app.mApp.node,
                  text: app.mResource.strings.lHeight,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(app.mResource.strings.lWeight),
              ),
              Expanded(
                child: CustomNumberField(
                  control: app.mApp.input.controls[2],
                  node: app.mApp.node,
                  index: 2,
                  text: app.mResource.strings.lWeight,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


class CustomSurveyState {
  String name = "";
  String gender = "";
  int age = -1;

  String address = "";
  String addressDetails = "";

  int height = 0;
  int weight = 0;
}
