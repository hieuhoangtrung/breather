import 'package:breather/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlantGardenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0.0028464142233133307, 0.25602471828460693),
              end: Alignment(0.6867927312850952, 0.5929393172264099),
              colors: [LightColors.kGreen, LightColors.kSeaGreen])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
          body: SafeArea(
              child: Center(
                  child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset(
                'assets/animations/botanist.json'),
          ),
          SizedBox(height: 50),
          Center(
              child: Text('We are working on it',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: LightColors.kWhite
                  )))
        ],
      )))),
    );
  }
}
