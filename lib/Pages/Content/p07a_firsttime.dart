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
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(app.mResource.strings.pInvitation3, style: app.mResource.fonts.headerLight,),
          ),
          Container(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(app.mResource.strings.pInvitation4, style: app.mResource.fonts.base,),
          ),
          Container(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
            margin: const EdgeInsets.fromLTRB(0, 5, 20, 5),
            height: 60,
            child: Row(
              children: [
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(app.mResource.strings.lAddress, style: app.mResource.fonts.header,),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: CustomAddressSearch(
                      control: app.mApp.input.controls[0],
                      index: 0,
                      text: app.mResource.strings.iAddress,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(0, 5, 20, 5),
            child: Row(
              children: [
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(app.mResource.strings.lAddressDetails, style: app.mResource.fonts.header,),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: CustomAddressField(
                      control: app.mApp.input.controls[1],
                      node: app.mApp.node,
                      index: 1,
                      text: app.mResource.strings.iAddressDetails,
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
              text: app.mResource.strings.bConfirmAddress,
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 150,
              function: () async {
                if (app.mApp.input.controls[1].text == "") {
                  await app.mApp.buildAlertDialog(context, app.mResource.strings.aAddress, app.mResource.strings.eDetailedAddress);
                }
                else if (app.mApp.input.controls[0].text == "") {
                  await app.mApp.buildAlertDialog(context, app.mResource.strings.aAddress, app.mResource.strings.eAddress);
                }
                else {
                  app.mData.user!.address = app.mApp.input.controls[0].text;
                  app.mData.user!.addressDetails = app.mApp.input.texts[1];
                  await app.mData.updateAddress();
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
