import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String text;
  const CustomHeader(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            alignment: Alignment.center,
            child: CustomTextButton(
              text: "back",
              style: app.mResource.fonts.base,
              height: 25,
              width: 45,
              function: () {
                app.mPage.prevPage();
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(text),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }
}
