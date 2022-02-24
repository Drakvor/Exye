import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Pages/Content/p06a_details.dart';
import 'package:exye_app/Pages/Content/p07_checkout.dart';
import 'package:exye_app/Pages/Content/p07a_firsttime.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_textbox.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListingsPage extends StatefulWidget {
  const ListingsPage({Key? key}) : super(key: key);

  @override
  _ListingsPageState createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  PageController control = PageController();


  void next () {
    control.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void prev () {
    control.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void changeState () {
    setState(() {
      //do nothing?
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: control,
      physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        buildPageOne(),
        buildPageTwo()
      ],
    );
  }

  Widget buildPageOne () {
    return Column(
      children: [
        Expanded(
          child: ListingsCards(changeState),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooter(
            button1: CustomHybridButton(
              image: app.mResource.images.bCall,
              text: app.mResource.strings.bAskCall,
              style: app.mResource.fonts.bold,
              height: 40,
              width: 100,
              function: () async {
                await launch("tel: 01065809860");
              },
              colourPressed: app.mResource.colours.buttonLight,
              colourUnpressed: app.mResource.colours.buttonLight,
            ),
            button2: CustomTextButton(
              text: app.mResource.strings.bConfirmChoices + " (" + app.mData.chosen!.length.toString() + ")",
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 100,
              function: () async {
                setState(() {});
                next();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPageTwo () {
    return Column(
      children: [
        CustomShortHeader(app.mResource.strings.hListing2),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: ((app.mData.chosen?.length ?? 0) >= 3) ? (app.mData.chosen?.length ?? 3) : 3,
              itemBuilder: (context, index) {
                if ((app.mData.chosen?.length ?? 0) > index) {
                  return buildProductTile(app.mData.chosen![index]);
                }
                else {
                  return Container();
                }
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooter(
            button1: CustomTextButton(
              text: app.mResource.strings.bPrev,
              style: app.mResource.fonts.bold,
              height: 40,
              width: 80,
              function: () async {
                prev();
              },
              colourPressed: app.mResource.colours.buttonLight,
              colourUnpressed: app.mResource.colours.buttonLight,
            ),
            button2: CustomTextButton(
              text: app.mResource.strings.bConfirm,
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 80,
              function: () async {
                if (app.mData.chosen!.length > 3) {
                  app.mApp.buildAlertDialog(context, app.mResource.strings.eChooseThree);
                  return;
                }
                if (app.mData.user!.address == "") {
                  app.mPage.replacePage(const FirstTimePage());
                }
                else {
                  app.mPage.replacePage(const CheckOutPage());
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductTile (Product product) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: CustomBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 90,
                  width: 90,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image.file(product.files![0]),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.brand, style: app.mResource.fonts.thick,),
                      Text(product.name, style: app.mResource.fonts.paragraph,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(product.priceOld.toString()),
                                Text(product.price.toString()),
                              ],
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Text(app.mResource.strings.lSize + ": " + product.size),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              top: 0,
              width: 14,
              height: 14,
              child: CustomImageButton(
                image: app.mResource.images.bExit,
                height: 14,
                width: 14,
                function: () {
                  setState(() {
                    app.mData.chosen!.remove(product);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListingsCards extends StatefulWidget {
  final Function function;
  const ListingsCards(this.function, {Key? key}) : super(key: key);

  @override
  _ListingsCardsState createState() => _ListingsCardsState();
}

class _ListingsCardsState extends State<ListingsCards> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        CustomShortHeader(app.mResource.strings.hListing1),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: app.mData.products!.length,
            itemBuilder: (context, index) {
              return buildPage(index);
            },
          ),
        ),
      ],
    );
  }

  Widget buildPage (int index) {
    return GestureDetector(
      onTap: () {
        app.mPage.nextPage(DetailsPage(app.mData.products![index]));
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
          color: app.mResource.colours.cardBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: buildContents(app.mData.products![index]),
      ),
    );
  }

  Widget buildContents (Product product) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(product.brand, style: app.mResource.fonts.thick,),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(product.name, style: app.mResource.fonts.paragraph,),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: Image.file(product.files![0]),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 30,
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.priceOld.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + app.mResource.strings.lPrice, style: app.mResource.fonts.inactiveStrike,),
                      Text(product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + app.mResource.strings.lPrice, style: app.mResource.fonts.header),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  width: 30,
                  height: 30,
                  child: CustomImageToggle(
                    image: app.mResource.images.bCheckEmpty,
                    imagePressed: app.mResource.images.bCheckFilled,
                    width: 30,
                    height: 30,
                    function: () {
                      if (app.mData.chosen!.contains(product)) {
                        app.mData.chosen!.remove(product);
                      }
                      else {
                        app.mData.chosen!.add(product);
                      }
                      widget.function();
                    },
                    colourUnpressed: app.mResource.colours.transparent,
                    colourPressed: app.mResource.colours.transparent,
                    initial: app.mData.chosen!.contains(product),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
