import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_textbox.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  int totalPriceOld = 0;
  int totalPrice = 0;

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
              button1: CustomHybridButton(
              image: app.mResource.images.bCall,
              text: app.mResource.strings.bCall,
              style: app.mResource.fonts.bold,
              height: 40,
              width: 100,
              function: () async {
                await launch("tel:01065809860");
                //app.mPage.prevPage();
              },
              colourPressed: app.mResource.colours.buttonLight,
              colourUnpressed: app.mResource.colours.buttonLight,
            ),
            button2: CustomHybridButton(
              image: app.mResource.images.bShopping,
              text: app.mResource.strings.bConfirmPurchase + " (" + app.mData.chosen!.length.toString() + ")",
              style: app.mResource.fonts.bold,
              height: 40,
              width: 150,
              function: () async {
                app.mData.nextStage();
                await app.mData.createReceipt(totalPrice);
                app.mPage.newPage(const HomePage());
                await app.mApp.buildAlertDialog(context, app.mResource.strings.aPurchased);
              },
              colourUnpressed: app.mResource.colours.buttonOrange,
              colourPressed: app.mResource.colours.buttonOrange,
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
                    Text("총 합계", style: app.mResource.fonts.inactive,),
                    Text(totalPriceOld.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + " 원", style: app.mResource.fonts.inactiveStrike,),
                  ],
                ),
              ),
              Container(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("할인 후 총 합계", style: app.mResource.fonts.bold,),
                    Text(totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + " 원", style: app.mResource.fonts.header,),
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
        height: 140,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 130,
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
                      Container(
                        height: 10,
                      ),
                      Text(app.mResource.strings.lSize + ": " + product.size, style: app.mResource.fonts.thick,),
                      Container(
                        height: 10,
                      ),
                      Text(product.priceOld.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + " 원", style: app.mResource.fonts.inactiveStrike,),
                      Text(product.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},') + " 원", style: app.mResource.fonts.headerLight,),
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
