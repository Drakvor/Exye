import 'dart:io';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_keyboard.dart';
import 'package:exye_app/Widgets/custom_textfield.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:url_launcher/url_launcher.dart';

class InvitationsPage extends StatefulWidget {
  const InvitationsPage({Key? key}) : super(key: key);

  @override
  _InvitationsPageState createState() => _InvitationsPageState();
}

class _InvitationsPageState extends State<InvitationsPage> {
  PageController control = PageController();
  int state = 0;

  void next () {
    control.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(app.mResource.strings.hInvitations),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: buildPageView(),
          ),
        ),
      ],
    );
  }

  Widget buildPageView () {
    return PageView(
      controller: control,
      physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        buildPageOne(),
        (state == 0) ? buildPageTwoA() : buildPageTwoB(),
      ],
    );
  }

  Widget buildPageOne () {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(app.mResource.strings.pInvitation1, style: app.mResource.fonts.headerLight,),
              Container(
                height: 20,
              ),
              Text(app.mResource.strings.pInvitation2, style: app.mResource.fonts.base,),
            ],
          ),
        ),
        CustomHybridButton(
          image: app.mResource.images.bContacts,
          text: app.mResource.strings.bContacts,
          style: app.mResource.fonts.bold,
          function: () {
            setState(() {
              state = 0;
            });
            next();
          },
          height: 40,
          width: 180,
          colourPressed: app.mResource.colours.buttonLight,
          colourUnpressed: app.mResource.colours.buttonLight,
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
        CustomHybridButton(
          image: app.mResource.images.bDial,
          text: app.mResource.strings.bDial,
          style: app.mResource.fonts.bold,
          function: () {
            setState(() {
              state = 1;
            });
            next();
          },
          height: 40,
          width: 180,
          colourPressed: app.mResource.colours.buttonLight,
          colourUnpressed: app.mResource.colours.buttonLight,
        ),
        Expanded(
          flex: 5,
          child: Container(),
        ),
      ],
    );
  }

  Widget buildPageTwoA () {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(app.mResource.strings.pInvitation3, style: app.mResource.fonts.headerLight,),
        ),
        Container(
          height: 10,
        ),
        Text(app.mResource.strings.pInvitation4, style: app.mResource.fonts.base,),
        Container(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(app.mResource.strings.pAreas1, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(app.mResource.strings.pAreas2, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(app.mResource.strings.pAreas3, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(app.mResource.strings.pAreas4, style: app.mResource.fonts.bold,),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: CustomTextField(
            control: app.mApp.input.controls[1],
            index: 1,
            text: app.mResource.strings.iPhoneNumber,
            node: app.mApp.node,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: CustomTextButton(
            text: "Contacts",
            style: app.mResource.fonts.bWhite,
            function: () async {
              PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
              setState(() {
                app.mApp.input.setText(contact.phoneNumber?.number?.replaceAll(RegExp(r'[^0-9]'), '') ?? "", index: 1);
              });
            },
            height: 30,
            width: 100,
          ),
        ),
        CustomTextButton(
          text: "Confirm",
          style: app.mResource.fonts.bWhite,
          function: () async {
            await app.mData.createInvitation(app.mApp.input.texts[1]);
            if (Platform.isAndroid) {
              await launch("sms:${app.mApp.input.texts[1]}?body=OBSSENCE 초대권이 있어서 초대해요. 귀빈 전용 서비스라 반드시 전화번호로만 가입이 가능해요. 링크입니다!");
            }
            if (Platform.isIOS) {
              await launch("sms:${app.mApp.input.texts[1]};body=OBSSENCE 초대권이 있어서 초대해요. 귀빈 전용 서비스라 반드시 전화번호로만 가입이 가능해요. 링크입니다!");
            }
            app.mApp.input.clearAll();
            app.mPage.newPage(const HomePage());
          },
          height: 30,
          width: 100,
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }

  Widget buildPageTwoB () {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(app.mResource.strings.pInvitation3, style: app.mResource.fonts.headerLight,),
        ),
        Container(
          height: 10,
        ),
        Text(app.mResource.strings.pInvitation4, style: app.mResource.fonts.base,),
        Container(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerLeft,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(app.mResource.strings.pAreas1, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(app.mResource.strings.pAreas2, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(app.mResource.strings.pAreas3, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Text(app.mResource.strings.pAreas4, style: app.mResource.fonts.bold,),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: CustomTextField(
            control: app.mApp.input.controls[1],
            index: 1,
            text: app.mResource.strings.iPhoneNumber,
            node: app.mApp.node,
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: CustomTextButton(
            text: "Confirm",
            style: app.mResource.fonts.bWhite,
            function: () async {
              await app.mData.createInvitation(app.mApp.input.texts[1]);
              app.mApp.input.clearAll();
              app.mPage.newPage(const HomePage());
            },
            height: 30,
            width: 100,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        CustomKeyboard(
          keyCount: 12,
          columns: 3,
          height: (MediaQuery.of(context).size.width - 40) * 2/3,
          width: MediaQuery.of(context).size.width - 40,
          keys: app.mResource.strings.phoneNumberKeys,
          maxLength: 11,
        ),
      ],
    );
  }
}
