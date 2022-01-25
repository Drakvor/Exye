import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_keyboard.dart';
import 'package:exye_app/Widgets/custom_textfield.dart';
import 'package:exye_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
        buildPage1(),
        buildPage2(),
        buildPage3(),
      ],
    );
  }

  Widget buildPage1 () {
    return Column(
      children: [
        CustomHeader(app.mResource.strings.hSignUp1),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.centerLeft,
                child: Text(app.mResource.strings.pSignUp1),
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
                  CollectionReference invitationsRef = FirebaseFirestore.instance.collection('invitations');
                  List emailExists = await FirebaseAuth.instance.fetchSignInMethodsForEmail(app.mApp.input.texts[0] + "@exye.com");
                  if (emailExists.isNotEmpty) {
                    app.mApp.buildAlertDialog(context, app.mResource.strings.eAccountExists);
                    return;
                  }
                  QuerySnapshot snapshot = await invitationsRef.where('target', isEqualTo: app.mApp.input.texts[0]).get();
                  if (snapshot.docs.isEmpty) {
                    app.mApp.buildAlertDialog(context, app.mResource.strings.eNoInvitation);
                    return;
                  }
                  app.mApp.auth.setPhoneNumber(app.mApp.input.texts[0]);
                  app.mApp.input.clearAll();
                  next();
                  print('+82 ' + app.mApp.auth.phoneNumber);
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+82 ' + app.mApp.auth.phoneNumber,
                    verificationCompleted: (PhoneAuthCredential cred) {
                      app.mApp.input.setText(cred.smsCode ?? "000000", index: 1);
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      app.mApp.buildAlertDialog(context, app.mResource.strings.eVerifyFailed);
                      app.mPage.prevPage();
                      return;
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      app.mApp.auth.setVerificationId(verificationId);
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
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
        CustomHeader(app.mResource.strings.hSignUp2),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.centerLeft,
                child: Text(app.mResource.strings.pSignUp2),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.center,
                child: CustomTextField(
                  control: app.mApp.input.controls[1],
                  text: app.mResource.strings.iPhoneNumber,
                  node: app.mApp.node,
                  index: 1,
                ),
              ),
              buildNextButton(
                function: () async {
                  if (app.mApp.input.texts[1].length < 6) {
                    app.mApp.buildAlertDialog(context, app.mResource.strings.eShortCode);
                    return;
                  }
                  app.mApp.auth.setCodeSMS(app.mApp.input.texts[1]);
                  await FirebaseAuth.instance.signInWithCredential(
                    PhoneAuthProvider.credential(
                      verificationId: app.mApp.auth.verificationId,
                      smsCode: app.mApp.auth.codeSMS,
                    ),
                  );
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
            keys: app.mResource.strings.numberKeys,
            maxLength: 11,
          ),
        ),
      ],
    );
  }

  Widget buildPage3 () {
    return Column(
      children: [
        CustomHeader(app.mResource.strings.hSignUp3),
        Expanded(
          child: Container(),
        ),
        buildNextButton(
          function: () {
            //move on
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
