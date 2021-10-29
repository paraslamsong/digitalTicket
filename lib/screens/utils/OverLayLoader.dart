import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingAnimation(BuildContext context) {
  return Center(
    child: Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      child: CupertinoActivityIndicator(radius: 15),
    ),
  );
}
