import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Color(0xffBF6469),
          Color(0xff6469D5),
        ],
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        stops: [0.0, .7],
      ).createShader(bounds),
      child: child,
    );
  }
}
