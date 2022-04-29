import 'package:flutter/material.dart';

class FilterOverlay extends StatelessWidget {
  const FilterOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: const Text("카테고리별 검색"),
        ),
        Row(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text("성별"),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text("상품군"),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text("스타일"),
                ),
                Row(
                  children: [
                    Column(),
                    Column(),
                  ],
                ),
              ],
            ),
          ],
        ),
        Container(),
      ],
    );
  }
}
