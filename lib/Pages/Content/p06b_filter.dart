import 'package:exye_app/Widgets/custom_divider.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class FilterOverlay extends StatefulWidget {
  FilterOverlay({required this.state, required this.reloadPage, Key? key}) : super(key: key);
  FilterState state;
  Function reloadPage;

  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.topLeft,
            child: Text(app.mResource.strings.cFilterHeader,
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
                    const CustomSizedDivider(45, thickness: 1),
                    GestureDetector(
                      onTap: () {
                        if (widget.state.gender == app.mResource.strings.lFemale) {
                          setState(() {
                            widget.state.gender = "";
                          });
                        }
                        else {
                          setState(() {
                            widget.state.gender = app.mResource.strings.lFemale;
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        decoration: BoxDecoration(
                            color: (widget.state.gender == app.mResource.strings.lFemale) ? app.mResource.colours.black : app.mResource.colours.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: app.mResource.colours.black,
                                width: 1
                            )
                        ),
                        alignment: Alignment.center,
                        child: Text(app.mResource.strings.lFemale,
                            style: (widget.state.gender == app.mResource.strings.lFemale) ? app.mResource.fonts.bWhite12 : app.mResource.fonts.filter12,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.state.gender == app.mResource.strings.lMale) {
                          setState(() {
                            widget.state.gender = "";
                          });
                        }
                        else {
                          setState(() {
                            widget.state.gender = app.mResource.strings.lMale;
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        decoration: BoxDecoration(
                          color: (widget.state.gender == app.mResource.strings.lMale) ? app.mResource.colours.black : app.mResource.colours.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: app.mResource.colours.black,
                                width: 1
                            )
                        ),
                        alignment: Alignment.center,
                        child: Text(app.mResource.strings.lMale,
                            style:  (widget.state.gender == app.mResource.strings.lMale) ? app.mResource.fonts.bWhite12 : app.mResource.fonts.filter12,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.lProduct,
                          style: app.mResource.fonts.filter12),
                    ),
                    const CustomSizedDivider(45, thickness: 1),
                    Container( //의류
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      decoration: BoxDecoration(
                          color: app.mResource.colours.black,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      alignment: Alignment.center,
                      child: Text(app.mResource.strings.cFilterClothing,
                          style: app.mResource.fonts.bWhite12),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(app.mResource.strings.lStyle,
                            style: app.mResource.fonts.filter12),
                      ),
                      const CustomSizedDivider(240, thickness: 1),
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(5),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 11/4,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: app.mResource.strings.cFilter.length,
                          itemBuilder: (context, index) {
                            if (widget.state.category.contains(app.mResource.strings.cFilter[index])) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.state.category.remove(app.mResource.strings.cFilter[index]);
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    height: 40,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: app.mResource.colours.black,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20))
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(app.mResource.strings.cFilter[index],
                                        style: app.mResource.fonts.bWhite12),
                                  ),
                                ),
                              );
                            }
                            return Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.state.category.add(app.mResource.strings.cFilter[index]);
                                  });
                                },
                                child: Container(
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
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              String genderTag = "";
              if (widget.state.gender == app.mResource.strings.lMale) {
                genderTag = "M";
              }
              if (widget.state.gender == app.mResource.strings.lFemale) {
                genderTag = "W";
              }
              await app.mData.filterProducts(gender: genderTag, category: widget.state.category);
              widget.reloadPage();
              await app.mOverlay.panelOff();
              await app.mOverlay.overlayOff();
            },
            child: Container(
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
                  style: app.mResource.fonts.bWhite14
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterState {
  String gender = "";
  List<String> category = [];
}
