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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: app.mResource.colours.textBorder,
              width: 1,
            ),
          ),
          child: TextField(
            controller: control,
            focusNode: node,
            keyboardType: TextInputType.none,
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: const EdgeInsets.fromLTRB(55, 5, 10, 5),
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
        ),
        Positioned(
          left: 5,
          top: 0,
          bottom: 0,
          width: 20,
          child: Container(
            alignment: Alignment.center,
            height: 15,
            width: 20,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Image.asset(app.mResource.images.koreanFlag),
            ),
          ),
        ),
        Positioned(
          left: 30,
          top: 0,
          bottom: 0,
          width: 25,
          child: Container(
            alignment: Alignment.center,
            height: 15,
            child: const Text("+82"),
          ),
        ),
      ],
    );
  }
}

class CustomPasswordInput extends StatefulWidget {
  const CustomPasswordInput({Key? key}) : super(key: key);

  @override
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

