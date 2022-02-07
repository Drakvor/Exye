import 'package:flutter/cupertino.dart';

class FontResources {
  final TextStyle base = const TextStyle(fontFamily: "Spoqa", fontSize: 14, fontWeight: FontWeight.w400);
  final TextStyle bold = const TextStyle(fontFamily: "Spoqa", fontSize: 14, fontWeight: FontWeight.w500);
  final TextStyle thick = const TextStyle(fontFamily: "Spoqa", fontSize: 14, fontWeight: FontWeight.w700);
  final TextStyle small = const TextStyle(fontFamily: "Spoqa", fontSize: 12, fontWeight: FontWeight.w400);
  final TextStyle smallInactive = const TextStyle(fontFamily: "Spoqa", fontSize: 12, fontWeight: FontWeight.w400, color: Color(0x88000000));
  final TextStyle paragraph = const TextStyle(fontFamily: "Spoqa", fontSize: 14, fontWeight: FontWeight.w300);
  final TextStyle header = const TextStyle(fontFamily: "Spoqa", fontSize: 16, fontWeight: FontWeight.w700);
  final TextStyle headerLarge = const TextStyle(fontFamily: "Spoqa", fontSize: 18, fontWeight: FontWeight.w700);
  final TextStyle headerLight = const TextStyle(fontFamily: "Spoqa", fontSize: 18, fontWeight: FontWeight.w300);
  final TextStyle title = const TextStyle(fontFamily: "Spoqa", fontSize: 28, fontWeight: FontWeight.w700);
  final TextStyle smallThick = const TextStyle(fontFamily: "Spoqa", fontSize: 11, fontWeight: FontWeight.w700);
  final TextStyle smaller = const TextStyle(fontFamily: "Spoqa", fontSize: 11, fontWeight: FontWeight.w400);

  final TextStyle inactiveStrike = const TextStyle(fontFamily: "Spoqa", fontSize: 14, fontWeight: FontWeight.w400, color: Color(0x88000000));

  //buttons
  final TextStyle bWhite = const TextStyle(color: Color(0xffffffff));

  //calendar
  final TextStyle inactive = const TextStyle(fontFamily: "Spoqa", fontSize: 14, fontWeight: FontWeight.w400, color: Color(0x88000000));
}