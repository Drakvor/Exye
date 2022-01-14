import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  PageController control = PageController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomHeader(app.mResource.strings.hTerms),
        Expanded(
          child: buildTerms(),
        ),
        buildButtons(),
      ],
    );
  }

  Widget buildTerms () {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: PageView(
        controller: control,
        physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            color: app.mResource.colours.background2,
            child: Text(app.mResource.strings.hTerms),
          ),
          Container(
            color: app.mResource.colours.background2,
            child: Text(app.mResource.strings.hPolicy),
          ),
        ],
      ),
    );
  }

  Widget buildButtons () {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (page == 1) ? CustomTextButton(
            text: app.mResource.strings.bPrev,
            style: app.mResource.fonts.base,
            height: 25,
            width: 45,
            function: () {
              setState(() {
                page = 0;
              });
              control.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.linear);
            },
          ) : Container(
            width: 45,
          ),
          (page == 0) ? CustomTextButton(
            text: app.mResource.strings.bNext,
            style: app.mResource.fonts.base,
            height: 25,
            width: 45,
            function: () {
              setState(() {
                page = 1;
              });
              control.animateToPage(1, duration: const Duration(milliseconds: 200), curve: Curves.linear);
            },
          ) : Container(
            width: 45,
          ),
        ],
      ),
    );
  }
}
