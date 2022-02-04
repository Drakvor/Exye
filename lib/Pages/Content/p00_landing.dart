import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exye_app/Pages/Content/p01_signup.dart';
import 'package:exye_app/Pages/Content/p02_login.dart';
import 'package:exye_app/Pages/Content/p03_terms.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_textbox.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with SingleTickerProviderStateMixin {
  final PageController control = PageController();
  late AnimationController animator;

  void listen () {
    animator.animateTo(control.position.activity!.velocity, duration: const Duration(seconds: 0), curve: Curves.linear);
  }

  @override
  void initState () {
    super.initState();
    control.addListener(listen);
    animator = AnimationController.unbounded(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPageList(context),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 50,
          child: buildButtons(),
        ),
      ],
    );
  }

  Widget buildPageList (BuildContext context) {
    return PageView.builder(
      controller: control,
      physics: const ClampingScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.vertical,
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            buildBackground(index),
            Center(
              child: buildPage(index),
            ),
          ],
        );
      },
    );
  }

  Widget buildButtons () {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: app.mResource.colours.whiteClear,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextButton(
            text: app.mResource.strings.bCall,
            style: app.mResource.fonts.bWhite,
            height: 35,
            width: 80,
            function: () {
              //app.mPage.prevPage();
            },
          ),
          CustomTextButton(
            text: app.mResource.strings.bSignUp,
            style: app.mResource.fonts.bWhite,
            height: 35,
            width: 80,
            function: () {
              app.mPage.nextPage(const SignUpPage());
            },
          ),
          CustomTextButton(
            text: app.mResource.strings.bLogIn,
            style: app.mResource.fonts.bWhite,
            height: 35,
            width: 80,
            function: () {
              app.mPage.nextPage(const LogInPage());
            },
          ),
        ],
      ),
    );
  }

  Widget buildTerms () {
    return SizedBox(
      height: 50,
      child: Center(
        child: GestureDetector(
          onTap: () {
            app.mPage.nextPage(const TermsPage());
          },
          child: Text(app.mResource.strings.hTerms),
        ),
      ),
    );
  }

  Widget buildBackground (int index) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Image.asset(app.mResource.images.landingBackground[index]),
      ),
    );
  }

  Widget buildPage (int index) {
    return AnimatedBuilder(
      animation: animator,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4(
            1, 0, 0, 0,
            0, 1, 0, 0,
            0, 0, 1, 0,
            0, atan(animator.value / 200) * 40, 0, 1,
          ),
          child: child,
        );
      },
      child: buildPageContent(index),
    );
  }

  Widget buildPageContent (int index) {
    if (index == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Text(app.mResource.strings.tLanding1Title, style: app.mResource.fonts.title,),
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding1H1,
            text: app.mResource.strings.tLanding1P1,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding1H2,
            text: app.mResource.strings.tLanding1P2,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding1H3,
            text: app.mResource.strings.tLanding1P3,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding1H4,
            text: app.mResource.strings.tLanding1P4,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
    }
    if (index == 1) {
      double columnWidth = MediaQuery.of(context).size.width / 2;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(40, 20, 40, 5),
            child: Text(app.mResource.strings.tLanding2Title, style: app.mResource.fonts.title,),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 20,
                ),
                SizedBox(
                  width: columnWidth - 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextBox(
                        header: app.mResource.strings.tLanding2H1,
                        text: app.mResource.strings.tLanding2P1,
                        height: 80,
                        width: columnWidth - 40,
                      ),
                      Container(
                        height: 10,
                      ),
                      CustomTextBox(
                        header: app.mResource.strings.tLanding2H3,
                        text: app.mResource.strings.tLanding2P3,
                        height: 80,
                        width: columnWidth - 40,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: columnWidth - 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextBox(
                        header: app.mResource.strings.tLanding2H2,
                        text: app.mResource.strings.tLanding2P2,
                        height: 80,
                        width: columnWidth - 40,
                      ),
                      Container(
                        height: 10,
                      ),
                      CustomTextBox(
                        header: app.mResource.strings.tLanding2H4,
                        text: app.mResource.strings.tLanding2P4,
                        height: 80,
                        width: columnWidth - 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            height: 50,
          ),
        ],
      );
    }
    if (index == 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Text(app.mResource.strings.tLanding3Title, style: app.mResource.fonts.title,),
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding3H1,
            text: app.mResource.strings.tLanding3P1,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding3H2,
            text: app.mResource.strings.tLanding3P2,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding3H3,
            text: app.mResource.strings.tLanding3P3,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding3H4,
            text: app.mResource.strings.tLanding3P4,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
    }
    if (index == 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(40, 10, 40, 5),
            child: Text(app.mResource.strings.tLanding4Title, style: app.mResource.fonts.title,),
          ),
          CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: const Color(0xff666666),
              );
            },
            options: CarouselOptions(
              viewportFraction: 0.5,
              initialPage: 0,
              enableInfiniteScroll: true,
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding4H1,
            text: app.mResource.strings.tLanding4P1,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding4H2,
            text: app.mResource.strings.tLanding4P2,
            height: 80,
            width: MediaQuery.of(context).size.width - 80,
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
    }
    else {
      return Container();
    }
  }
}


