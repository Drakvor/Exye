import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_textbox.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  double totalPriceOld = 0;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return buildPage();
  }

  Widget buildPage () {
    return Column(
      children: [
        CustomShortHeader(app.mResource.strings.hConfirm),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            width: MediaQuery.of(context).size.width,
            child: buildList(),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooter(
            button2: CustomTextButton(
              text: app.mResource.strings.bConfirmPurchase + " (" + app.mData.chosen!.length.toString() + ")",
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 100,
              function: () async {
                app.mData.nextStage();
                await app.mData.createReceipt(totalPrice);
                app.mPage.newPage(const HomePage());
                await app.mApp.buildAlertDialog(context, "Purchased");
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildList () {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index < app.mData.products!.length) {
          return buildItem(app.mData.products![index]);
        }
        else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("총 합계"),
                    Text(totalPriceOld.toString()),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("할인 후 총 합계"),
                    Text(totalPrice.toString()),
                  ],
                ),
              ),
            ],
          );
        }
      },
      itemCount: app.mData.user!.order!.items.length + 1,
    );
  }

  Widget buildItem (Product product) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: CustomBox(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 110,
                  width: 90,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image.file(product.files![0]),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.brand, style: app.mResource.fonts.thick,),
                      Text(product.name, style: app.mResource.fonts.paragraph,),
                      Text(app.mResource.strings.lSize + ": " + product.size),
                      Text(product.priceOld.toString()),
                      Text(product.price.toString()),
                    ],
                  ),
                ),
              ],
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
                    totalPriceOld -= product.priceOld;
                    totalPrice -= product.price;
                  }
                  else {
                    app.mData.chosen!.add(product);
                    totalPriceOld += product.priceOld;
                    totalPrice += product.price;
                  }
                  setState(() {
                    //do nothing
                  });
                },
                colourUnpressed: app.mResource.colours.transparent,
                colourPressed: app.mResource.colours.transparent,
                initial: app.mData.chosen!.contains(product),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
