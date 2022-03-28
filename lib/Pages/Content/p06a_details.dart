import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Pages/Content/p06_listing.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Product product;
  final Function function;
  const DetailsPage(this.product, {required this.function, Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  PageController control = PageController();
  int page = 0;

  void listen () {
    setState(() {
      page = control.page!.round();
    });
  }

  @override
  void initState () {
    super.initState();
    control.addListener(listen);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: PageView.builder(
                  controller: control,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.product.files!.length + 2,
                  itemBuilder: (context, index) {
                    if (index < widget.product.files!.length) {
                      return Scaffold(
                        backgroundColor: app.mResource.colours.white,
                        body: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Image.file(widget.product.files![index]),
                          ),
                        ),
                      );
                    }
                    if (index == widget.product.files!.length) {
                      return Scaffold(
                        backgroundColor: app.mResource.colours.white,
                        body: Container(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                            itemCount: widget.product.details.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(widget.product.details[index], style: app.mResource.fonts.base,),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    else {
                      return Scaffold(
                        backgroundColor: app.mResource.colours.white,
                        body: Container(
                          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                            itemCount: widget.product.more.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.centerLeft,
                                child: Text(widget.product.more[index]),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 75,
                child: Container(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  color: app.mResource.colours.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        child: Text(app.mResource.strings.tLanding1Title, style: app.mResource.fonts.header,),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(widget.product.images[(control.positions.isNotEmpty) ? (control.page!.round()) : 0], style: app.mResource.fonts.header,),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 50,
                child: CustomFooterToHome(
                  button1: CustomTextButton(
                    text: app.mResource.strings.bPrev,
                    style: app.mResource.fonts.bold,
                    height: 40,
                    width: 80,
                    function: () async {
                      app.mPage.prevPage();
                    },
                    colourPressed: app.mResource.colours.buttonLight,
                    colourUnpressed: app.mResource.colours.buttonLight,
                  ),
                  button2: (!(app.mData.user!.cart!.items!.contains(widget.product))) ? CustomImageButton(
                    image: app.mResource.images.bCheckEmpty,
                    width: 40,
                    height: 40,
                    function: () async {
                      if (app.mData.user!.cart!.items!.length > 2) {
                        app.mApp.buildAlertDialog(context, app.mResource.strings.aChooseThree, app.mResource.strings.eChooseThree);
                        return;
                      }
                      app.mOverlay.loadOverlay(SizeButtons(widget.product, function: () {widget.function(); setState(() {});},), 200);
                      await app.mOverlay.panelOn();
                      widget.function();
                    },
                    colourUnpressed: app.mResource.colours.transparent,
                    colourPressed: app.mResource.colours.transparent,
                  ) : CustomTextButton(
                    text: (widget.product.selected == -1) ? "" : widget.product.sizes[widget.product.selected],
                    style: app.mResource.fonts.bWhite,
                    width: 40,
                    height: 40,
                    function: () async {
                      app.mOverlay.loadOverlay(SizeButtons(widget.product, function: () {widget.function(); setState(() {});},), 200);
                      await app.mOverlay.panelOn();
                      widget.function();
                    },
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 20,
                width: 10,
                height: 100,
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: getScrollIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> getScrollIndicator () {
    List<Widget> bars = [];
    for (int i = 0; i < widget.product.files!.length + 2; i++) {
      bars.add(
        Container(
          width: (i == page) ? 3 : 1,
          height: (i == page) ? (90 / (widget.product.files!.length + 4))*3 : (90 / (widget.product.files!.length + 4)),
          decoration: BoxDecoration(
            color: app.mResource.colours.black,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    }
    return bars;
  }
}
