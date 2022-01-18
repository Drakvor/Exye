import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class PageOverlay extends StatefulWidget {
  const PageOverlay({Key? key}) : super(key: key);

  @override
  _PageOverlayState createState() => _PageOverlayState();
}

class _PageOverlayState extends State<PageOverlay> with SingleTickerProviderStateMixin {
  Widget overlay = Container();
  int height = 0;
  late AnimationController overlayCont;

  void load (Widget newOverlay, int newHeight) {
    setState(() {
      overlay = newOverlay;
      height = newHeight;
    });
  }

  @override
  void initState () {
    super.initState();
    overlayCont = AnimationController(vsync: this);
    app.mOverlay.load = load;
    app.mOverlay.control = overlayCont;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: buildCoverScreen(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: height + 40,
          child: buildContents(),
        ),
      ],
    );
  }

  Widget buildCoverScreen () {
    return AnimatedBuilder(
      animation: overlayCont,
      builder: (context, child) {
        return Transform(
          transform: Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, (overlayCont.value == 0) ? MediaQuery.of(context).size.height : 0, 0, 1,
          ),
          child: GestureDetector(
            onTap: () {
              //turn off overlay.
              overlayCont.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.linear);
            },
            child: Opacity(
              opacity: overlayCont.value/2,
              child: child,
            ),
          ),
        );
      },
      child: Container(
        color: app.mResource.colours.coverScreen,
      ),
    );
  }

  Widget buildContents () {
    return AnimatedBuilder(
      animation: overlayCont,
      builder: (context, child) {
        return Transform(
          transform: Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, (1-overlayCont.value)*height + 40, 0, 1,
          ),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onVerticalDragUpdate: (DragUpdateDetails details) {
              overlayCont.animateTo((overlayCont.value - details.delta.dy/height >= 0 && overlayCont.value - details.delta.dy/height <= 1) ? overlayCont.value - details.delta.dy/height : overlayCont.value, duration: Duration(seconds: 0), curve: Curves.linear);
            },
            onVerticalDragEnd: (DragEndDetails details) {
              if (overlayCont.value < 0.5) {
                overlayCont.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.linear);
              }
              if (overlayCont.value >= 0.5) {
                overlayCont.animateTo(1, duration: const Duration(milliseconds: 200), curve: Curves.linear);
              }
            },
            onVerticalDragCancel: () {
              overlayCont.animateTo(1, duration: const Duration(milliseconds: 200), curve: Curves.linear);
            },
            child: Container(
              height: height + 20,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: app.mResource.colours.background,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      overlayCont.animateTo(0, duration: const Duration(milliseconds: 250), curve: Curves.linear);
                    },
                    child: SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Container(
                          height: 10,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: child!,
                  ),
                  (height > 20) ? Container(
                    height: 20,
                  ) : Container(),
                ],
              ),
            ),
          ),
        );
      },
      child: overlay,
    );
  }
}
