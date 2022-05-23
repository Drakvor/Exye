import 'package:exye_app/Widgets/custom_divider.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class FilterOverlay extends StatelessWidget {
  const FilterOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.topLeft,
            child: Text(app.mResource.strings.cFilterTitle,
                style: app.mResource.fonts.bold14),
          ),
          Container(
            height: 15,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.lGender,
                          style: app.mResource.fonts.filter12),
                    ),
                    CustomSizedDivider(45, thickness: 1),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.fromLTRB(5, 8, 5, 5),
                      decoration: BoxDecoration(
                          color: app.mResource.colours.black,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.lFemale,
                          style: app.mResource.fonts.filter12),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: app.mResource.colours.black,
                              width: 1
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.lMale,
                          style: app.mResource.fonts.filter12
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.lProducts,
                          style: app.mResource.fonts.filter12),
                    ),
                    CustomSizedDivider(45, thickness: 1),
                    Container( //의류
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.fromLTRB(5, 8, 5, 5),
                      decoration: BoxDecoration(
                          color: app.mResource.colours.black,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.cFilterClothes,
                          style: app.mResource.fonts.filter12),
                    ),
                    Container( //가방
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: app.mResource.colours.black,
                              width: 1
                          )
                      ),
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.cFilterBag,
                          style: app.mResource.fonts.filter12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.lStyle,
                          style: app.mResource.fonts.filter12),
                    ),
                    CustomSizedDivider(240, thickness: 1),
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: app.mResource.strings.cFilter.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          height: 40,
                          width: 110,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: app.mResource.colours.black,
                                  width: 1
                              ),
                              borderRadius: BorderRadius.all(
                                  const Radius.circular(20))
                          ),
                          alignment: Alignment.center,
                          child: Text(app.mResource.strings.cFilter[index],
                              style: app.mResource.fonts.filter12),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 150,
            height: 50,
            decoration: BoxDecoration(
                color: app.mResource.colours.black,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    width: 1
                )
            ),
            child: Text(app.mResource.strings.bConfirmChoices2,
                style: app.mResource.fonts.bold14
            ),
          ),
        ],
      ),
    );
  }
}

class FilterState {
  String gender = "";
  String verse = "";
}
