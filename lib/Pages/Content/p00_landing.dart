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
          bottom: 50,
          height: 150,
          child: buildButtons(),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: 50,
          child: buildTerms(),
        ),
      ],
    );
  }

  Widget buildPageList (BuildContext context) {
    return PageView.builder(
      controller: control,
      physics: const BouncingScrollPhysics(),
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
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      alignment: Alignment.center,
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextButton(
            text: app.mResource.strings.bSignUp,
            style: app.mResource.fonts.bWhite,
            height: 30,
            width: 100,
            function: () {
              app.mPage.nextPage(const SignUpPage());
            },
          ),
          CustomTextButton(
            text: app.mResource.strings.bLogIn,
            style: app.mResource.fonts.bWhite,
            height: 30,
            width: 100,
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
          Text(app.mResource.strings.tLanding1Title),
          CustomTextBox(
            header: app.mResource.strings.tLanding1H1,
            text: app.mResource.strings.tLanding1P1,
            height: 80,
            width: 250,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding1H2,
            text: app.mResource.strings.tLanding1P2,
            height: 80,
            width: 250,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding1H3,
            text: app.mResource.strings.tLanding1P3,
            height: 80,
            width: 250,
          ),
          CustomTextBox(
            header: app.mResource.strings.tLanding1H4,
            text: app.mResource.strings.tLanding1P4,
            height: 80,
            width: 250,
          ),
          const SizedBox(
            height: 150,
          ),
        ],
      );
    }
    if (index == 1) {
      return Container();
    }
    if (index == 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          const SizedBox(
            height: 150,
          ),
        ],
      );
    }
    else {
      return Container();
    }
  }
}


