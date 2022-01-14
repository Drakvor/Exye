import 'package:exye_app/Pages/Content/p01_signup.dart';
import 'package:exye_app/Pages/Content/p02_login.dart';
import 'package:exye_app/Pages/Content/p03_terms.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final PageController control = PageController();
  LandingPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildPage(context),
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

  Widget buildPage (BuildContext context) {
    return PageView(
      controller: control,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: const Text("Welcome"),
        ),

        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: const Text("Service Overview"),
        ),
      ],
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
}

