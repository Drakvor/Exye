import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_textbox.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class CustomBrandsSurvey extends StatefulWidget {
  final CustomBrandsState state;
  const CustomBrandsSurvey(this.state, {Key? key}) : super(key: key);

  @override
  _CustomBrandsSurveyState createState() => _CustomBrandsSurveyState();
}

class _CustomBrandsSurveyState extends State<CustomBrandsSurvey> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: app.mResource.strings.brandsList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: CustomBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Text(app.mResource.strings.brandsList[index], style: app.mResource.fonts.bold,),
                  ),
                  CustomImageToggle(
                    key: UniqueKey(),
                    image: app.mResource.images.bCheckEmpty,
                    imagePressed: app.mResource.images.bCheckFilled,
                    height: 40,
                    width: 40,
                    function: () {
                      widget.state.choices[index] = !widget.state.choices[index];
                      setState(() {});
                    },
                    initial: widget.state.choices[index],
                    colourUnpressed: app.mResource.colours.transparent,
                    colourPressed: app.mResource.colours.transparent,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomBrandsState {
  List<bool> choices = [false];
}
