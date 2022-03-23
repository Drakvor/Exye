import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exye_app/Pages/Content/p00_landing.dart';
import 'package:exye_app/Pages/Content/p01b_survey.dart';
import 'package:exye_app/Pages/Content/p01c_brands.dart';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_footer.dart';
import 'package:exye_app/Widgets/custom_header.dart';
import 'package:exye_app/Widgets/custom_keyboard.dart';
import 'package:exye_app/Widgets/custom_page_view_element.dart';
import 'package:exye_app/Widgets/custom_terms.dart';
import 'package:exye_app/Widgets/custom_textbox.dart';
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
  PageController control = PageController(
    initialPage: 0,
  );
  CustomTermsState termsState = CustomTermsState();
  CustomSurveyState surveyState = CustomSurveyState();
  CustomBrandsState brandsState = CustomBrandsState();

  void next () {
    control.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void prev () {
    control.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void changeState () {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: control,
      physics: const NeverScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      scrollDirection: Axis.horizontal,
      children: [
        CustomPageViewElement(child: buildPage1()),
        CustomPageViewElementPassword(child: buildPage2()),
        CustomPageViewElement(child: buildPage3()),
        CustomPageViewElementPassword(child: buildPage4()),
        CustomPageViewElementPassword(child: buildPage4b()),
        CustomPageViewElement(child: buildPage5()),
        CustomPageViewElement(child: buildPage5a()),
        CustomPageViewElement(child: buildPage5b()),
        CustomPageViewElement(child: buildPage6()),
      ],
    );
  }

  Widget buildPage1 () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp1),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          alignment: Alignment.centerLeft,
          child: Text(app.mResource.strings.pSignUp1, style: app.mResource.fonts.headerLight,),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0,),
          alignment: Alignment.centerLeft,
          child: Text(app.mResource.strings.pSignUp1a, style: app.mResource.fonts.base,),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                alignment: Alignment.center,
                child: CustomTextField(
                  control: app.mApp.input.textControl,
                  text: app.mResource.strings.iPhoneNumber,
                  node: app.mApp.node,
                  index: 0,
                  maxLength: 13,
                  fullFunction: () async {
                    if (app.mApp.input.texts[0].length < 13) {
                      app.mApp.buildAlertDialog(context, app.mResource.strings.aInvalidNumber, app.mResource.strings.eInvalidNumber);
                      return;
                    }
                    await app.mOverlay.overlayOn();
                    CollectionReference invitationsRef = FirebaseFirestore.instance.collection('invitations');
                    List emailExists = await FirebaseAuth.instance.fetchSignInMethodsForEmail(app.mApp.input.textControl.text.replaceAll(RegExp(r'[^0-9]'), '') + "@exye.com");
                    if (emailExists.isNotEmpty) {
                      app.mApp.buildAlertDialog(context, app.mResource.strings.aAccountExists, app.mResource.strings.eAccountExists);
                      await app.mOverlay.overlayOff();
                      return;
                    }
                    QuerySnapshot snapshot = await invitationsRef.where('target', isEqualTo: app.mApp.input.textControl.text.replaceAll(RegExp(r'[^0-9]'), '')).get();
                    if (snapshot.docs.isEmpty) {
                      app.mApp.buildAlertDialog(context, app.mResource.strings.aNoInvitation, app.mResource.strings.eNoInvitation);
                      await app.mOverlay.overlayOff();
                      return;
                    }
                    app.mApp.auth.setPhoneNumber(app.mApp.input.textControl.text.replaceAll(RegExp(r'[^0-9]'), ''));
                    app.mApp.input.clearAll();
                    app.mApp.input.setActive(1);
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '+82 ' + app.mApp.auth.phoneNumber,
                      verificationCompleted: (PhoneAuthCredential cred) async {
                        app.mApp.input.setText(cred.smsCode ?? "000000", index: 1);
                        await app.mOverlay.overlayOff();
                      },
                      verificationFailed: (FirebaseAuthException e) async {
                        await app.mApp.buildAlertDialog(context, app.mResource.strings.aVerifyFailed, app.mResource.strings.eVerifyFailed);
                        await app.mOverlay.overlayOff();
                        app.mPage.prevPage();
                        return;
                      },
                      codeSent: (String verificationId, int? resendToken) async {
                        app.mApp.auth.setVerificationId(verificationId);
                        await app.mOverlay.overlayOff();
                        next();
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    await app.mOverlay.overlayOff();
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: CustomFooter(),
        ),
      ],
    );
  }

  Widget buildPage2 () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp2),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                alignment: Alignment.center,
                child: CustomPasswordInput(
                  1,
                  key: UniqueKey(),
                ),
              ),
              buildNextButton(
                function: () async {
                  if (app.mApp.input.texts[1].length < 6) {
                    app.mApp.buildAlertDialog(context, app.mResource.strings.aShortCode, app.mResource.strings.eShortCode);
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
                  await FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: CustomKeyboard(
            keyCount: 12,
            columns: 3,
            height: (MediaQuery.of(context).size.width - 40) * 2/3,
            width: MediaQuery.of(context).size.width - 40,
            keys: app.mResource.strings.numberKeys,
            maxLength: 11,
            moreFunction: () {
              changeState();
            },
          ),
        ),
      ],
    );
  }

  Widget buildPage3 () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp3),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: CustomBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: CustomTerms(termsState),
            ),
          ),
        ),
        buildNextButton(
          function: () async {
            if (termsState.agreed[1] && termsState.agreed[2] && termsState.agreed[3] && termsState.agreed[4]) {
              app.mApp.input.setActive(1);
              app.mApp.input.clearAll();
              app.mApp.input.setHide();
              next();
            }
            else {
              await app.mApp.buildAlertDialog(context, app.mResource.strings.aTermsAgree, app.mResource.strings.eTermsAgree);
            }
          },
        ),
      ],
    );
  }

  Widget buildPage4 () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp4),
        Expanded(
          child: CustomPasswordInput(1, key: UniqueKey(),),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: CustomTextButton(
            text: app.mApp.input.show ? app.mResource.strings.bHide : app.mResource.strings.bShow,
            style: app.mResource.fonts.bold,
            width: 180,
            height: 40,
            function: () {
              setState(() {
                app.mApp.input.toggleShow();
              });
            },
            colourPressed: app.mResource.colours.buttonLight,
            colourUnpressed: app.mResource.colours.buttonLight,
          ),
        ),
        buildNextButton(
          function: () {
            if (app.mApp.input.texts[1].length < 6) {
              app.mApp.buildAlertDialog(context, app.mResource.strings.aShortPassword, app.mResource.strings.eShortPassword);
              return;
            }
            app.mApp.input.setHide();
            app.mApp.input.setActive(2);
            next();
          },
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: CustomKeyboard(
            keyCount: 12,
            columns: 3,
            height: (MediaQuery.of(context).size.width - 40) * 2/3,
            width: MediaQuery.of(context).size.width - 40,
            keys: app.mResource.strings.numberKeys,
            maxLength: 6,
            moreFunction: () {
              changeState();
            },
          ),
        ),
      ],
    );
  }

  Widget buildPage4b () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp4b),
        Expanded(
          child: CustomPasswordInput(2, key: UniqueKey(),),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: CustomTextButton(
            text: app.mApp.input.show ? app.mResource.strings.bHide : app.mResource.strings.bShow,
            style: app.mResource.fonts.bold,
            width: 180,
            height: 40,
            function: () {
              setState(() {
                app.mApp.input.toggleShow();
              });
            },
            colourPressed: app.mResource.colours.buttonLight,
            colourUnpressed: app.mResource.colours.buttonLight,
          ),
        ),
        buildNextButton(
          function: () async {
            if (app.mApp.input.texts[2].length < 6) {
              app.mApp.buildAlertDialog(context, app.mResource.strings.aShortPassword, app.mResource.strings.eShortPassword);
              return;
            }
            if (app.mApp.input.texts[1] == app.mApp.input.texts[2]) {
              app.mApp.auth.password = app.mApp.input.texts[1];

              next();
              app.mApp.input.clearAll();
              app.mApp.input.setActive(-1);
              app.mApp.input.setShow();
            }
            else {
              app.mApp.input.clearAll();
              app.mApp.input.setActive(1);
              prev();
              await app.mApp.buildAlertDialog(context, app.mResource.strings.aPasswordMatch, app.mResource.strings.ePasswordMatch);
            }
          },
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: CustomKeyboard(
            keyCount: 12,
            columns: 3,
            height: (MediaQuery.of(context).size.width - 40) * 2/3,
            width: MediaQuery.of(context).size.width - 40,
            keys: app.mResource.strings.numberKeys,
            maxLength: 6,
            moreFunction: () {
              changeState();
            },
          ),
        ),
      ],
    );
  }

  Widget buildPage5 () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp5),
        Expanded(
          child: CustomSurvey(surveyState),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooterNoExit(
            button2: CustomTextButton(
              text: app.mResource.strings.bNext,
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 80,
              function: () async {
                surveyState.name = app.mApp.input.controls[0].text;

                app.mApp.input.setActive(-1);
                app.mApp.input.clearAll();
                next();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPage5a () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp6),
        Expanded(
          child: CustomAddressSurvey(surveyState),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooterNoExit(
            button1: CustomTextButton(
              text: app.mResource.strings.bPrev,
              style: app.mResource.fonts.bold,
              height: 40,
              width: 80,
              function: () {
                app.mApp.input.setText(surveyState.name, index: 0);
                setState(() {
                  prev();
                });
              },
              colourUnpressed: app.mResource.colours.buttonLight,
              colourPressed: app.mResource.colours.buttonLight,
            ),
            button2: CustomTextButton(
              text: app.mResource.strings.bNext,
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 80,
              function: () async {
                surveyState.address = app.mApp.input.texts[1];
                surveyState.addressDetails = app.mApp.input.controls[2].text;

                app.mApp.input.setActive(-1);
                app.mApp.input.clearAll();
                next();
              },
            ),
          ),
        ),

      ],
    );
  }

  Widget buildPage5b () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp5),
        Expanded(
          child: CustomBodySurvey(surveyState),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooterNoExit(
            button1: CustomTextButton(
              text: app.mResource.strings.bPrev,
              style: app.mResource.fonts.bold,
              height: 40,
              width: 80,
              function: () {
                app.mApp.input.setText(surveyState.address, index: 1);
                app.mApp.input.setText(surveyState.addressDetails, index: 2);
                setState(() {
                  prev();
                });
              },
              colourUnpressed: app.mResource.colours.buttonLight,
              colourPressed: app.mResource.colours.buttonLight,
            ),
            button2: CustomTextButton(
              text: app.mResource.strings.bNext,
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 80,
              function: () async {
                surveyState.height = int.parse(app.mApp.input.texts[1]);
                surveyState.weight = int.parse(app.mApp.input.texts[2]);

                app.mApp.input.setActive(-1);
                app.mApp.input.clearAll();
                next();
              },
            ),
          ),
        ),

      ],
    );
  }

  Widget buildPage6 () {
    return Column(
      children: [
        CustomHeaderInactive(app.mResource.strings.hSignUp7),
        Expanded(
          child: CustomBrandsSurvey(brandsState),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CustomFooterNoExit(
            button1: CustomTextButton(
              text: app.mResource.strings.bPrev,
              style: app.mResource.fonts.bold,
              height: 40,
              width: 80,
              function: () {
                app.mApp.input.setText(surveyState.height.toString(), index: 1);
                app.mApp.input.setText(surveyState.weight.toString(), index: 2);
                setState(() {
                  prev();
                });
              },
              colourUnpressed: app.mResource.colours.buttonLight,
              colourPressed: app.mResource.colours.buttonLight,
            ),
            button2: CustomTextButton(
              text: app.mResource.strings.bNext,
              style: app.mResource.fonts.bWhite,
              height: 40,
              width: 80,
              function: () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: app.mApp.auth.phoneNumber + "@exye.com",
                    password: app.mApp.auth.password,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    await app.mApp.buildAlertDialog(context, app.mResource.strings.aWeakPassword, app.mResource.strings.eWeakPassword);
                  }
                  else if (e.code == 'email-already-in-use') {
                    await app.mApp.buildAlertDialog(context, app.mResource.strings.aIAccountExists, app.mResource.strings.eAccountExists);
                  }
                } catch (e) {
                  await app.mApp.buildAlertDialog(context, app.mResource.strings.aGenericError, e.toString());
                }

                if (FirebaseAuth.instance.currentUser != null) {
                  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

                  await usersRef.add({
                    "name": surveyState.name,
                    "uid": FirebaseAuth.instance.currentUser!.uid,
                    "phoneNumber": app.mApp.auth.phoneNumber,
                    "address": surveyState.address,
                    "addressDetails": surveyState.addressDetails,
                    "age": app.mResource.strings.ages[surveyState.age],
                    "gender": surveyState.gender,
                    "height": surveyState.height,
                    "weight": surveyState.weight,
                    "joinDate": (DateTime.now().year * 10000 + DateTime.now().month * 100 + DateTime.now().day).toString(),
                    "userName": "",
                    "email": "",
                    "invitations": 3,
                    "stage": 0,
                    "cart": [],
                    "cartSizes": [],
                  });

                  app.mApp.input.clearAll();
                  app.mApp.input.setActive(-1);
                  app.mApp.input.setShow();
                  app.mPage.newPage(const HomePage());
                }
                else {
                  app.mApp.input.clearAll();
                  app.mApp.input.setActive(-1);
                  app.mApp.input.setShow();
                  app.mPage.newPage(const LandingPage());
                  await app.mApp.buildAlertDialog(context, app.mResource.strings.aSignUpFail, app.mResource.strings.eSignUpFail);
                }
              },
            ),
          ),
        ),

      ],
    );
  }

  Widget buildNextButton ({required Function function, String? text}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      alignment: Alignment.center,
      child: CustomTextButton(
        text: text ?? app.mResource.strings.bNext,
        style: app.mResource.fonts.bWhite,
        height: 40,
        width: 180,
        function: () {
          function();
        },
      ),
    );
  }
}
