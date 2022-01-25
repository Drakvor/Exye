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
  final int inputNo;
  const CustomPasswordInput(this.inputNo, {Key? key}) : super(key: key);

  @override
  _CustomPasswordInputState createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildDigit(0),
          buildDigit(1),
          buildDigit(2),
          buildDigit(3),
          buildDigit(4),
          buildDigit(5),
        ],
      ),
    );
  }

  Widget buildDigit (int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: (app.mApp.input.texts[widget.inputNo].length > index) ? buildShape(true) : ((app.mApp.input.show) ? buildText() : buildShape(false)),
    );
  }

  Widget buildText () {
    return Container();
  }

  Widget buildShape (bool empty) {
    return Container();
  }
}

