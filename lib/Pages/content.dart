import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  final String state;
  const Content(this.state, {Key? key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  void initState () {
    super.initState();
    app.mPage.initialise(widget.state);
    app.mOverlay.initialise();
    app.mApp.input.initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPage(),
        buildOverlay(),
      ],
    );
  }

  Widget buildPage () {
    return SafeArea(
      child: app.mPage.pageNavObj!,
    );
  }

  Widget buildOverlay () {
    return app.mOverlay.overlayObj!;
  }
}