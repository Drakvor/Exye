import 'package:exye_app/Pages/Content/p07_checkout.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_page_view_element.dart';
import 'package:exye_app/Widgets/custom_textfield.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class FirstTimePage extends StatefulWidget {
  const FirstTimePage({Key? key}) : super(key: key);

  @override
  _FirstTimePageState createState() => _FirstTimePageState();
}

class _FirstTimePageState extends State<FirstTimePage> {
  @override
  Widget build(BuildContext context) {
    return CustomPageViewElement(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomHeader(app.mResource.strings.hFirstTime),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            height: 60,
            child: Row(
              children: [
                Text(app.mResource.strings.lAddress),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: CustomAddressSearch(
                      control: app.mApp.input.controls[0],
                      index: 0,
                      text: app.mResource.strings.lAddress,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              children: [
                Text(app.mResource.strings.lAddress),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: CustomAddressField(
                      control: app.mApp.input.controls[1],
                      node: app.mApp.node,
                      index: 1,
                      text: app.mResource.strings.lAddressDetails,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
          CustomFooter(
            button1: CustomTextButton(
              text: "Confirm",
              style: app.mResource.fonts.bWhite,
              height: 30,
              width: 50,
              function: () async {
                if (app.mApp.input.controls[1].text == "") {
                  await app.mApp.buildAlertDialog(context, app.mResource.strings.eDetailedAddress);
                }
                else {
                  app.mData.user!.address = app.mApp.input.controls[0].text + " " + app.mApp.input.texts[1];
                  app.mPage.replacePage(const CheckOutPage());
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
