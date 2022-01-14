import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController control;
  final String text;
  final FocusNode node;
  final int index;
  const CustomTextField({required this.control, required this.text, required this.node, required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: app.mResource.colours.textBorder,
          width: 2,
        ),
      ),
      child: TextField(
        controller: control,
        focusNode: node,
        keyboardType: TextInputType.none,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: text,
          hintStyle: app.mResource.fonts.base,
        ),
        onTap: () {
          app.mApp.input.setActive(index);
        },
      ),
    );
  }
}
