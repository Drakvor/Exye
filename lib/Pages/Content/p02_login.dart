import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_keyboard.dart';
import 'package:exye_app/Widgets/custom_page_view_element.dart';
import 'package:exye_app/Widgets/custom_textfield.dart';
import 'package:exye_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  PageController control = PageController();

  void next () {
    control.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void prev () {
    control.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: control,
      physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      children: [
        CustomPageViewElement(child: buildPage1()),
        CustomPageViewElement(child: buildPage2()),
      ],
    );
  }

  Widget buildPage1 () {
    return Column(
      children: [
        CustomHeader(app.mResource.strings.hLogIn1),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.centerLeft,
                child: Text(app.mResource.strings.pLogIn1),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.center,
                child: CustomTextField(
                  control: app.mApp.input.controls[0],
                  text: app.mResource.strings.iPhoneNumber,
                  node: app.mApp.node,
                  index: 0,
                ),
              ),
              buildNextButton(
                function: () async {
                  if (app.mApp.input.texts[0].length < 11) {
                    app.mApp.buildAlertDialog(context, app.mResource.strings.eInvalidNumber);
                    return;
                  }
                  List emailExists = await FirebaseAuth.instance.fetchSignInMethodsForEmail(app.mApp.input.texts[0] + "@exye.com");
                  if (emailExists.isEmpty) {
                    app.mApp.buildAlertDialog(context, app.mResource.strings.eAccountDoesNotExist);
                    return;
                  }
                  app.mApp.auth.setPhoneNumber(app.mApp.input.texts[0]);
                  app.mApp.input.clearAll();
                  next();
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: CustomKeyboard(
            keyCount: 12,
            columns: 3,
            height: MediaQuery.of(context).size.width - 40,
            width: MediaQuery.of(context).size.width - 40,
            keys: app.mResource.strings.phoneNumberKeys,
            maxLength: 11,
          ),
        ),
      ],
    );
  }

  Widget buildPage2 () {
    return Column(
      children: [
        const Center(
          child: Text("Password"),
        ),
        buildNextButton(
          function: () async {
            app.mApp.auth.setPassword("123456");
            try {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: app.mApp.auth.phoneNumber + "@exye.com",
                password: app.mApp.auth.password,
              );
              if (FirebaseAuth.instance.currentUser != null) {
                app.mPage.newPage(const HomePage());
              }
            }
            catch (e) {
              app.mApp.buildAlertDialog(context, app.mResource.strings.eLogInFail);
              //print(e);
            }
          },
        ),
      ],
    );
  }

  Widget buildNextButton ({required Function function}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      alignment: Alignment.center,
      child: CustomTextButton(
        text: app.mResource.strings.bNext,
        style: app.mResource.fonts.base,
        height: 25,
        width: 200,
        function: () {
          function();
        },
      ),
    );
  }
}
