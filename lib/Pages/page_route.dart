import 'package:flutter/material.dart';
//import 'package:exye_app/utils.dart';

class CustomPageRoute extends PageRouteBuilder {
  Widget page;
  CustomPageRoute(this.page) : super(
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
      return page;
    },
  );
}