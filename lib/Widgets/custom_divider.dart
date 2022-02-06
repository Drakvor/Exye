import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CustomHeaderDivider extends StatelessWidget {
  const CustomHeaderDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xff000000),
          ),
        ],
      ),
    );
  }
}

class CustomSizedDivider extends StatelessWidget {
  final double size;
  final double? thickness;
  const CustomSizedDivider(this.size, {this.thickness, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thickness ?? 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: thickness ?? 2,
            width: size,
            color: const Color(0xff000000),
          ),
        ],
      ),
    );
  }
}