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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(app.mResource.strings.tLanding1Title),
        Text("Placeholder"),
        Expanded(
          child: PageView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
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
                          alignment: Alignment.center,
                          child: Text(widget.product.details[index]),
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
                          alignment: Alignment.center,
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
        const CustomFooter(),
      ],
    );
  }
}
