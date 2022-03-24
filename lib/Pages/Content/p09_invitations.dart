import 'dart:io';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_keyboard.dart';
import 'package:exye_app/Widgets/custom_textfield.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/cupertino.dart';
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
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
        buildPageTwo(),
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
              Text(app.mResource.strings.pInvitation1 + app.mData.user!.invitations.toString() + "장", style: app.mResource.fonts.headerLight,),
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
          function: () async {
            try {
              PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
              next();
              setState(() {
                app.mApp.input.setText(contact.phoneNumber?.number?.replaceAll(RegExp(r'[^0-9]'), '') ?? "", index: 1);
              });
            }
            catch (e) {
              app.mOverlay.overlayOff();
            }
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
          function: () async {
            next();
          },
          height: 40,
          width: 180,
          colourPressed: app.mResource.colours.buttonLight,
          colourUnpressed: app.mResource.colours.buttonLight,
        ),
        Expanded(
          flex: 3,
          child: Container(),
        ),
        const CustomFooter(),
      ],
    );
  }

  Widget buildPageTwo () {
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
              SizedBox(
                width: (MediaQuery.of(context).size.width - 40) / 4,
                child: Text(app.mResource.strings.pAreas1, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 40) / 4,
                child: Text(app.mResource.strings.pAreas2, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 40) / 4,
                child: Text(app.mResource.strings.pAreas3, style: app.mResource.fonts.bold,),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 40) / 4,
                child: Text(app.mResource.strings.pAreas4, style: app.mResource.fonts.bold,),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: CustomTextField(
            control: app.mApp.input.textControl,
            index: 1,
            text: app.mResource.strings.iPhoneNumber,
            node: app.mApp.node,
            maxLength: 13,
            fullFunction: () {},
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: CustomTextButton(
            text: app.mResource.strings.bSendInvitation,
            style: app.mResource.fonts.bold,
            function: () async {
              if (app.mApp.input.texts[1].isEmpty) {
                await app.mApp.buildAlertDialog(context, app.mResource.strings.aNoNumber, app.mResource.strings.eNoNumber);
                return;
              }
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
            height: 40,
            width: 180,
            colourUnpressed: app.mResource.colours.buttonOrange,
            colourPressed: app.mResource.colours.buttonOrange,
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: CustomFooter(),
        ),
      ],
    );
  }
}
