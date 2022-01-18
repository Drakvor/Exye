import 'dart:math';

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
            buildBackground(),
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
            style: app.mResource.fonts.base,
            height: 30,
            width: 100,
            function: () {
              app.mPage.nextPage(const SignUpPage());
            },
          ),
          CustomTextButton(
            text: app.mResource.strings.bLogIn,
            style: app.mResource.fonts.base,
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

  Widget buildBackground () {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Image.asset(app.mResource.images.backgroundLanding),
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
      child: buildPage1(),
    );
  }

  Widget buildPage1 () {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        CustomTextBox(
          header: "Welcome Haha",
          text: "We are victorious!",
          height: 80,
          width: 200,
        ),
        CustomTextBox(
          header: "Goodbye~",
          text: "We are the champions!",
          height: 80,
          width: 200,
        ),
      ],
    );
  }
}


