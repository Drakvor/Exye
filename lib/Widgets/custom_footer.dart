import 'package:exye_app/Pages/Content/p04_home.dart';
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
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.center,
      color: app.mResource.colours.semiBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageButton(
            image: app.mResource.images.bExit,
            height: 40,
            width: 40,
            function: () {
              app.mPage.prevPage();
            },
            colourPressed: app.mResource.colours.transparent,
            colourUnpressed: app.mResource.colours.transparent,
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              button1 ?? Container(),
              Container(
                width: 10,
              ),
              button2 ?? Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomFooterToHome extends StatelessWidget {
  final Widget? button1;
  final Widget? button2;
  const CustomFooterToHome({this.button1, this.button2, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.center,
      color: app.mResource.colours.semiBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImageButton(
            image: app.mResource.images.bExit,
            height: 40,
            width: 40,
            function: () {
              app.mPage.newPage(const HomePage());
            },
            colourPressed: app.mResource.colours.transparent,
            colourUnpressed: app.mResource.colours.transparent,
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              button1 ?? Container(),
              Container(
                width: 10,
              ),
              button2 ?? Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomFooterNoExit extends StatelessWidget {
  final Widget? button1;
  final Widget? button2;
  const CustomFooterNoExit({this.button1, this.button2, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.center,
      color: app.mResource.colours.semiBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              button1 ?? Container(),
              Container(
                width: 10,
              ),
              button2 ?? Container(),
            ],
          ),
        ],
      ),
    );
  }
}
