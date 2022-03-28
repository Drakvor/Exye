import 'package:exye_app/Widgets/custom_button.dart';
import 'package:exye_app/Widgets/custom_controller.dart';
import 'package:exye_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppManager {
  FocusNode node = FocusNode();
  FocusNode node2 = FocusNode();
  AppTextManager input = AppTextManager();
  AppAuthManager auth = AppAuthManager();

  Future<void> buildAlertDialog (BuildContext context, String header, String text) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Column(
            children: [
              Text(header, style: app.mResource.fonts.bold,),
              Container(
                height: 10,
              ),
              Text(text, style: app.mResource.fonts.base,)
            ],
          ),
        );
      },
    );
  }

  Future<void> buildErrorDialog (BuildContext context, String text) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(text),
        );
      },
    );
  }

  Future<void> buildActionDialog (BuildContext context, String header, String text, {Function? action, String? label1, String? label2}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Column(
            children: [
              Text(header, style: app.mResource.fonts.bold,),
              Container(
                height: 10,
              ),
              Text(text, style: app.mResource.fonts.base,),
              Container(
                height: 10,
              ),
              (action != null) ? Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                alignment: Alignment.center,
                child: CustomTextButton(
                  text: label1 ?? app.mResource.strings.bYes,
                  style: app.mResource.fonts.bold,
                  height: 30,
                  width: 80,
                  function: () {
                    action();
                    Navigator.pop(context);
                  },
                  colourPressed: app.mResource.colours.buttonLight,
                  colourUnpressed: app.mResource.colours.buttonLight,
                ),
              ) : Container(),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                alignment: Alignment.center,
                child: CustomTextButton(
                  text: label2 ?? app.mResource.strings.bNo,
                  style: app.mResource.fonts.bWhite,
                  height: 30,
                  width: 80,
                  function: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> buildActionDialogOld (BuildContext context, String text, {Function? action1, Function? action2}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(text),
          actions: [
            (action1 != null) ? Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.center,
              child: CustomTextButton(
                text: app.mResource.strings.bYes,
                style: app.mResource.fonts.bold,
                height: 30,
                width: 80,
                function: () {
                  action1();
                  Navigator.pop(context);
                },
                colourPressed: app.mResource.colours.buttonLight,
                colourUnpressed: app.mResource.colours.buttonLight,
              ),
            ) : Container(),
            (action2 != null) ? Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.center,
              child: CustomTextButton(
                text: app.mResource.strings.bYes,
                style: app.mResource.fonts.bold,
                height: 30,
                width: 80,
                function: () {
                  action2();
                  Navigator.pop(context);
                },
                colourPressed: app.mResource.colours.buttonLight,
                colourUnpressed: app.mResource.colours.buttonLight,
              ),
            ) : Container(),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              alignment: Alignment.center,
              child: CustomTextButton(
                text: app.mResource.strings.bNo,
                style: app.mResource.fonts.bWhite,
                height: 30,
                width: 80,
                function: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class AppAuthManager {
  String verificationId = "";
  String codeSMS = "";
  String phoneNumber = "";
  String password = "";
  int resendToken = 0;

  void setResendToken (int input) {
    resendToken = input;
  }

  void setVerificationId (String input) {
    verificationId = input;
  }

  void setCodeSMS (String input) {
    codeSMS = input;
  }

  void setPhoneNumber (String input) {
    phoneNumber = input;
  }

  void setPassword (String input) {
    password = input;
  }
}

class AppTextManager {
  List<String> texts = [];
  List<TextEditingController> controls = [];
  MaskedTextController textControl = MaskedTextController(mask: "000-0000-0000");
  int count = 0;
  int active = -1;
  bool show = true;
  CrossFadeState keyboard = CrossFadeState.showSecond;
  late Function keyboardStateFunction = f;

  void f () {

  }

  void initialise () {
    texts = ["", "", ""];
    controls = [TextEditingController(), TextEditingController(), TextEditingController()];
    count = 3;
  }

  void setActive (int index) {
    if (index == -1) {
      keyboard = CrossFadeState.showSecond;
    }
    else {
      keyboard = CrossFadeState.showFirst;
    }
    keyboardStateFunction();
    active = index;
  }

  void clear ({int? index}) {
    texts[index ?? active] = "";
    controls[index ?? active].clear();
    textControl.clear();
  }

  void clearAll () {
    for (int i = 0; i < count; i++) {
      texts[i] = "";
      controls[i].clear();
    }
  }

  void backspace ({int? index}) {
    texts[index ?? active] = texts[index ?? active].substring(0, (texts[index ?? active].isNotEmpty) ? (texts[index ?? active].length - 1) : 0);
    controls[index ?? active].text = texts[index ?? active];
    controls[index ?? active].selection = TextSelection.fromPosition(TextPosition(offset: controls[index ?? active].text.length));
  }

  void add (String char, {int? index}) {
    texts[index ?? active] = texts[index ?? active] + char;
    controls[index ?? active].text = texts[index ?? active];
    controls[index ?? active].selection = TextSelection.fromPosition(TextPosition(offset: controls[index ?? active].text.length));
  }

  void setText (String input, {int? index}) {
    texts[index ?? active] = input;
    controls[index ?? active].text = input;
    controls[index ?? active].selection = TextSelection.fromPosition(TextPosition(offset: controls[index ?? active].text.length));
  }

  void setShow () {
    show = true;
  }

  void setHide () {
    show = false;
  }

  void toggleShow () {
    show = !show;
  }
}