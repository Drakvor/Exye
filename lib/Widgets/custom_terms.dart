import 'package:exye_app/Pages/Content/p01a_terms_details.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomTerms extends StatefulWidget {
  final CustomTermsState state;
  const CustomTerms(this.state, {Key? key}) : super(key: key);

  @override
  _CustomTermsState createState() => _CustomTermsState();
}

class _CustomTermsState extends State<CustomTerms> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                height: 30,
                width: 30,
                child: CustomTermsToggle(
                  height: 30,
                  width: 30,
                  state: widget.state,
                  function: (bool pressed) {
                    setState(() {
                      widget.state.setAll(pressed);
                    });
                  },
                  index: 0,
                ),
              ),
              Expanded(
                child: Text(app.mResource.strings.tTermsAll, style: app.mResource.fonts.header),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                height: 15,
                width: 15,
                child: CustomTermsToggle(
                  height: 15,
                  width: 15,
                  state: widget.state,
                  function: (bool pressed) {
                    // do nothing
                  },
                  index: 1,
                ),
              ),
              Expanded(
                child: Text(app.mResource.strings.tTerms1, style: app.mResource.fonts.base),
              ),
              SizedBox(
                height: 15,
                width: 15,
                child: CustomImageButton(
                  image: app.mResource.images.bAdd,
                  height: 15,
                  width: 15,
                  function: () {
                    app.mPage.nextPage(const TermsDetailsPage(0));
                  },
                  colourPressed: app.mResource.colours.buttonLight,
                  colourUnpressed: app.mResource.colours.buttonLight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                height: 15,
                width: 15,
                child: CustomTermsToggle(
                  height: 15,
                  width: 15,
                  state: widget.state,
                  function: (bool pressed) {
                    // do nothing
                  },
                  index: 2,
                ),
              ),
              Expanded(
                child: Text(app.mResource.strings.tTerms2, style: app.mResource.fonts.base),
              ),
              SizedBox(
                height: 15,
                width: 15,
                child: CustomImageButton(
                  image: app.mResource.images.bAdd,
                  height: 15,
                  width: 15,
                  function: () {
                    app.mPage.nextPage(const TermsDetailsPage(1));
                  },
                  colourPressed: app.mResource.colours.buttonLight,
                  colourUnpressed: app.mResource.colours.buttonLight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                height: 15,
                width: 15,
                child: CustomTermsToggle(
                  height: 15,
                  width: 15,
                  state: widget.state,
                  function: (bool pressed) {
                    // do nothing
                  },
                  index: 3,
                ),
              ),
              Expanded(
                child: Text(app.mResource.strings.tTerms3, style: app.mResource.fonts.base),
              ),
              SizedBox(
                height: 15,
                width: 15,
                child: CustomImageButton(
                  image: app.mResource.images.bAdd,
                  height: 15,
                  width: 15,
                  function: () {
                    app.mPage.nextPage(const TermsDetailsPage(2));
                  },
                  colourPressed: app.mResource.colours.buttonLight,
                  colourUnpressed: app.mResource.colours.buttonLight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                height: 15,
                width: 15,
                child: CustomTermsToggle(
                  height: 15,
                  width: 15,
                  state: widget.state,
                  function: (bool pressed) {
                    // do nothing
                  },
                  index: 3,
                ),
              ),
              Expanded(
                child: Text(app.mResource.strings.tTerms4, style: app.mResource.fonts.base),
              ),
              SizedBox(
                height: 15,
                width: 15,
                child: CustomImageButton(
                  image: app.mResource.images.bAdd,
                  height: 15,
                  width: 15,
                  function: () {
                    app.mPage.nextPage(const TermsDetailsPage(2));
                  },
                  colourPressed: app.mResource.colours.buttonLight,
                  colourUnpressed: app.mResource.colours.buttonLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTermsState {
  List<bool> agreed = [false, false, false, false, false];

  void toggle (int index) {
    agreed[index] = !agreed[index];
  }

  void setAll (bool x) {
    for (int i = 0; i < agreed.length; i++) {
      agreed[i] = x;
    }
  }
}

class CustomTermsToggle extends StatefulWidget {
  final double height;
  final double width;
  final CustomTermsState state;
  final int index;
  final Function function;
  const CustomTermsToggle({required this.height, required this.width, required this.state, required this.index, required this.function, Key? key}) : super(key: key);

  @override
  _CustomTermsToggleState createState() => _CustomTermsToggleState();
}

class _CustomTermsToggleState extends State<CustomTermsToggle> {
  _CustomTermsToggleState();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.state.toggle(widget.index);
        });
        widget.function(widget.state.agreed[widget.index]);
      },
      child: Container(
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: (widget.state.agreed[widget.index]) ? (Image.asset(app.mResource.images.bCheckFilled, width: widget.width, height: widget.height,)) : (Image.asset(app.mResource.images.bCheckEmpty, width: widget.width, height: widget.height,)),
        ),
      ),
    );
  }
}
