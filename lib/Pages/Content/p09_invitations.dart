import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class InvitationsPage extends StatefulWidget {
  const InvitationsPage({Key? key}) : super(key: key);

  @override
  _InvitationsPageState createState() => _InvitationsPageState();
}

class _InvitationsPageState extends State<InvitationsPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(app.mResource.strings.hInvitations),
        Container(),
      ],
    );
  }

  Widget buildPageView () {
    return PageView(
      children: [
        Container(),
        Container(),
      ],
    );
  }
}
