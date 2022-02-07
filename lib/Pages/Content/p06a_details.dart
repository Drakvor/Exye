import 'package:exye_app/Data/product.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Product product;
  const DetailsPage(this.product, {Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  PageController control = PageController();

  void listen () {
    setState(() {

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
        Container(
          height: 75,
          width: MediaQuery.of(context).size.width,
          color: app.mResource.colours.white,
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
        Expanded(
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
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: const CustomFooter(),
        ),
      ],
    );
  }
}
