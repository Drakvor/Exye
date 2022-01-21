import 'package:exye_app/utils.dart';
import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  final Widget child;
  const AppPage(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final pop = await app.mPage.pageNav.currentState!.maybePop();
        if (pop) {
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          app.mApp.input.setActive(-1);
        },
        child: Scaffold(
          backgroundColor: app.mResource.colours.background,
          body: child,
        ),
      ),
    );
  }
}
