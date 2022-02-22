import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget buildPage () {
    return Column(
      children: [
        CustomShortHeader(app.mResource.strings.hConfirm),
        Expanded(
          child: Container(),
        ),
        CustomFooter(
          button2: CustomTextButton(
            text: app.mResource.strings.bConfirmPurchase,
            style: app.mResource.fonts.bWhite,
            height: 40,
            width: 100,
            function: () async {
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
