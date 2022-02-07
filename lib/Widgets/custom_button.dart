import 'dart:async';

import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Function function;
  final double height;
  final double width;
  final Color? colourPressed;
  final Color? colourUnpressed;
  final bool active;
  const CustomTextButton({
    required this.text,
    required this.style,
    required this.function,
    required this.height,
    required this.width,
    this.colourPressed,
    this.colourUnpressed,
    this.active = true,
    Key? key}) : super(key: key);

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.active) {
          setState(() {
            _pressed = true;
          });
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() {
            _pressed = false;
          });
          await widget.function();
        }
      },
      child: buildButton(),
    );
  }

  Widget buildButton () {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: _pressed ? (widget.colourPressed ?? app.mResource.colours.buttonPressed) : (widget.colourUnpressed ?? app.mResource.colours.buttonUnpressed),
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(color: app.mResource.colours.buttonBorder, width: 1),
      ),
      child: Center(
        child: Text(widget.text, style: widget.style,),
      ),
    );
  }
}

class CustomImageButton extends StatefulWidget {
  final String image;
  final Function function;
  final double height;
  final double width;
  final Color? colourPressed;
  final Color? colourUnpressed;
  final bool active;
  const CustomImageButton({
    required this.image,
    required this.function,
    required this.height,
    required this.width,
    this.colourPressed,
    this.colourUnpressed,
    this.active = true,
    Key? key}) : super(key: key);

  @override
  _CustomImageButtonState createState() => _CustomImageButtonState();
}

class _CustomImageButtonState extends State<CustomImageButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.active) {
          setState(() {
            _pressed = true;
          });
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() {
            _pressed = false;
          });
          await widget.function();
        }
      },
      child: buildButton(),
    );
  }

  Widget buildButton () {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: _pressed ? (widget.colourPressed ?? app.mResource.colours.buttonPressed) : (widget.colourUnpressed ?? app.mResource.colours.buttonUnpressed),
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(color: app.mResource.colours.buttonBorder, width: 1),
      ),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Image.asset(widget.image),
      ),
    );
  }
}

class CustomHybridButton extends StatefulWidget {
  final String image;
  final String text;
  final TextStyle style;
  final Function function;
  final double height;
  final double width;
  final Color? colourPressed;
  final Color? colourUnpressed;
  final bool active;
  const CustomHybridButton({
    required this.image,
    required this.text,
    required this.style,
    required this.function,
    required this.height,
    required this.width,
    this.colourPressed,
    this.colourUnpressed,
    this.active = true,
    Key? key}) : super(key: key);

  @override
  _CustomHybridButtonState createState() => _CustomHybridButtonState();
}

class _CustomHybridButtonState extends State<CustomHybridButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.active) {
          setState(() {
            _pressed = true;
          });
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() {
            _pressed = false;
          });
          await widget.function();
        }
      },
      child: buildButton(),
    );
  }

  Widget buildButton () {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: _pressed ? (widget.colourPressed ?? app.mResource.colours.buttonPressed) : (widget.colourUnpressed ?? app.mResource.colours.buttonUnpressed),
        borderRadius: BorderRadius.circular(widget.height / 2),
        border: Border.all(color: app.mResource.colours.buttonBorder, width: 1),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              height: 20,
              width: 20,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Image.asset(widget.image),
              ),
            ),
            Text(widget.text, style: widget.style,),
          ],
        ),
      ),
    );
  }
}

class CustomTextToggle extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Function function;
  final double height;
  final double width;
  final Color? colourPressed;
  final Color? colourUnpressed;
  final bool active;
  final bool initial;
  const CustomTextToggle({
    required this.text,
    required this.style,
    required this.function,
    required this.height,
    required this.width,
    this.colourPressed,
    this.colourUnpressed,
    this.active = true,
    this.initial = false,
    Key? key}) : super(key: key);

  @override
  _CustomTextToggleState createState() => _CustomTextToggleState();
}

class _CustomTextToggleState extends State<CustomTextToggle> {
  late bool _pressed;

  @override
  void initState () {
    super.initState();
    _pressed = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.active) {
          setState(() {
            _pressed = !_pressed;
          });
          await widget.function();
        }
      },
      child: buildButton(),
    );
  }

  Widget buildButton () {
    return Container(
      height: widget.height,
      width: widget.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _pressed ? (widget.colourPressed ?? app.mResource.colours.buttonPressed) : (widget.colourUnpressed ?? app.mResource.colours.buttonUnpressed),
        borderRadius: BorderRadius.circular(widget.height / 2),
      ),
      child: Text(widget.text, style: widget.style,)
    );
  }
}

class CustomImageToggle extends StatefulWidget {
  final String image;
  final String? imagePressed;
  final Function function;
  final double height;
  final double width;
  final Color? colourPressed;
  final Color? colourUnpressed;
  final bool active;
  final bool initial;
  const CustomImageToggle({
    required this.image,
    required this.function,
    required this.height,
    required this.width,
    this.imagePressed,
    this.colourPressed,
    this.colourUnpressed,
    this.active = true,
    this.initial = false,
    Key? key}) : super(key: key);

  @override
  _CustomImageToggleState createState() => _CustomImageToggleState();
}

class _CustomImageToggleState extends State<CustomImageToggle> {
  late bool _pressed;

  @override
  void initState () {
    super.initState();
    _pressed = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.active) {
          setState(() {
            _pressed = !_pressed;
          });
          await widget.function();
        }
      },
      child: buildButton(),
    );
  }

  Widget buildButton () {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: _pressed ? (widget.colourPressed ?? app.mResource.colours.buttonPressed) : (widget.colourUnpressed ?? app.mResource.colours.buttonUnpressed),
        borderRadius: BorderRadius.circular(widget.height / 2),
      ),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: _pressed ? (Image.asset(widget.imagePressed ?? widget.image)) : Image.asset(widget.image),
      ),
    );
  }
}


class CustomKeyboardTextButton extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Function function;
  final double height;
  final double width;
  final Color? colourPressed;
  final Color? colourUnpressed;
  const CustomKeyboardTextButton({
    required this.text,
    required this.style,
    required this.function,
    required this.height,
    required this.width,
    this.colourPressed,
    this.colourUnpressed,
    Key? key}) : super(key: key);

  @override
  _CustomKeyboardTextButtonState createState() => _CustomKeyboardTextButtonState();
}

class _CustomKeyboardTextButtonState extends State<CustomKeyboardTextButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (app.mApp.input.active != -1) {
          setState(() {
            _pressed = true;
          });
          await Future.delayed(const Duration(milliseconds: 200));
          setState(() {
            _pressed = false;
          });
          await widget.function();
        }
      },
      child: buildButton(),
    );
  }

  Widget buildButton () {
    return Container(
      height: widget.height,
      width: widget.width,
      color: _pressed ? (widget.colourPressed ?? app.mResource.colours.buttonPressed) : (widget.colourUnpressed ?? app.mResource.colours.buttonUnpressed),
      child: Center(
        child: Text(widget.text, style: widget.style,),
      ),
    );
  }
}
