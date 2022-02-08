import 'package:exye_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppManager {
  FocusNode node = FocusNode();
  FocusNode node2 = FocusNode();
  AppTextManager input = AppTextManager();
  AppAuthManager auth = AppAuthManager();

  Future<void> buildAlertDialog (BuildContext context, String text) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(text),
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
  }

  void clearAll () {
    for (int i = 0; i < count; i++) {
      texts[i] = "";
      controls[i].clear();
    }
  }

  void backspace ({int? index}) {
    texts[index ?? active] = texts[index ?? active].substring(0, texts[index ?? active].length - 1);
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