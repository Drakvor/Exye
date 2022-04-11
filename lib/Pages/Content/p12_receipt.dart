import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:flutter/material.dart';
import 'package:exye_app/utils.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomShortHeader(app.mResource.strings.hReceipt),
        Expanded(
          child: Container()
        ),
        const CustomFooterToHome(),
      ],
    );
  }
}
