import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomKeyboard extends StatefulWidget {
  final int keyCount;
  final int columns;
  final double height;
  final double width;
  final List<String> keys;
  final int maxLength;
  final Function? moreFunction;
  const CustomKeyboard({
    required this.keyCount,
    required this.columns,
    required this.height,
    required this.width,
    required this.keys,
    this.maxLength = 20,
    this.moreFunction,
    Key? key}) : super(key: key);

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {

  void changeState () {
    setState(() {

    });
  }

  @override
  void initState () {
    super.initState();
    app.mApp.input.keyboardStateFunction = changeState;
  }

  @override
  void dispose () {
    app.mApp.input.keyboardStateFunction = () {};
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 200),
        firstChild: buildKeyboard(),
        secondChild: SizedBox(
          height: widget.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(),
              ),
              const CustomFooter(),
            ],
          ),
        ),
        crossFadeState: app.mApp.input.keyboard,
      ),
    );
  }

  Widget buildKeyboard () {
    return SizedBox(
      height: widget.height,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.columns,
          mainAxisExtent: widget.height/(widget.keyCount/widget.columns),
        ),
        itemCount: widget.keyCount,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.keyCount - 1) {
            return CustomBackspace(widget.height/(widget.keyCount/widget.columns), widget.width/widget.columns, widget.maxLength, widget.moreFunction);
          }
          else if (widget.keys[index] == "") {
            return Container();
          }
          return CustomKeys(widget.keys[index], widget.height/(widget.keyCount/widget.columns), widget.width/widget.columns, widget.maxLength, widget.moreFunction);
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
  final Function? moreFunction;
  const CustomKeys(this.s, this.height, this.width, this.maxLength, this.moreFunction, {Key? key}) : super(key: key);

  @override
  _CustomKeysState createState() => _CustomKeysState();
}

class _CustomKeysState extends State<CustomKeys> {
  @override
  Widget build(BuildContext context) {
    return CustomKeyboardTextButton(
      text: widget.s,
      style: app.mResource.fonts.large,
      height: widget.height,
      width: widget.width,
      colourPressed: app.mResource.colours.background2,
      colourUnpressed: app.mResource.colours.background,
      function: () {
        if (app.mApp.input.texts[app.mApp.input.active].length < widget.maxLength - (widget.s.length - 1)) {
          app.mApp.input.add(widget.s);
          if (widget.moreFunction != null) {
            widget.moreFunction!();
          }
        }
      },
    );
  }
}

class CustomBackspace extends StatefulWidget {
  final double height;
  final double width;
  final int maxLength;
  final Function? moreFunction;
  const CustomBackspace(this.height, this.width, this.maxLength, this.moreFunction, {Key? key}) : super(key: key);

  @override
  _CustomBackspaceState createState() => _CustomBackspaceState();
}

class _CustomBackspaceState extends State<CustomBackspace> {
  @override
  Widget build(BuildContext context) {
    return CustomKeyboardBackButton(
      image: app.mResource.images.bPrev,
      height: widget.height,
      width: widget.width,
      colourPressed: app.mResource.colours.background2,
      colourUnpressed: app.mResource.colours.background,
      function: () {
        app.mApp.input.backspace();
        if (widget.moreFunction != null) {
          widget.moreFunction!();
        }
      },
    );
  }
}

