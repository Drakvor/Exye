import 'package:flutter/material.dart';

class CustomSurvey extends StatefulWidget {
  const CustomSurvey({Key? key}) : super(key: key);

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
          Container(),
        ],
      ),
    );
  }
}

class CustomSurveyState {
  String name = "";
  String gender = "";
  int age = -1;
}
