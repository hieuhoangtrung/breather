import 'package:breather/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;

  TopContainer({this.height, this.width, this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    const radius = 40.0;

    return Container(
      padding:
          padding != null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          // color: LightColors.kDarkYellow,
          gradient: LinearGradient(
            colors: [LightColors.kGreen, LightColors.kSeaGreen],
            stops: [0.01, 0.99],
            begin: Alignment(-1.00, 0.00),
            end: Alignment(1.00, 0.00),
          ),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(radius),
            bottomLeft: Radius.circular(radius),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
