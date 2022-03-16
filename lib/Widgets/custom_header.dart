import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_divider.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String text;
  const CustomHeader(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              app.mPage.newPage(const HomePage());
            },
            child: Text("Spez", style: app.mResource.fonts.headerLarge,),
          ),
          Expanded(
            child: Container(),
          ),
          Text(text, style: app.mResource.fonts.headerLarge,),
          const CustomHeaderDivider(),
        ],
      ),
    );
  }
}

class CustomShortHeader extends StatelessWidget {
  final String text;
  const CustomShortHeader(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              app.mPage.newPage(const HomePage());
            },
            child: Text("Spez", style: app.mResource.fonts.headerLarge,),
          ),
          Expanded(
            child: Container(),
          ),
          Text(text, style: app.mResource.fonts.headerLarge,),
          const CustomHeaderDivider(),
        ],
      ),
    );
  }
}
