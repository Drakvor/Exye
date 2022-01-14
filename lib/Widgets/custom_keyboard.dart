import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomKeyboard extends StatelessWidget {
  final int keyCount;
  final int columns;
  final double height;
  final double width;
  final List<String> keys;
  final int maxLength;
  const CustomKeyboard({
    required this.keyCount,
    required this.columns,
    required this.height,
    required this.width,
    required this.keys,
    this.maxLength = 20,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisExtent: height/(keyCount/columns),
        ),
        itemCount: keyCount,
        itemBuilder: (BuildContext context, int index) {
          if (index == keyCount - 1) {
            return CustomBackspace(height/(keyCount/columns), width/columns, maxLength);
          }
          else if (keys[index] == "") {
            return Container();
          }
          return CustomKeys(keys[index], height/(keyCount/columns), width/columns, maxLength);
        },
      ),
    );
  }
}

class CustomKeys extends StatefulWidget {
  final String s;
  final double height;
  final double width;
  final int maxLength;
  const CustomKeys(this.s, this.height, this.width, this.maxLength, {Key? key}) : super(key: key);

  @override
  _CustomKeysState createState() => _CustomKeysState();
}

class _CustomKeysState extends State<CustomKeys> {
  @override
  Widget build(BuildContext context) {
    return CustomKeyboardTextButton(
      text: widget.s,
      style: app.mResource.fonts.base,
      height: widget.height,
      width: widget.width,
      colourPressed: app.mResource.colours.background2,
      colourUnpressed: app.mResource.colours.background,
      function: () {
        if (app.mApp.input.texts[app.mApp.input.active].length < widget.maxLength - (widget.s.length - 1)) {
          app.mApp.input.add(widget.s);
        }
      },
    );
  }
}

class CustomBackspace extends StatefulWidget {
  final double height;
  final double width;
  final int maxLength;
  const CustomBackspace(this.height, this.width, this.maxLength, {Key? key}) : super(key: key);

  @override
  _CustomBackspaceState createState() => _CustomBackspaceState();
}

class _CustomBackspaceState extends State<CustomBackspace> {
  @override
  Widget build(BuildContext context) {
    return CustomKeyboardTextButton(
      text: "back",
      style: app.mResource.fonts.base,
      height: widget.height,
      width: widget.width,
      colourPressed: app.mResource.colours.background2,
      colourUnpressed: app.mResource.colours.background,
      function: () {
        app.mApp.input.backspace();
      },
    );
  }
}

