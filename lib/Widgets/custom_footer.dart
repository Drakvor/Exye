import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  final Widget? button1;
  final Widget? button2;
  const CustomFooter({this.button1, this.button2, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageButton(
            image: app.mResource.images.bExit,
            height: 30,
            width: 30,
            function: () {
              app.mPage.prevPage();
            },
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              button1 ?? Container(),
              button2 ?? Container(),
            ],
          ),
        ],
      ),
    );
  }
}
