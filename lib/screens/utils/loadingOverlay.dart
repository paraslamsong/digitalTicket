import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

abstract class Loader {
  factory Loader(BuildContext context) {
    return OverlayLoader(context);
  }
}

class OverlayLoader implements Loader {
  BuildContext context;
  bool _isDialogShowing = false;
  OverlayLoader(this.context);
  show() {
    print(_isDialogShowing);
    if (!_isDialogShowing) {
      _isDialogShowing = true;
      showDialog(
        barrierColor: Colors.transparent,
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Lottie.asset("assets/spinner.json",
                    height: 200, animate: true),
              ),
            ),
          ),
        ),
      );
    }
  }

  hide() {
    _isDialogShowing = false;
    Navigator.of(context).pop();
  }
}
