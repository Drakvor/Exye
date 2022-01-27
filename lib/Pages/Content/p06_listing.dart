import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Pages/Content/p06a_details.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
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
        CustomShortHeader(app.mResource.strings.hListing1),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Text(app.mResource.strings.tListing1),
        ),
        const Expanded(
          child: ListingsCards(),
        ),
        CustomFooter(
          button1: CustomTextButton(
            text: "Call",
            style: app.mResource.fonts.bWhite,
            height: 30,
            width: 50,
            function: () async {
              await launch("tel: 01065809860");
            },
          ),
          button2: CustomTextButton(
            text: "Confirm",
            style: app.mResource.fonts.bWhite,
            height: 30,
            width: 50,
            function: () async {
              setState(() {
                app.mData.chosen = app.mData.products;
              });
              next();
            },
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
              itemCount: app.mData.chosen?.length ?? 5,
              itemBuilder: (context, index) {
                return Container();
              },
            ),
          ),
        ),
        CustomFooter(
          button1: CustomTextButton(
            text: "back",
            style: app.mResource.fonts.bWhite,
            height: 30,
            width: 50,
            function: () async {
              prev();
            },
          ),
          button2: CustomTextButton(
            text: "Confirm",
            style: app.mResource.fonts.bWhite,
            height: 30,
            width: 50,
            function: () async {
              //do something
            },
          ),
        ),
      ],
    );
  }
}

class ListingsCards extends StatefulWidget {
  const ListingsCards({Key? key}) : super(key: key);

  @override
  _ListingsCardsState createState() => _ListingsCardsState();
}

class _ListingsCardsState extends State<ListingsCards> {
  PageController control = PageController(
    viewportFraction: 0.9,
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      allowImplicitScrolling: true,
      controller: control,
      physics: const BouncingScrollPhysics(),
      itemCount: app.mData.products!.length,
      itemBuilder: (context, index) {
        return buildPage(index);
      },
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(product.brand),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(product.name),
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
            height: 75,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(product.priceOld.toString()),
                      Text(product.price.toString()),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  width: 50,
                  height: 50,
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
