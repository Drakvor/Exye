import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class ListingsPage extends StatefulWidget {
  const ListingsPage({Key? key}) : super(key: key);

  @override
  _ListingsPageState createState() => _ListingsPageState();
}

class _ListingsPageState extends State<ListingsPage> {
  PageController control = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: control,
      physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      children: [
        Container(),
      ],
    );
  }

  Widget buildPageOne () {
    return Column(
      children: [
        CustomShortHeader(app.mResource.strings.hListing1),
        const ListingsCards(),
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
      controller: control,
      itemCount: 10,
      itemBuilder: (context, index) {
        return buildPage(index);
      },
    );
  }

  Widget buildPage (int index) {
    return Container(
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: app.mResource.colours.cardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: buildContents(app.mData.products![index]),
    );
  }

  Widget buildContents (Product product) {
    return Container();
  }
}
